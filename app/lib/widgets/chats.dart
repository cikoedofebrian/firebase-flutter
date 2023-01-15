import 'package:cloud_firestore/cloud_firestore.dart';
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
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: ((context, index) {
            return Text(snapshot.data!.docs[index]['text']);
          }),
        );
      }),
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy('date')
          .snapshots(),
    );
  }
}
