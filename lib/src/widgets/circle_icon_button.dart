import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class CircleIconButton extends StatelessWidget {
  
  final double mSize;
  final IconData mIcon;
  final Function mOnPressed;

  CircleIconButton({
    @required this.mSize,
    @required this.mIcon,
    @required this.mOnPressed,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: mSize,
      width: mSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: darkGrey
      ),
      child: Icon(mIcon, color: Colors.white),
    );
  }
}