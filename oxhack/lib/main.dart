import 'dart:math';
import 'package:flutter/material.dart';
import 'package:oxhack/Backend/contact.dart';
import 'Backend/communication.dart';
import 'Backend/message_storage.dart';
import 'UI/home_page.dart';
import 'UI/posts_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MessageStorage storage = MessageStorage();
    MessageExchange exchange = MessageExchange(messageStorage: storage);
    Contact contact = Contact();
    exchange.init();
    String user_name = this.hashCode.toString();
    int uid = this.hashCode;
    contact.add(user_name, uid);
    return MaterialApp(
        title: 'Broadcast',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: PostsPage(
            message_storage: storage, contact: contact, exchange: exchange));
  }
}
