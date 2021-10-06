import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/alert_dialog.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class ForgetPass extends StatefulWidget {
  static const routeName = '/Forget';
  const ForgetPass({Key? key}) : super(key: key);

  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  final _auth = FirebaseAuth.instance;
  ShowDialogs _showDialogs = ShowDialogs();
  bool _isLoading = false;

  Future resetPass() async {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        await _auth.sendPasswordResetEmail(
          email: _email.trim().toLowerCase(),
        );
      } on FirebaseAuthException catch (error) {
        _showDialogs.authErrorHandler(error.message!, context);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Forget Password?',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Form(
              key: _formKey,
              child: TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).backgroundColor,
                    prefixIcon: Icon(Icons.email_sharp),
                    border: const UnderlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter Email Address'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(horizontal: 28),
                    ),
                    onPressed: resetPass,
                    icon: Icon(FontAwesome.key),
                    label: Text('Reset Password'),
                  ),
          ),
        ],
      ),
    );
  }
}
