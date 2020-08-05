import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class ResponseAverageBar extends StatelessWidget {
  
  final int secondValue;
  final double barHeight;
  final double barWidth;

  ResponseAverageBar({
    @required this.secondValue,
    @required this.barHeight, 
    this.barWidth = 300,
  });

  final int _totalSeconds = 60;
  final double _barRadius = 20;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_barRadius),
        boxShadow: <BoxShadow> [
          BoxShadow(
            offset: Offset(-2.5, 5),
            color: lightGreyColor.withOpacity(0.25),
            blurRadius: 5
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_barRadius),
        child: Stack(
          children: <Widget>[
            Container(
              width: barWidth,
              height: barHeight,
              decoration: BoxDecoration(
                color: lightGreyColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(_barRadius)
              ),    
            ),
            ClipRRect(
              child: Container(
                width: barWidth * _getPercentage(secondValue, _totalSeconds),
                height: barHeight,
                decoration: BoxDecoration(
                  color: accent
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  double _getPercentage(int currentValue, int totalValue) {
    print(currentValue / totalValue);
    return currentValue / totalValue;
  }

}
