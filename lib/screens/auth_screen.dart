import 'package:flutter/material.dart';
import 'file:///F:/work/fluter/grocery_shopping/lib/providers/auth.dart';
import 'package:grocery_shopping/models/http_exception.dart';
import 'package:grocery_shopping/widgets/tab_bar_homepage.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const routeId = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

enum AuthMode { signUp, LogIn }

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthMode _authMode = AuthMode.LogIn;
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  Future<void> _submit()async{
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.LogIn) {
        await Provider.of<Auth>(context, listen: false).signIn(
//        _authData['name'],
          _authData['email'],
          _authData['password'],
        );
        Navigator.of(context).pushNamed(TabBarHomePage.routeId);
      } else {
        await Provider.of<Auth>(context, listen: false).registration(
//        _authData['name'],
          _authData['email'],
          _authData['password'],
        );
      }
    }on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(errorMessage),backgroundColor: Colors.red,));
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
     _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(errorMessage),backgroundColor: Colors.red,));
    }
    setState(() {
      _isLoading = false;
    });
  }
  void _switchMode() {
    if (_authMode == AuthMode.LogIn) {
      setState(() {
        _authMode = AuthMode.signUp;
      });
//      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.LogIn;
      });
//      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Text(
                          "${_authMode == AuthMode.signUp ? 'Sign in' : 'Sign up'}",
                          style: TextStyle(
                            fontSize: 25,
                            color: Color(0xff6E7989),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: _switchMode,
                      ),
                      Text(
                        "${_authMode == AuthMode.LogIn ? 'Sign in' : 'Sign up'}",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color(0xff29C17E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Welcome to Grocery App',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          enabled: _authMode == AuthMode.signUp,
                          decoration: InputDecoration(hintText: "Name"),
                          keyboardType: TextInputType.name,
                          // ignore: missing_return
                          validator: (val) {
                            if (val.isEmpty && !val.contains('@')) {
                              return "Please Enter Valid Email";
                            }
                          },
                          onSaved: (save) {
                            _authData['email'] = save;
                          },
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(hintText: "Email address"),
                          keyboardType: TextInputType.emailAddress,
                          // ignore: missing_return
                          validator: (val) {
                            if (val.isEmpty && !val.contains('@')) {
                              return "Please Enter Valid Email";
                            }
                          },
                          onSaved: (save) {
                            _authData['email'] = save;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Password"),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          // ignore: missing_return
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please Enter a Password";
                            } else if (val.length < 5) {
                              return "Too short Password";
                            }
                          },
                          onSaved: (save) {
                            _authData['password'] = save;
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _authMode == AuthMode.LogIn
                                ? GestureDetector(
                                  child: Text(
                                      "Forgot password?",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Color(0xff6E7989),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                onTap: (){},
                                )
                                : Text(""),
                            RaisedButton(
                              child: Text(
                                "${_authMode == AuthMode.LogIn ? 'Sign in' : 'Sign up'}",
                              ),
                              onPressed: _submit,
                              color: Color(0xff29C17E),
                              textColor: Colors.white,
                            ),
                            RaisedButton(
                              child: Text(
                                "google",
                              ),
                              onPressed: () async{
                               await Provider.of<Auth>(context,listen: false).signInWithGoogle();
                                Navigator.of(context).pushReplacementNamed(TabBarHomePage.routeId);
                              },
                              color: Color(0xff29C17E),
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
