import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/screens/main_page_screen.dart';
import 'package:flutter_store_app/screens/starting_screen.dart';

class UserStates extends StatelessWidget {
  const UserStates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (userSnapshot.connectionState == ConnectionState.active) {
          if (userSnapshot.hasData) {
            print('User is already logged in');
            return MainScreen();
          } else {
            print('user didn\'t log in yet');
            return StartingScreen();
          }
        } else if (userSnapshot.hasError) {
          return Center(
            child: Text('Error Occured'),
          );
        }
        return Scaffold(
          body: Center(
            child: Text('Something went wrong'),
          ),
        );
      },
    );
  }
}
