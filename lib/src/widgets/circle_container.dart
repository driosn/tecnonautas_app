import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  
  final double mSize; 
  final Widget mChild;
  final Color mColor;

  CircleContainer({
    @required this.mSize, 
    @required this.mChild,
    @required this.mColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mSize,
      width: mSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: mColor
      ),
      child: Center(
        child: mChild,
      ),
    );
  }
}