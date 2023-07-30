import 'package:flutter/material.dart';
import 'package:src/login.dart';

import 'homePage.dart';

class LoginAuth extends StatefulWidget {
  const LoginAuth({super.key});
  static bool isLoggedin = false;
  @override
  State<LoginAuth> createState() => _LoginAuthState();
}

class _LoginAuthState extends State<LoginAuth> {
  @override
  Widget build(BuildContext context) {
    return LoginAuth.isLoggedin == true
        ? MyHomePage(title: "Termins")
        : Login();
  }
}
