import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecnonautas_app/src/pages/ranking/widgets/ranking_data_bar.dart';
import 'package:tecnonautas_app/src/pages/ranking/widgets/ranking_data_own.dart';
import 'package:tecnonautas_app/src/pages/ranking/widgets/ranking_data_simple.dart';
import 'package:tecnonautas_app/src/providers/portal_home_model.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/widgets/appbar/tecnonautas_appbar.dart';
import 'package:tecnonautas_app/src/widgets/gradient_container.dart';
import 'package:tecnonautas_app/src/widgets/trivias_status_card.dart';

class RankingPage extends StatefulWidget {
  
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final portalHomeModel = Provider.of<PortalHomeModel>(context, listen: false);
      portalHomeModel.isTriviasPage = false;
    });

    super.initState();
  }

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
                  TecnonautasAppbar(),
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
      
      final ownProfileItems = <RankingDataItem> [
        RankingDataItem(
          mTitle: _rankingTitle(context, 'Puesto:', accentBlue),
          mContent: _rankingContent(context, '8', Colors.black),
          mTrailing: _iconTrailing(Icons.star, accentBlue),
          mBackgroundColor: lightBlue
        ),
        RankingDataItem(
          mTitle: _rankingTitle(context, 'David', accentPurple),
          mContent: _rankingContent(context, '158', Colors.black),
          mTrailing: _iconTrailing(Icons.face, accentPurple),
          mBackgroundColor: lightPink
        ),
        RankingDataItem(
          mTitle: _rankingTitle(context, 'David', accentYellow),
          mContent: _rankingContent(context, '131', Colors.black),
          mTrailing: _iconTrailing(Icons.android, accentYellow),
          mBackgroundColor: lightYellow
        ),
      ];
      
      return GradientContainer(
        mMargin: EdgeInsets.all(12),
        mPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        mWidth: double.infinity,
        mRadius: 15,
        mChild: RankingDataOwn(
          mWidth: 200,
          mItems: ownProfileItems,
        )
      );
    }

    Widget _rankingTitle(BuildContext context, String mText, Color mColor) {
      return Text(
        mText,
        style: Theme.of(context).textTheme.subtitle.copyWith(color: mColor)
      );
    }

    Widget _rankingContent(BuildContext context, String mText, Color mColor) {
      return Text(
        mText, 
        textAlign: TextAlign.center, 
        style: TextStyle(color: mColor, fontWeight: FontWeight.bold)
      );
    }

    Widget _iconTrailing(IconData mIcon, Color mIconColor) {
      return Icon(mIcon, color: mIconColor, size: 18);
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
                mTrailing: _rankingTrailing(context, '1'),
                mBackgroundColor: accentLight
              ),
            ),
            SizedBox(height: 15),
            RankingDataSimple(
              mItem: RankingDataItem(
                mTitle: _rankingTitle(context, 'Juan'),
                mContent: _rankingContent(context, '123 puntos'),
                mTrailing: _rankingTrailing(context, '2'),
                mBackgroundColor: accentLight
              ),
            ),
            SizedBox(height: 15),
            RankingDataSimple(
              mItem: RankingDataItem(
                mTitle: _rankingTitle(context, 'Pedro'),
                mContent: _rankingContent(context, '123 puntos'),
                mTrailing: _rankingTrailing(context, '3'),
                mBackgroundColor: accentLight
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _rankingTitle(BuildContext context, String mText) {
    return Text(
      mText,
      style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white)
    );
  }

  Widget _rankingContent(BuildContext context, String mText) {
    return Text(
      mText, 
      textAlign: TextAlign.center, 
      style: TextStyle(color: Colors.white)
    );
  }

  Widget _rankingTrailing(BuildContext context, String mText) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Text(
        mText, 
        style: Theme.of(context).textTheme.title.copyWith(color: primary)
      ),
    );
  }

}
