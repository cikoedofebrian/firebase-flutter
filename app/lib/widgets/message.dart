import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message(
      {super.key,
      required this.message,
      required this.isUser,
      required this.messagekey,
      required this.username});
  final String message;
  final String username;
  final bool isUser;
  final String messagekey;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: ValueKey(messagekey),
      mainAxisAlignment:
          !isUser ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          width: message.length > 40 ? 300 : null,
          decoration: BoxDecoration(
              color: !isUser ? Colors.grey[300] : Colors.green,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: isUser
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  bottomRight: isUser
                      ? const Radius.circular(0)
                      : const Radius.circular(12))),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Column(
            crossAxisAlignment:
                isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: isUser
                    ? const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)
                    : const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                message,
                style: isUser
                    ? const TextStyle(color: Colors.white)
                    : const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
