import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final textController = TextEditingController();
  String message = '';

  void sendMessage() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final data =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    FirebaseFirestore.instance.collection('chats').add({
      'text': message.trim(),
      'date': Timestamp.now(),
      'userId': userId,
      'username': data['username'],
      'imageurl': data['imageurl']
    });

    // ignore: use_build_context_synchronously
    FocusScope.of(context).unfocus();
    textController.clear();
    message = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      padding: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(children: [
          Expanded(
              child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    label: Text('Send a message...'),
                  ),
                  onChanged: (value) {
                    setState(() {
                      message = value;
                    });
                  })),
          IconButton(
              onPressed: message.trim().isEmpty ? null : sendMessage,
              icon: const Icon(Icons.send))
        ]),
      ),
    );
  }
}
