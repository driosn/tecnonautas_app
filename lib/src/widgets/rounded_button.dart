import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class RoundedButton extends StatelessWidget {
  
  final double mHeight;
  final double mWidth;
  final String mText;
  final Color mTextColor;
  final Color mColor;
  final double mRadius;

  RoundedButton({
    @required this.mHeight,
    @required this.mWidth,
    @required this.mText,
    this.mTextColor = Colors.black,
    this.mColor = lightButton,
    @required this.mRadius
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mHeight,
      width: mWidth,
      decoration: BoxDecoration(
        color: mColor,
        borderRadius: BorderRadius.circular(mRadius)
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(mText),
      ),
    );
  }
}