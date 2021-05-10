import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/user_coins/user_coins_bloc.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class ResultCard extends StatelessWidget {
  
  final String mResultDescription;
  String mResultTitle;
  Color mResultColor;

  UserCoinsBloc userCoinsBloc = UserCoinsBloc();

  ResultCard.correct({@required this.mResultDescription}) {
    mResultTitle = "CORRECTO!!!";
    mResultColor = correctColor;
  }

  ResultCard.incorrect({@required this.mResultDescription}) {
    mResultTitle = "INCORRECTO!!!";
    mResultColor = wrongColor;
  }

  final double _mHeight = 215;
  final double _horizontalPadding = 30.5;
  final double _verticalPadding = 22;
  final double _spacing = 35;
  final double _cardRadius = 10;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: _mHeight,
        padding: EdgeInsets.symmetric(
          horizontal: _horizontalPadding,
          vertical: _verticalPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_cardRadius),
          border: Border.all(width: 3, color: mResultColor)
        ),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Text(
              mResultTitle, 
              style: Theme.of(context).textTheme.headline6.copyWith(color: mResultColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: _spacing),
            Text(
              mResultDescription,
              style: Theme.of(context).textTheme.subtitle2.copyWith(color: lightGreyColor),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}