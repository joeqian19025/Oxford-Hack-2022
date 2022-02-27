import 'package:flutter/material.dart';
import 'package:oxhack/Backend/contact.dart';

import 'message_page.dart';

class ContactPage extends StatefulWidget {
  ContactPage({Key key, this.contact}) : super(key: key);
  Contact contact;

  @override
  _ContactPage createState() => _ContactPage();
}

class _ContactPage extends State<ContactPage> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contacts"),
        ),
        body: ListView.builder(
            itemCount: widget.contact.list.length,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(widget.contact.list[index]['name']),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MessagePage(
                                recieverid: widget.contact.list[index]['name'],
                              )));
                },
              );
            }));
  }
}
