import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import '../widgets/RoundButton.dart';
import 'VerifyPhoneNumber.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool loading = false;
    final auth = FirebaseAuth.instance;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login With Phone Number"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Login With Phone Number",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40.0,
              ),
              TextFormField(
                controller: phoneNumber,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "+01 123 4567 890",
                  suffixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              RoundButton(
                  title: "Login",
                  loading: loading,
                  onTap: () {
                    setState(() {
                      loading = true;
                    });
                    auth.verifyPhoneNumber(
                        phoneNumber: phoneNumber.text,
                        verificationCompleted: (e) {
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage("Verification Completed");
                        },
                        verificationFailed: (e) {
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage(e.message!);
                        },
                        codeSent: (String verificationId, int? token) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifyPhoneNumber(
                                        verificationId: verificationId,
                                      )));
                          setState(() {
                            loading = false;
                          });
                        },
                        codeAutoRetrievalTimeout: (e) {
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage(e);
                        });
                  })
            ],
          ),
        ));
  }
}
