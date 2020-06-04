import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class GradientContainer extends StatelessWidget {

  final double mHeight;
  final double mWidth;
  final double mRadius;
  final EdgeInsetsGeometry mPadding;
  final EdgeInsetsGeometry mMargin;
  final Widget mChild;

  GradientContainer({
    this.mHeight,
    this.mWidth,
    this.mRadius = 0,
    this.mPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.mMargin,
    this.mChild
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mHeight,
      width: mWidth,
      padding: mPadding,
      margin: mMargin,
      child: mChild,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            accent,
            primary
          ]
        ),
        borderRadius: BorderRadius.circular(mRadius)
      ),
    );
  }
}