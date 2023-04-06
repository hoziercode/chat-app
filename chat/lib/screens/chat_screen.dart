// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late User loggedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  static const id = 'chat-screen';

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _fireStoreCloud = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  late String messageText;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      // ignore: await_only_futures
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void getMessages() async {
    await for (var snapshat
        in _fireStoreCloud.collection('messages').snapshots()) {
      for (var message in snapshat.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageBuilder(fireStoreCloud: _fireStoreCloud),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      messageTextController.clear();
                      //Implement send functionality.
                      _fireStoreCloud.collection('messages').add(
                        {
                          'text': messageText,
                          'sender': loggedInUser.email,
                        },
                      );
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBuilder extends StatelessWidget {
  const MessageBuilder({
    super.key,
    required FirebaseFirestore fireStoreCloud,
  }) : _fireStoreCloud = fireStoreCloud;

  final FirebaseFirestore _fireStoreCloud;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageWidgets = [];
        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final currentUser = loggedInUser.email;

          if (currentUser == messageSender) {}

          final messageWidget = MessageBubble(
            messageText: messageText,
            messageSender: messageSender,
            isMe: currentUser == messageSender,
          );

          messageWidgets.add(messageWidget);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageWidgets,
          ),
        );
      },
      stream: _fireStoreCloud.collection('messages').snapshots(),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.messageText,
    required this.messageSender,
    this.isMe,
  });

  final String? messageText;
  final String? messageSender;
  final bool? isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment:
            isMe ?? true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            messageSender.toString(),
            style: const TextStyle(color: Colors.black54, fontSize: 12.0),
          ),
          Material(
            borderRadius: isMe ?? true ? const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ) : const BorderRadius.only(
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),),
            elevation: 5.0,
            color: isMe ?? true ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                messageText.toString(),
                style: TextStyle(
                  fontSize: 15.0,
                  color: isMe ?? true ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
