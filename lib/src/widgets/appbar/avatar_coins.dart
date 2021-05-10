import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/user_coins/user_coins_bloc.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class AvatarCoins extends StatelessWidget {
  
  UserCoinsBloc userCoinsBloc = UserCoinsBloc();
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset('assets/images/gold_coin.png'),
        SizedBox(width: 2),
        StreamBuilder(
          stream: userCoinsBloc.coinsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int coinsNumber = snapshot.data;
              return Text(
                coinsNumber.toString(), 
                style: TextStyle(color: lightGreyColor)
              );
            }
            return Container();
          }
        )
      ],
    );
  }
} 