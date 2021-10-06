import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_store_app/consts/alert_dialog.dart';

import 'package:flutter_store_app/consts/app_colors.dart';
import 'package:flutter_store_app/consts/curved_clipper.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  String _emailAddress = '';
  String _password = '';
  String _name = '';
  int? _phoneNumber;
  File? _pickedImage;
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  ShowDialogs _showDialogs = ShowDialogs();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? imgUrl = '';
  bool _isLoading = false;
  

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  void _formSubmit() async {
    final isValid = _formKey.currentState!.validate();
    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var dateFormat = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      try {
        if (_pickedImage == null) {
          _showDialogs.authErrorHandler('Pick an image', context);
        } else {
          setState(() {
            _isLoading = true;
          });
          final ref = FirebaseStorage.instance
              .ref()
              .child('userImage')
              .child(_name + '.jpg');
          await ref.putFile(_pickedImage!);
          imgUrl = await ref.getDownloadURL();
          await _auth.createUserWithEmailAndPassword(
            email: _emailAddress.toLowerCase().trim(),
            password: _password.trim(),
          );
          final User? user = _auth.currentUser;
          final _uid = user!.uid;
          user.updatePhotoURL(imgUrl);
          user.updateDisplayName(_name);
          user.reload();
          _firestore.collection('users').doc(_uid).set({
            'id': _uid,
            'name': _name,
            'email': _emailAddress,
            'password': _password,
            'phoneNumber': _phoneNumber,
            'imageUrl': imgUrl,
            'joinedAt': dateFormat,
            'createdAt': Timestamp.now(),
          });

          while (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }
      } on FirebaseAuthException catch (error) {
        _showDialogs.authErrorHandler(error.message!, context);
        print('error occurred ${error.message}');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  
  Future pickImageFromCamera() async {
    
    final cImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );
   // if(cImage == null) return;

    final pickedImageFile = File(cImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  Future pickImageFromGallery() async {
    
    final gImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    //if (gImage == null) return;
    final pickedImageFile = File(gImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void cancelImage() {
    setState(() {
      _pickedImage = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: CurvedClipper(),
                    child: Container(
                      color: Colors.orange,
                      height: size.height / 1.1,
                      width: double.infinity,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: size.height / 20,
                      ),
                      Container(
                        child: CircleAvatar(
                          radius: 57,
                          backgroundColor: ColorsConsts.gradiendFEnd,
                          backgroundImage: (_pickedImage == null)
                              ? null
                              : FileImage(_pickedImage!)
                        ),
                      ),
                      SizedBox(
                        height: size.height / 15,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                key: ValueKey(
                                  'name',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter a valid name';
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_emailFocusNode),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  filled: true,
                                  prefixIcon: Icon(Icons.person),
                                  labelText: 'User Name',
                                  fillColor: Theme.of(context).backgroundColor,
                                ),
                                onSaved: (value) {
                                  _name = value!;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                key: ValueKey(
                                  'email',
                                ),
                                focusNode: _emailFocusNode,
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return 'Please Enter a valid Email Address';
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  filled: true,
                                  prefixIcon: Icon(Icons.email),
                                  labelText: 'Email Address',
                                  fillColor: Theme.of(context).backgroundColor,
                                ),
                                onSaved: (value) {
                                  _emailAddress = value!;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                obscureText: _obscureText,
                                key: ValueKey(
                                  'password',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 7) {
                                    return 'Please Enter a valid password';
                                  }
                                  return null;
                                },
                                focusNode: _passwordFocusNode,
                                keyboardType: TextInputType.visiblePassword,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_phoneNumberFocusNode),
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  filled: true,
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  labelText: 'Password',
                                  fillColor: Theme.of(context).backgroundColor,
                                ),
                                onSaved: (value) {
                                  _password = value!;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                key: ValueKey(
                                  'phone',
                                ),
                                focusNode: _phoneNumberFocusNode,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter a valid Phone Number';
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => _formSubmit(),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  filled: true,
                                  prefixIcon: Icon(Icons.phone_android),
                                  labelText: 'Phone Number',
                                  fillColor: Theme.of(context).backgroundColor,
                                ),
                                onSaved: (value) {
                                  _phoneNumber = int.parse(value!);
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _isLoading
                                    ? CircularProgressIndicator()
                                    : ElevatedButton(
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.symmetric(
                                                  horizontal: 30,
                                                  vertical: 20)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.pink.shade400),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              side: BorderSide(
                                                  color: ColorsConsts
                                                      .backgroundColor),
                                            ),
                                          ),
                                        ),
                                        onPressed: _formSubmit,
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: TextButton(
                                  onPressed: () {
                                    // Navigator.pushNamed(
                                    //     context, ForgetPassword.routeName);
                                  },
                                  child: Text(
                                    'Forget password?',
                                    style: TextStyle(
                                        color: Colors.blue.shade900,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 117,
                    left: 139,
                    right: 90,
                    child: RawMaterialButton(
                      fillColor: ColorsConsts.gradiendLEnd,
                      shape: CircleBorder(),
                      elevation: 10,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Choose an image',
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      imageOption('Camera', Icons.camera,
                                          pickImageFromCamera),
                                      imageOption('Gallery', Icons.image,
                                          pickImageFromGallery),
                                      imageOption(
                                          'Remove', Icons.remove, cancelImage),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Icon(Icons.add_a_photo),
                      padding: EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell imageOption(String title, IconData icon, Function fn) {
    return InkWell(
      onTap: () {
        fn();
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Colors.redAccent,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorsConsts.title,
            ),
          ),
        ],
      ),
    );
  }
}
