import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class AvatarLevelBar extends StatelessWidget {
  
  final double _barWidth = 140;
  final double _barHeight = 20;
  final double _barRadius = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _barHeight,
      width: _barWidth,
      decoration: BoxDecoration(
        color: levelBarColor,
        borderRadius: BorderRadius.circular(_barRadius)
      ),
    );
  }
}