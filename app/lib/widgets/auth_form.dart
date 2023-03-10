import 'dart:io';

import 'package:app/widgets/image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(
      {super.key, required this.submitForm, required this.isLoading});
  final bool isLoading;
  final void Function(String email, String username, String password,
      bool isLogin, BuildContext ctx, File? image) submitForm;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  void _onSubmit() {
    final valid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_image == null && !_islogin) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Photo cant be empty'),
        backgroundColor: Colors.black,
      ));
      return;
    }
    if (valid) {
      _formKey.currentState!.save();
      widget.submitForm(_email, _username, _password, _islogin, context,
          _image != null ? File(_image!.path) : null);
    }
  }

  void _imagePick(File image) {
    _image = image;
  }

  bool _islogin = true;
  String _username = '';
  String _password = '';
  String _email = '';
  File? _image;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 40),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_islogin) ProfilePicker(imagePick: _imagePick),
                  TextFormField(
                    key: const ValueKey('email'),
                    onSaved: (newValue) {
                      _email = newValue!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please input an email";
                      } else if (!value.contains('@') ||
                          !value.endsWith('.com')) {
                        return "Please input a valid email";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      label: Text('Email'),
                    ),
                  ),
                  if (!_islogin)
                    TextFormField(
                      key: const ValueKey('Username'),
                      onSaved: (newValue) {
                        _username = newValue!;
                      },
                      decoration: const InputDecoration(
                        label: Text('Username'),
                      ),
                      validator: (value) {
                        if (value!.length < 4) {
                          return "A username has minimum length of 4";
                        }
                        return null;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    onSaved: (newValue) {
                      _password = newValue!;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      label: Text('Password'),
                    ),
                    validator: (value) {
                      if (value!.length < 4) {
                        return "A password has minimum length of 7";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _islogin = !_islogin;
                            });
                          },
                          child: _islogin == true
                              ? const Text('Sign Up')
                              : const Text('Login'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _onSubmit();
                          },
                          child: _islogin == true
                              ? const Text('Login')
                              : const Text('Sign Up'),
                        ),
                      ],
                    )
                ],
              )),
        ),
      ),
    );
  }
}
