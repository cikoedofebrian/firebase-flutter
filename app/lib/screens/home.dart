import 'package:app/widgets/chats.dart';
import 'package:app/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                  child: Text("Log out"),
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
        body: Column(children: const [
          Expanded(child: Chats()),
          NewMessages(),
        ]));
  }
}
