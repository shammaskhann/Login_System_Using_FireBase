import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/utils.dart';
import '../widgets/RoundButton.dart';
import 'HomeScreen.dart';
import 'LoginWithPhoneNumber.dart';
import 'Signup_Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance; //Aunthentication instance

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(email: email.text, password: password.text)
        .then((value) => {
              Utils().toastMessage("Login Successful"),
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen())),
              setState(() {
                loading = false;
              }),
            })
        .catchError((e) {
      Utils().toastMessage(e.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //SystemNavigator.pop(); This command is used to exit the app
        // ignore: deprecated_member_use
        return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text("Do you want to exit the app?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text("No")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text("Yes")),
                  ],
                ));
      },
      child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false, title: const Text("Login")),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          suffixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: password,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Password",
                          suffixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter password";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                RoundButton(
                  title: "Login",
                  loading: loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signup_Screen()));
                      },
                      child: const Text('Sign up'),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const LoginWithPhoneNumber()));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Text(
                        "Login with Phone Number",
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
