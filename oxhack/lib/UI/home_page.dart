import 'package:flutter/material.dart';
import '../Backend/communication.dart';
import '../Backend/message.dart';
import '../Backend/message_storage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage(
      {Key key, this.title, this.uid, this.message_storage, this.exchange})
      : super(key: key);
  final String title;
  final int uid;
  final MessageExchange exchange;
  final MessageStorage message_storage;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var name_controller = TextEditingController();
  var message_controller = TextEditingController();
  bool is_bleed = false;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
            autofocus: true,
            controller: name_controller,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Post Name',
            ),
          ),
          TextFormField(
            autofocus: true,
            controller: message_controller,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Your Post',
            ),
            maxLines: 10,
            minLines: 5,
          ),
          CheckboxListTile(
              title: Text('Did you get injured?'),
              value: is_bleed,
              onChanged: (a) => setState(() => is_bleed = a)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(elevation: 2),
            onPressed: () {
              print(TextEditingController().text);
              nMessage msg = nMessage(
                  senderId: widget.uid,
                  sendTime: DateTime.now(),
                  message: {
                    'name': name_controller.text,
                    'message': message_controller.text,
                    'bleed': is_bleed.toString()
                  });
              widget.message_storage.addMessage(msg);
              widget.exchange.send2Peers(msg);
              name_controller.clear();
              message_controller.clear();
              is_bleed = false;
              Navigator.pop(context);
              setState(() {});
            },
            child: Text('Publish'),
          )
        ],
      ),
    );
  }
}
