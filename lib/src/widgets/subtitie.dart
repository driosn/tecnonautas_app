import 'package:flutter/material.dart';

class SubTitle extends StatelessWidget {
  
  final String mText;
  final Color mColor;

  SubTitle({@required this.mText, @required this.mColor});
  
  @override
  Widget build(BuildContext context) {
    return Text(
      mText,
      style: TextStyle(
        color: mColor,
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),
    );
  }
}