import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tecnonautas_app/core/bloc/select_active_trivia/selected_trivia_bloc.dart';
import 'package:tecnonautas_app/core/bloc/user_trivia_ranking/user_trivia_ranking_bloc.dart';
import 'package:tecnonautas_app/core/models/trivia.dart';
import 'package:tecnonautas_app/src/pages/trivia_status/trivia_status_page.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/utils/show_loading.dart';
import 'package:tecnonautas_app/src/widgets/gradient_button.dart';
import 'package:tecnonautas_app/src/widgets/info_card.dart';
import 'package:tecnonautas_app/src/widgets/tecnonautas_button.dart';

class TriviaInfoDialog extends StatelessWidget {
  
  final Trivia mTrivia;
  
  TriviaInfoDialog({@required this.mTrivia});

  @override
  Widget build(BuildContext context) {

    final double insetPadding = 12;
    final double borderRadius = 15;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: insetPadding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _InfoHeader(triviaName: mTrivia.name, isFavorite: false),
              _InfoContent(mTrivia: mTrivia)
            ],
          ),
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
                onTap: () => Navigator.pop(context),
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
  
  final Trivia mTrivia;

  _InfoContent({@required this.mTrivia});
  
  double _contentPadding = 12;
  double _borderRadius = 15;

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
          _triviaDescription(mTrivia.description),
          SizedBox(height: _contentPadding),
          _triviaCardsInfo(context),
          _actionButtons(context)
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
            mIcon: SvgPicture.asset('assets/icons/question.svg'), 
            mChild: _cardContent(context, mTrivia.questions.length.toString(), 'Preguntas \n(lo antes posible)')
          ),
        ),
        SizedBox(width: _contentPadding),
        Expanded(
          child: InfoCard(
            mHeight: cardHeight, 
            mTitle: 'Gana', 
            mIcon: SvgPicture.asset('assets/icons/cup.svg'), 
            mChild: _cardContent(context, mTrivia.points.toString(), 'Puntos')
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

  Widget _actionButtons(BuildContext context) {
    
    final double btnHeight = 50;
    final double btnWidth = 200;
    final double btnRadius = 8;
    final EdgeInsetsGeometry sectionPadding = EdgeInsets.symmetric(vertical: 16); 
    final EdgeInsetsGeometry sectionMargin = EdgeInsets.only(top: 16);

    return Container(
      margin: sectionMargin,
      padding: sectionPadding,
      child: Column(
        children: <Widget>[
          GradientButton(
            mHeight: btnHeight,
            mWidth: btnWidth,
            mRadius: btnRadius,
            mText: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.stars, color: Colors.white,), 
                SizedBox(width: 5),
                Text("JUGAR", style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white))
              ],
            ), 
            mColors: <Color> [
              accent,
              primary
            ], 
            mOnPressed: () async {
              try {
                UserTriviaRankingBloc userTriviaRankingBloc = UserTriviaRankingBloc();
                SelectedActiveTriviaBloc selectedActiveTriviaBloc = SelectedActiveTriviaBloc();
                selectedActiveTriviaBloc.changeSelectedActiveTrivia(mTrivia);

                showLoading(context);
                await selectedActiveTriviaBloc.playActiveTrivia();
                await userTriviaRankingBloc.createNewUserTriviaRanking(mTrivia.id);

                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TriviaStatusPage(
                      mTrivia: mTrivia,
                    )
                  )
                );
              } catch (error) {
                Navigator.pop(context);
              }
            },
            // mOnPressed: () { Navigator.pushNamed(context, 'play'); }
          ),
          SizedBox(height: 24),
          TecnonautasButton(
            mHeight: btnHeight,
            mWidth: btnWidth,
            mRadius: btnRadius,
            mText: Text('Cerrar', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),), 
            mColor: Colors.white, 
            mOnPressed: () => Navigator.pop(context)
          )
        ],
      ),
    );
  }
}