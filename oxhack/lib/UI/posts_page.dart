import 'package:flutter/material.dart';
import 'package:oxhack/Backend/contact.dart';
import 'dart:collection';
import 'package:oxhack/Backend/communication.dart';
import 'package:oxhack/UI/message_page.dart';
import '../Backend/message_storage.dart';
import 'contact_page.dart';
import 'home_page.dart';

class PostsPage extends StatefulWidget {
  PostsPage({this.message_storage, this.contact, this.exchange});
  MessageStorage message_storage;
  Contact contact;
  MessageExchange exchange;

  @override
  _PostsPage createState() => new _PostsPage();
}

class _PostsPage extends State<PostsPage> {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.post_add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            title: "Broadcast",
                            uid: 1,
                            message_storage: widget.message_storage,
                            exchange: widget.exchange,
                          )),
                );
              }),
          title: Text("Posts"),
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {});
                })
          ],
        ),
        body: ListView.builder(
            itemCount: widget.message_storage.messages.length,
            itemBuilder: (BuildContext context, int index) {
              print(widget.message_storage.messages[index].messageID());
              return Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      color: Colors.green[100]),
                  child: Center(
                      child: ListTile(
                    title: Text(
                        widget.message_storage.messages[index].message['name']),
                    trailing: widget.message_storage.messages[index]
                                .message['bleed'] ==
                            "true"
                        ? Icon(
                            Icons.add_alert,
                            color: Colors.red,
                          )
                        : null,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MessagePage(
                                    recieverid: widget.message_storage
                                        .messages[index].message['name'],
                                    text: widget.message_storage.messages[index]
                                        .message['message'],
                                  )));
                    },
                  )));
            }));
  }
}
