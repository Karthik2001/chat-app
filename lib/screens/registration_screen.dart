import 'dart:convert';

import 'package:chat_app/components/rounded_button.dart';
import 'package:chat_app/network_utils/api.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'loding.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
  String fName;
  String lName;
  String number;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

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
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          fName = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter First Name';
                          }
                          fName = value;
                          return null;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: "Enter First Name",
                        ),
                      ),
                      SizedBox(
                        height: 11.0,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          lName = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Last Name';
                          }
                          lName = value;
                          return null;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: "Enter Last Name",
                        ),
                      ),
                      SizedBox(
                        height: 11.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          number = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Number';
                          }
                          number = value;
                          return null;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: "Enter Phone Number",
                        ),
                      ),
                      SizedBox(
                        height: 11.0,
                      ),
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
                        buttonText: 'Register',
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _register();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void _register() async {
    print("yes");
    setState(() {
      //_isLoading = true;
    });
    var data = {
      'email': "adfrdfs@gmail.com",
      'password': password,
      'phone': '8084441194',
      'fname': fName,
      'lname': lName
    };

    var res = await Network().authData(data, '/register');

    var body = json.decode(res.body);
    print(body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      setState(() {
        _isLoading = false;
      });
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
