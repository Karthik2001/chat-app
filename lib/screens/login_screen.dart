import 'dart:convert';

import 'package:chat_app/components/rounded_button.dart';
import 'package:chat_app/network_utils/api.dart';
import 'package:chat_app/screens/loding.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (emailValue) {
                        if (emailValue.isEmpty) {
                          return 'Please enter email';
                        }
                        email = emailValue;
                        return null;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: "Enter Email",
                      ),
                    ),
                    SizedBox(
                      height: 11.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (passwordValue) {
                        if (passwordValue.isEmpty) {
                          return 'Please enter some text';
                        }
                        password = passwordValue;
                        return null;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: "Enter Password",
                      ),
                    ),
                    SizedBox(
                      height: 11.0,
                    ),
                    RoundedButton(
                      colour: Colors.lightBlueAccent,
                      buttonText: 'Log In',
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _login();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'email': email, 'password': password};

    var res = await Network().authData(data, '/login');
    var body = json.decode(res.body);
    print(body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
