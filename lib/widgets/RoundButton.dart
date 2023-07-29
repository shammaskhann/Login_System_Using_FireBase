import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  const RoundButton({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 50,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.deepPurple, borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
