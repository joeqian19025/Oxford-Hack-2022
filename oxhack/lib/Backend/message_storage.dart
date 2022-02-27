import 'message.dart';

class MessageStorage {
  List<nMessage> messages;

  MessageStorage() {
    messages = List<nMessage>();
  }

  bool addMessage(nMessage x) {
    messages.forEach((element) {
      if (element.messageID() == x.messageID()) return false;
    });

    messages = [x] + messages;
    return true;
  }
}
