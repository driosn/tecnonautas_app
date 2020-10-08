import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/active_trivia/active_trivia_bloc.dart';
import 'package:tecnonautas_app/core/bloc/user_trivia_ranking/user_trivia_ranking_bloc.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';
import 'package:tecnonautas_app/src/widgets/card_container.dart';
import 'package:tecnonautas_app/src/widgets/tecnonautas_circular_avatar.dart';

class AvatarTriviaInfoLocal extends StatelessWidget {
  
  final int valorMoneda = 10;

  final String mTriviaId;
  final int mTriviaQuestionsLen;
  final List<String> mQuestionsName;

  final int finalScore;
  final int avatarRanking;
  final int totalPlayers;

  AvatarTriviaInfoLocal({
    @required this.mTriviaId,
    @required this.mTriviaQuestionsLen,
    @required this.mQuestionsName,
    @required this.finalScore,
    @required this.avatarRanking,
    @required this.totalPlayers
  });

  UserPreferences prefs = UserPreferences();

  final double _cardPadding = 15;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      mPadding: EdgeInsets.all(_cardPadding),
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _avatarInfo(context),
        )
      ),
    );
  }

  Widget _avatarInfo(BuildContext context) {
    final double _dataSpacing = 20;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TecnonautasCircularAvatar.medium(
          mAvatarImage: AssetImage('assets/images/avatars/${prefs.avatar}.png')
        ),
        SizedBox(width: _dataSpacing),
        _avatarTriviaData(context)
      ],
    ); 
  }

  Widget _avatarTriviaData(BuildContext context) {
    final double _verticalTextSpacing = 5;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _nameLabel(context),
        SizedBox(height: _verticalTextSpacing),
        _coinLabel(context),
        SizedBox(height: _verticalTextSpacing),
        // _rankingLabel(context)
      ],
    );
  }

  Widget _nameLabel(BuildContext context) {
    return Text(prefs.username, style: Theme.of(context).textTheme.subtitle2);
  }

  Widget _coinLabel(BuildContext context) {
    UserPreferences prefs = UserPreferences();
    
    int valorTotal = 0;
    for(int i = 0; i < mTriviaQuestionsLen; i++) {
      final result = prefs.getQuestionResult(mQuestionsName[i]);
    
      if (result == "Correct") valorTotal++;
    }
    
    final double _wordSpace = 5;

    return Row(
      children: <Widget>[
        Text('Monedas ganadas: ${valorTotal * valorMoneda}', style: Theme.of(context).textTheme.subtitle2.copyWith(
          fontWeight: FontWeight.normal,
          color: goldColor
        )),
        SizedBox(width: _wordSpace),
        // StreamBuilder<DocumentSnapshot>(
        //   stream: Firestore.instance
        //                    .collection("userTriviaRanking")
        //                    .document(mTriviaId)
        //                    .snapshots(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       DocumentSnapshot snapshotResponse = snapshot.data;
        //       Map<String, dynamic> ownProfileData = Map<String, dynamic>();

        //       ownProfileData = snapshotResponse.data["ranking"].firstWhere((element) => element["userId"] == prefs.id);

        //       return Text(ownProfileData["points"].toStringAsFixed(2), style: Theme.of(context).textTheme.subtitle2.copyWith(
        //         color: Colors.black45, fontWeight: FontWeight.normal
        //       ));
        //     }
        //     return Container();
        //   },
        // )
      ],
    );
  }

  Widget _rankingLabel(BuildContext context) {
    final double _wordSpace = 5;

    return Row(
      children: <Widget>[
        Text('Ranking: ', style: Theme.of(context).textTheme.subtitle2.copyWith(
          fontWeight: FontWeight.normal
        )),
        SizedBox(width: _wordSpace),
        // StreamBuilder<DocumentSnapshot>(
        //   stream: Firestore.instance
        //                    .collection("userTriviaRanking")
        //                    .document(mTriviaId)
        //                    .snapshots(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       DocumentSnapshot snapshotResponse = snapshot.data;
        //       List<Map<String, dynamic>> usersInThisTrivia = List<Map<String, dynamic>>();

        //       snapshotResponse.data["ranking"].forEach((user) {
        //         usersInThisTrivia.add(Map<String, dynamic>.from(user));
        //       });
              
        //       usersInThisTrivia.sort((userA, userB) => userB["points"].compareTo(userA["points"]));
        //       int userPosition = usersInThisTrivia.indexWhere((element) => element["userId"] == prefs.id);
        //       userPosition++;

        //       return Text('$userPosition de ${snapshotResponse.data["ranking"].length}', style: Theme.of(context).textTheme.subtitle2.copyWith(
        //         color: Colors.black45, fontWeight: FontWeight.normal
        //       ));
        //     }
        //     return Container();
        //   },
        // )
      ],
    );
  }
}