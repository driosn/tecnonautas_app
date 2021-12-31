import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/borders.dart';
import 'package:tecnonautas_app/src/widgets/card_container.dart';

class TriviaStatusDescription extends StatelessWidget {
  
  final String mTitle;
  final String mDescription;
  final bool mIsFavorite;
  
  TriviaStatusDescription({
    @required this.mTitle,
    @required this.mDescription,
    @required this.mIsFavorite
  });

  final double _horizontalPadding = 10;
  final double _verticalPadding = 16;
  final double _spacing = 18;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      mPadding: EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
        vertical: _verticalPadding
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _triviaTitle(context),
          SizedBox(height: _spacing),
          _triviaDescription()
        ],
      )
    );
  }

  Widget _triviaLabel() {

  }

  Widget _isFavoriteIcon() {

  }

  Widget _triviaTitle(BuildContext context) {
    return Text(
      mTitle, 
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline6)
    ;
  }

  Widget _triviaDescription() {
    return Text(mDescription);  
  }
}