import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BigRoundIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final AssetImage icon;

  const BigRoundIconButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        //width: 225, // <-- Your width
        height: 53, // <-- Your height
        child: ElevatedButton(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                fontSize: 14.0, fontWeight: FontWeight.bold, letterSpacing: 1)),
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0XFF2B8ACA)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              // side: BorderSide(color: Colors.red)
            )),
          ),
          onPressed: onTap,
          child: Wrap(
            children: <Widget>[
              Image(image: icon),
            ],
          ),
        ));
  }
}
