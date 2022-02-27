import 'dart:convert';
import 'package:crypto/crypto.dart';

class nMessage {
  int senderId;
  DateTime sendTime;
  int priority;
  var message;

  String toJson() {
    return jsonEncode({
      "senderId": senderId,
      "sendTime": sendTime.toString(),
      "priority": priority,
      "message": message
    });
  }

  nMessage({this.senderId, this.sendTime, this.message, this.priority});

  int messageID() {
    return md5.convert(utf8.encode(message.toString())).hashCode;
  }

  String toPost() {
    String post = '';
    this
        .message
        .forEach((k, v) => post += k.toString() + ': ' + v.toString() + '\n');
    return post;
  }
}
