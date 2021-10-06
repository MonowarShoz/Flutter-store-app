import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/alert_dialog.dart';
import 'package:flutter_store_app/consts/app_colors.dart';
import 'package:flutter_store_app/consts/curved_clipper.dart';
import 'package:flutter_store_app/provider/dark_theme.dart';
import 'package:flutter_store_app/screens/auth/forget_pass.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String _emailAddress = '';
  String _password = '';
  final FocusNode _passwordFocusNode = FocusNode();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  ShowDialogs _showDialogs = ShowDialogs();
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _formSubmit() async {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        await _auth
            .signInWithEmailAndPassword(
              email: _emailAddress.toLowerCase().trim(),
              password: _password.trim(),
            )
            .then((value) =>
                Navigator.canPop(context) ? Navigator.pop(context) : null);
      } on FirebaseAuthException catch (error) {
        _showDialogs.authErrorHandler(error.message!, context);
        print('Error occured ${error.message}');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: themeState.darkTheme
              ? Colors.blueGrey
              : ColorsConsts.backgroundColor,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: CurvedClipper(),
                    child: Container(
                      height: size.height / 2.3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://image.flaticon.com/icons/png/128/869/869636.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey(
                              'email',
                            ),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please Enter a valid email';
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
                            onEditingComplete: _formSubmit,
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.pink.shade400),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          side: BorderSide(
                                              color:
                                                  ColorsConsts.backgroundColor),
                                        ),
                                      ),
                                    ),
                                    onPressed: _formSubmit,
                                    child: Text(
                                      'Login',
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
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ForgetPass.routeName);
                              },
                              child: Text(
                                'Forget password?',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: themeState.darkTheme
                                        ? Colors.orangeAccent
                                        : Colors.blue,
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
            ],
          ),
        ),
      ),
    );
  }
}
