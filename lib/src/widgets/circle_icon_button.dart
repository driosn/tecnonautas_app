import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class CircleIconButton extends StatelessWidget {
  
  final double mSize;
  final IconData mIcon;
  final Function mOnPressed;
  final Color mColor;

  CircleIconButton({
    @required this.mSize,
    @required this.mIcon,
    @required this.mOnPressed,
    @required this.mColor
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: mSize,
        width: mSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: this.mColor
        ),
        child: Icon(mIcon, color: Colors.white),
      ),
      onTap: mOnPressed,
    );
  }
}