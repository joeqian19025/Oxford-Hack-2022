import 'dart:convert';
import 'package:crypto/crypto.dart';

class Message {
  int senderId;
  DateTime sendTime;
  int priority;
  var message;
  int msID;

  bool operator <(Message a) {
    if (this.priority != a.priority) {
      return this.priority < a.priority;
    } else {
      return this.sendTime.isAfter(a.sendTime);
    }
  }

  int messageID() {
    return md5.convert([senderId] + utf8.encode(sendTime.toString())).hashCode;
  }
}
