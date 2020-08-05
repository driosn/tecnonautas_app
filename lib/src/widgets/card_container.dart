import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class CardContainer extends StatelessWidget {
  
  final double mHeight;
  final double mWidth;
  final EdgeInsetsGeometry mPadding;
  final Widget child;

  CardContainer({
    this.mHeight,
    this.mWidth,
    this.child,
    this.mPadding
  });
  
  final double _borderRadius = 12;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mHeight,
      width: mWidth,
      padding: mPadding,
      child: child,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: <BoxShadow> [
          BoxShadow(
            offset: Offset(3, 3), 
            color: lightGreyColor.withOpacity(0.3),
            blurRadius: 5,
          )
        ]
      ),
    );
  }
}