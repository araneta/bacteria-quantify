import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BigRoundButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const BigRoundButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 325, // <-- Your width
        height: 53, // <-- Your height
        child: ElevatedButton(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                fontSize: 14.0, fontWeight: FontWeight.bold, letterSpacing: 1)),
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0XFF4FA6CB)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              // side: BorderSide(color: Colors.red)
            )),
          ),
          onPressed: onTap,
          child: Wrap(
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600, height: 1.5)),
            ],
          ),
        ));
  }
}
