import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/widgets/info_card.dart';

class TriviaInfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final double insetPadding = 12;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: insetPadding),
      child: Container(
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _InfoHeader(triviaName: 'Formulas Químicas', isFavorite: false),
            _InfoContent()
          ],
        ),
      ),
    );
  }
}

class _InfoHeader extends StatelessWidget {
  
  final String triviaName;
  final bool isFavorite;

  _InfoHeader({@required this.triviaName, @required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    
    final double headerPadding = 12;

    return Container(
      padding: EdgeInsets.only(
        left: headerPadding,
        right: headerPadding,
        top: headerPadding
      ),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Trivia', style: TextStyle(color: darkGrey),),
              GestureDetector(
                child: Icon(Icons.close, color: Colors.black54),
                onTap: () {},
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                triviaName,
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: isFavorite 
                    ? Icon(Icons.favorite, color: favoriteColor)
                    : Icon(Icons.favorite_border, color: darkGrey),
                onPressed: () {},
              )
            ],
          )
        ],
      )
    );
  }
}

class _InfoContent extends StatelessWidget {
  
  double _contentPadding = 12;
  double _borderRadius = 15;
  String _mTriviaDescription = 'Las fórmulas químicas son la representación de los elementos que forman un compuesto y la proporción en que se encuentran';

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(
        top: _contentPadding,
        left: _contentPadding,
        right: _contentPadding,
        bottom: _contentPadding * 2
      ),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: <Widget>[
          _triviaDescription(_mTriviaDescription),
          _triviaCardsInfo(context)
        ],
      ),
    );
  }

  Widget _triviaDescription(String mDescription) {
    return Container(
      padding: EdgeInsets.all(_contentPadding * 2.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          mDescription, 
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400)
        ),
      ),
    );
  }  

  Widget _triviaCardsInfo(BuildContext context) {
    
    final double cardHeight = 140;
    final double cardWidth  = 200;
    
    return Row(
      children: <Widget>[
        Expanded(
          child: InfoCard(
            mHeight: cardHeight, 
            mTitle: 'Responde', 
            mIcon: Icons.ac_unit, 
            mChild: _cardContent(context, '4', 'Preguntas \n(lo antes posible)')
          ),
        ),
        SizedBox(width: _contentPadding),
        Expanded(
          child: InfoCard(
            mHeight: cardHeight, 
            mTitle: 'Gana', 
            mIcon: Icons.ac_unit, 
            mChild: _cardContent(context, '10', 'Puntos')
          ),
        )
      ],
    );
  }

  Widget _cardContent(BuildContext context, String mNumber, String mMiniDesc) {
    
    final double contentPadding = 12;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: contentPadding),
        Text(
          mNumber, 
          style: Theme.of(context).textTheme.headline4.copyWith(
            color: Colors.black54, fontWeight: FontWeight.bold
        )),
        Text(
          mMiniDesc, 
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400),
        ) 
      ],
    );
  }
}