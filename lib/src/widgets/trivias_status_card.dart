import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class TriviasStatusCard extends StatelessWidget {
  
  final String mLabel;
  final int mTriviasNumber;
  Color mCardColor;
  final double mHeight;
  final double mWidth;

  TriviasStatusCard.correct({
    @required this.mLabel, 
    @required this.mTriviasNumber,
    this.mHeight,
    this.mWidth
  }) {
    this.mCardColor = correctColor;
  }

  TriviasStatusCard.wrong({
    @required this.mLabel, 
    @required this.mTriviasNumber,
    this.mHeight,
    this.mWidth
  }) {
    this.mCardColor = wrongColor;
  }

  TriviasStatusCard.neutral({
    @required this.mLabel, 
    @required this.mTriviasNumber,
    this.mHeight,
    this.mWidth
  }) {
    this.mCardColor = neutralColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      height: mHeight,
      width: mWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: mCardColor
      ),
      child: Stack(
        children: <Widget> [
          Positioned(
            top: 0,
            right: 0,
            child: Icon(Icons.star, color: Colors.white)
          ),
          Container(
            color: Colors.transparent,
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: double.infinity),
                Text(
                  '$mTriviasNumber', 
                  style: Theme.of(context).textTheme.display1.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '$mLabel',
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ]
      ),
    );
  }
}