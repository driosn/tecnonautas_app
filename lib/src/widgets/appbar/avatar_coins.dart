import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class AvatarCoins extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset('assets/images/gold_coin.png'),
        SizedBox(width: 2),
        Text('125', style: TextStyle(color: lightGreyColor))
      ],
    );
  }
} 