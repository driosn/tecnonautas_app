import 'package:flutter/material.dart';

class TransparentContainer extends StatelessWidget {
  
  final double mHeight;
  final double mWidth;
  final EdgeInsetsGeometry mPadding;
  final EdgeInsetsGeometry mMargin;
  final Widget mChild;

  TransparentContainer({
    this.mHeight, 
    this.mWidth,
    this.mPadding,
    this.mMargin,
    this.mChild
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: mMargin,
      padding: mPadding,
      child: mChild,
      width: mWidth,
      height: mHeight,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}