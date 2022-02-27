import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'dart:convert';
import 'message.dart';
import 'package:device_info/device_info.dart';
import 'message_storage.dart';
import 'dart:async';

class MessageExchange {
  NearbyService nearby = NearbyService();
  StreamSubscription subscription;
  StreamSubscription receivedDataSubscription;
  MessageStorage messageStorage;

  List<Device> devices = [];

  MessageExchange({this.messageStorage});

  void init() async {
    String devInfo = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    devInfo = iosInfo.localizedModel;

    await nearby.init(
        serviceType: 'mpconn',
        deviceName: devInfo,
        strategy: Strategy.P2P_CLUSTER,
        callback: (isRunning) async {
          if (isRunning) {
            await nearby.stopAdvertisingPeer();
            await nearby.stopBrowsingForPeers();
            await nearby.startAdvertisingPeer();
            await nearby.startBrowsingForPeers();
          }
        });

    subscription = nearby.stateChangedSubscription(callback: (devicesList) {
      devices = devicesList;
      devicesList.forEach((device) {
        print(
            " deviceId: ${device.deviceId} | deviceName: ${device.deviceName} | state: ${device.state}");
        if (device.state == SessionState.notConnected) {
          nearby.invitePeer(
            deviceID: device.deviceId,
            deviceName: device.deviceName,
          );
        }

        if (device.state == SessionState.connected) {
          messageStorage.messages.forEach((element) {
            nearby.sendMessage(device.deviceId, element.toJson());
          });
        }
      });
    });

    receivedDataSubscription =
        nearby.dataReceivedSubscription(callback: (data) {
      print("dataReceivedSubscription: ${jsonEncode(data)}");
      var newdata = jsonDecode(data["message"]); //jsonDecode(data.toString());
      print(newdata.runtimeType);
      messageStorage.addMessage(nMessage(
          senderId: newdata['senderId'],
          // sendTime: DateTime.parse(newdata["sendTime"]),
          message: newdata["message"],
          priority: newdata["priority"]));
    });
  }

  void send2Peers(nMessage x) {
    if (!devices.isEmpty) {
      devices.forEach((device) {
        nearby.sendMessage(device.deviceId, x.toJson());
      });
    }
  }
}
