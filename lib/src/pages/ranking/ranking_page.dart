import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/pages/ranking/widgets/ranking_data_bar.dart';
import 'package:tecnonautas_app/src/pages/ranking/widgets/ranking_data_simple.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/widgets/gradient_container.dart';
import 'package:tecnonautas_app/src/widgets/tecnonautas_circular_avatar.dart';
import 'package:tecnonautas_app/src/widgets/tecnonautas_header.dart';
import 'package:tecnonautas_app/src/widgets/trivias_status_card.dart';

class RankingPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
        
    return Scaffold(
      body: Center(
        child: _AvatarInfo(),
      ),
    );
  }

}

class _AvatarInfo extends StatelessWidget {
  
  final double containerHeight = 140;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TecnonautasHeader(),
                  _AvatarSummary(),
                  Text(
                    'TRIVIAS', 
                    style: TextStyle(fontWeight: FontWeight.bold, color: darkGrey)
                  ),
                  _TriviaStatusSection(),
                ],
              ),
            ),
            _TriviaRanking()
          ],
        ),
      ),
    );
  }
}

class _TriviaStatusSection extends StatelessWidget {
  
  final double triviaCardHeight = 100;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TriviasStatusCard.correct(
            mHeight: triviaCardHeight,
            mLabel: 'Correctas', 
            mTriviasNumber: 3, 
          )
        ),
        Expanded(
          child: TriviasStatusCard.wrong(
            mHeight: triviaCardHeight,
            mLabel: 'Incorrectas', 
            mTriviasNumber: 1, 
          ),
        ),
        Expanded(
          child: TriviasStatusCard.neutral(
            mHeight: triviaCardHeight,
            mLabel: 'Sin respuesta', 
            mTriviasNumber: 0, 
          )
        ),
      ],
    );
  }
}

  class _AvatarSummary extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return GradientContainer(
        mMargin: EdgeInsets.all(12),
        mPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        mWidth: double.infinity,
        mRadius: 15,
        mChild: RankingDataSimple(
          mItem: RankingDataItem(
            mTitle: _rankingTitle(context, 'David'),
            mContent: _rankingContent(context, '123 puntos'),
            mTrailing: _rankingTrailing(context, '1')
          ),
        )
      );
    }

    Widget _rankingTitle(BuildContext context, String mText) {
      return Text(
        'David',
        style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white)
      );
    }

    Widget _rankingContent(BuildContext context, String mText) {
      return Text(
        '123 puntos', 
        textAlign: TextAlign.center, 
        style: TextStyle(color: Colors.white)
      );
    }

    Widget _rankingTrailing(BuildContext context, String mText) {
      return Text(
        '1', 
        style: Theme.of(context).textTheme.title.copyWith(color: primary)
      );
    }
  }

class _TriviaRanking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            SizedBox(height: 10),
            RankingDataSimple(
              mItem: RankingDataItem(
                mTitle: _rankingTitle(context, 'David'),
                mContent: _rankingContent(context, '123 puntos'),
                mTrailing: _rankingTrailing(context, '1')
              ),
            ),
            SizedBox(height: 15),
            RankingDataSimple(
              mItem: RankingDataItem(
                mTitle: _rankingTitle(context, 'David'),
                mContent: _rankingContent(context, '123 puntos'),
                mTrailing: _rankingTrailing(context, '1')
              ),
            ),
            SizedBox(height: 15),
            RankingDataSimple(
              mItem: RankingDataItem(
                mTitle: _rankingTitle(context, 'David'),
                mContent: _rankingContent(context, '123 puntos'),
                mTrailing: _rankingTrailing(context, '1')
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _rankingTitle(BuildContext context, String mText) {
    return Text(
      'David',
      style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white)
    );
  }

  Widget _rankingContent(BuildContext context, String mText) {
    return Text(
      '123 puntos', 
      textAlign: TextAlign.center, 
      style: TextStyle(color: Colors.white)
    );
  }

  Widget _rankingTrailing(BuildContext context, String mText) {
    return Text(
      '1', 
      style: Theme.of(context).textTheme.title.copyWith(color: primary)
    );
  }

}
