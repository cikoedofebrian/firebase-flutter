import 'package:app/widgets/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final data = snapshot.data!.docs;
        final uid = FirebaseAuth.instance.currentUser!.uid;
        return ListView.builder(
          reverse: true,
          itemCount: data.length,
          itemBuilder: ((context, index) {
            return Message(
              username: data[index]['username'],
              message: data[index]['text'],
              isUser: data[index]['userId'] == uid ? true : false,
              messagekey: data[index].id,
            );
          }),
        );
      }),
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy('date', descending: true)
          .snapshots(),
    );
  }
}
