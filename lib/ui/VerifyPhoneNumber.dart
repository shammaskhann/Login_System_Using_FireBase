import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'HomeScreen.dart';

class VerifyPhoneNumber extends StatefulWidget {
  final String verificationId;
  const VerifyPhoneNumber({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<VerifyPhoneNumber> createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Verify"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Verify Phone Number",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40.0,
              ),
              TextFormField(
                controller: otp,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter OTP 6-digit CODE ",
                  suffixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });
                    auth
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: otp.text))
                        .then((value) => {
                              Utils().toastMessage("Login Successful"),
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen())),
                              setState(() {
                                loading = false;
                              }),
                            })
                        // ignore: body_might_complete_normally_catch_error
                        .catchError((e) {
                      Utils().toastMessage(e.toString());
                      setState(() {
                        loading = false;
                      });
                    });
                  },
                  child: const Text("Verify"))
            ],
          ),
        ));
  }
}
