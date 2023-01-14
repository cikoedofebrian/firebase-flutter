import 'package:flutter/material.dart';
import '../widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  void _submitForm(
      String email, String username, String password, bool isLogin) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: AuthForm(submitForm: _submitForm),
    );
  }
}
