import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/alert_dialog.dart';
import 'package:flutter_store_app/consts/app_colors.dart';
import 'package:flutter_store_app/screens/auth/login_screen.dart';
import 'package:flutter_store_app/screens/auth/sign_up_screen.dart';
import 'package:flutter_store_app/screens/bottom_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  _StartingScreenState createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ShowDialogs _showDialogs = ShowDialogs();
  bool _isLoading = false;

  Future<void> _googleSignIn() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final authGoogle = await googleAccount.authentication;
      if (authGoogle.accessToken != null && authGoogle.idToken != null) {
        try {
          var date = DateTime.now().toString();
          var dateParse = DateTime.parse(date);
          var dateFormat =
              "${dateParse.day}-${dateParse.month}-${dateParse.year}";
          final _authResult =
              await _auth.signInWithCredential(GoogleAuthProvider.credential(
            accessToken: authGoogle.accessToken,
            idToken: authGoogle.idToken,
          ));
          final userCredential = _authResult.user!;
          await FirebaseFirestore.instance.collection('users').doc(userCredential.uid).set({
            'id': userCredential.uid,
            'name': userCredential.displayName,
            'email': userCredential.email,
            'phoneNumber': userCredential.phoneNumber,
            'imageUrl': userCredential.photoURL,
            'joinedAt': dateFormat,
            'createdAt': Timestamp.now(),


          });
          
        } on FirebaseAuthException catch (e) {
          _showDialogs.authErrorHandler(e.message!, context);
        }
      }
    }
  }

  void anonymousLogin() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _auth.signInAnonymously().then(
          (value) => Navigator.canPop(context) ? Navigator.pop(context) : null);
    } on FirebaseAuthException catch (error) {
      _showDialogs.authErrorHandler(error.message!, context);
      print('Error occured ${error.message}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://cdn.dribbble.com/users/5580014/screenshots/13859703/media/9505a3288810f3e457eed84a2e6adbd9.jpg?compress=1&resize=1200x900',
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Welcome to Store',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple.shade400),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side:
                                BorderSide(color: ColorsConsts.backgroundColor),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple.shade600),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side:
                                BorderSide(color: ColorsConsts.backgroundColor),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpScreen.routeName);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                  ),
                  Text(
                    'Or continue with',
                    style: TextStyle(color: Colors.black),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: _googleSignIn,
                    style: OutlinedButton.styleFrom(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(18),
                      shape: StadiumBorder(),
                      side: BorderSide(color: Colors.red, width: 2),
                    ),
                    child: Text(
                      'Google +',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : OutlinedButton(
                          onPressed: () {
                            anonymousLogin();
                            //Navigator.pushNamed(context, BottomBarScreen.routeName);
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.all(18),
                            shape: StadiumBorder(),
                            side: BorderSide(color: Colors.red, width: 2),
                          ),
                          child: Text('Sign in as a guest',
                              style: TextStyle(fontSize: 17)),
                        ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
