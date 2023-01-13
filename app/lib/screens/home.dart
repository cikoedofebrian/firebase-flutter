import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
