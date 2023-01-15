import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;
  void _submitForm(String email, String username, String password, bool isLogin,
      BuildContext ctx) async {
    setState(() {
      setState(() {
        _isLoading = true;
      });
    });
    try {
      if (isLogin) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        var authData = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authData.user!.uid)
            .set({'username': username, 'email': email});
      }
    } on FirebaseAuthException catch (err) {
      setState(() {
        _isLoading = false;
      });
      var message = "An error occured";
      if (err.message != null) {
        message = err.message!;
      }
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: AuthForm(submitForm: _submitForm, isLoading: _isLoading),
    );
  }
}
