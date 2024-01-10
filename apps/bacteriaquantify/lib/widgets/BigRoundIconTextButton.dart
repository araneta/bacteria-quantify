import 'package:flutter/material.dart';

class BigRoundIconTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final AssetImage icon;
  final String title;

  const BigRoundIconTextButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
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
              Image(image: icon),
              SizedBox(
                width: 16,
              ),
              Text(title,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600, height: 1.5)),
            ],
          ),
        ));
  }
}
