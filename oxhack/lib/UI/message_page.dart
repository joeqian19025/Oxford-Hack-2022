import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key key, this.recieverid, this.text}) : super(key: key);

  String recieverid;
  String text;
  @override
  _MessagePage createState() => _MessagePage();
}

class _MessagePage extends State<MessagePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recieverid),
      ),
      body: Text(widget.text),
    );
  }
}
