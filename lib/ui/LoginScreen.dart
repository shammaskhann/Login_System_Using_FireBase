import 'package:flutter/material.dart';
import '../widgets/RoundButton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Login Screen")),
        body: Column(
          children: [
            RoundButton(title: "Login"),
          ],
        ));
  }
}
