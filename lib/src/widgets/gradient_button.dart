import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  
  final double mHeight;
  final double mWidth;
  final Widget mText;
  final List<Color> mColors;
  final double mRadius;
  final Function mOnPressed;

  GradientButton({
    this.mHeight,
    this.mWidth,
    @required this.mText,
    @required this.mColors,
    this.mRadius = 0,
    @required this.mOnPressed
  });
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: mOnPressed,
      child: Container(
        height: mHeight,
        width: mWidth,
        child: Center(child: mText),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: mColors
          ),
          borderRadius: BorderRadius.circular(mRadius),
          boxShadow: <BoxShadow> [
            BoxShadow(color: Colors.black26, offset: Offset(1, 1), blurRadius: 10, spreadRadius: 1)
          ]
        ),
      ),
    );
  }
}