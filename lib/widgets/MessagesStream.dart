import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/widgets/ChatBubble.dart';

class MessagesStream extends StatelessWidget {
  final Firestore firestore;

  MessagesStream({this.firestore});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        List<ChatBubble> messageWidgets = [];
        final messages = snapshot.data.documents;
        for (var message in messages) {
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];

          final messageWidget =
              ChatBubble(text: messageText, sender: messageSender);
          messageWidgets.add(messageWidget);
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}
