import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class RoundedButton extends StatelessWidget {
  
  final double mHeight;
  final double mWidth;
  final Widget mText;
  final Color mTextColor;
  final Color mColor;
  final double mRadius;
  final Function mOnPressed;

  RoundedButton({
    @required this.mHeight,
    @required this.mWidth,
    @required this.mText,
    this.mTextColor = Colors.black,
    this.mColor = lightButton,
    @required this.mRadius,
    @required this.mOnPressed
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: mHeight,
        width: mWidth,
        decoration: BoxDecoration(
          color: mColor,
          borderRadius: BorderRadius.circular(mRadius),
          boxShadow: <BoxShadow> [
            BoxShadow(
              offset: Offset(0, 0), 
              blurRadius: 3,
              spreadRadius: 1,
              color: lightGreyColor.withOpacity(0.5)
            )
          ]
        ),
        child: Align(
          alignment: Alignment.center,
          child: mText,
        ),
      ),
      onTap: mOnPressed,
    );
  }
}