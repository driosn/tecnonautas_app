import 'package:flutter/material.dart';

class TecnonautasButton extends StatelessWidget {
  
  final double mHeight;
  final double mWidth;
  final Widget mText;
  final Color mColor;
  final double mRadius;
  final Function mOnPressed;

  TecnonautasButton({
    this.mHeight,
    this.mWidth,
    @required this.mText,
    @required this.mColor,
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
          color: mColor,
          borderRadius: BorderRadius.circular(mRadius),
          boxShadow: <BoxShadow> [
            BoxShadow(color: Colors.black12, offset: Offset(1, 1), blurRadius: 10, spreadRadius: 1)
          ]
        ),
      ),
    );
  }
}