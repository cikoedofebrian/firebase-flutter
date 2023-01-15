import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FChat"),
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("My Account"),
              ),
            ],
            onSelected: (value) {
              if (value == 0) {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/j6XrxgTG5dFTuHfygtvw/messages')
              .add({'text': 'this is from the button'});
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/j6XrxgTG5dFTuHfygtvw/messages')
            .snapshots(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) => Container(
                      child: Text(snapshot.data!.docs[index]['text']),
                    ),
                    itemCount: snapshot.data!.docs.length,
                  ),
      ),
    );
  }
}
