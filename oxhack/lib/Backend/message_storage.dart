import 'message.dart';

class MessageStorage {
  List<Message> messages = [];

  bool addMessage(Message x) {
    messages.add(x);
    return true;
  }
}
