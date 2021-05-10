import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecnonautas_app/core/bloc/user_ranking/user_ranking_bloc.dart';
import 'package:tecnonautas_app/core/models/user.dart';
import 'package:tecnonautas_app/core/models/user_ranking.dart';
import 'package:tecnonautas_app/src/pages/ranking/widgets/ranking_data_bar.dart';
import 'package:tecnonautas_app/src/pages/ranking/widgets/ranking_data_own.dart';
import 'package:tecnonautas_app/src/pages/ranking/widgets/ranking_data_simple.dart';
import 'package:tecnonautas_app/src/providers/portal_home_model.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';
import 'package:tecnonautas_app/src/widgets/appbar/tecnonautas_appbar.dart';
import 'package:tecnonautas_app/src/widgets/gradient_container.dart';
import 'package:tecnonautas_app/src/widgets/trivias_status_card.dart';

class RankingPage extends StatefulWidget {
  
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {

  UserPreferences prefs = UserPreferences();

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
    
    UserPreferences prefs = UserPreferences();

    @override
    Widget build(BuildContext context) {
      // prefs.updateId("945509d0-67d8-11eb-9e10-bfadeb8ff1c8");


      final ownProfileItems = <RankingDataItem> [
        RankingDataItem(
          mTitle: _rankingTitle(context, 'Puesto', accentPurple),
          mContent: StreamBuilder<QuerySnapshot>(
            stream: userRankingBloc.userStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                QuerySnapshot querySnapshotResponse = snapshot.data;
                List<User> allUsers = List<User>();

                print("Inicio query");
                querySnapshotResponse.documents.forEach((document) {
                  print(document.data["id"]);
                  allUsers.add(User.fromDocument(document.data));
                });
                print("Fin query");
                print("INicio sort");

                allUsers.sort((userA, userB) => userB.score.compareTo(userA.score));
                
                print("Fin sort");

                int myOwnPosition = allUsers.indexWhere((element) => element.id == prefs.id);
                return _rankingContent(context, "${myOwnPosition + 1}", accent);
              }

              return _rankingContent(context, "0", accent);
            },
          ),
          mTrailing: _iconTrailing(Icons.face, accentPurple),
          mBackgroundColor: lightPink
        ),
        RankingDataItem(
          mTitle: _rankingTitle(context, 'Puntos:', accentBlue),
          mContent: StreamBuilder<QuerySnapshot>(
            stream: userRankingBloc.userStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                QuerySnapshot querySnapshotResponse = snapshot.data;
                List<User> allUsers = List<User>();

                querySnapshotResponse.documents.forEach((document) {
                  allUsers.add(User.fromDocument(document.data));
                });

                User ownUser = allUsers.firstWhere((user) => user.id == prefs.id);
                return _rankingContent(context, "${ownUser.score.toStringAsFixed(0)}", accent);
              }

              return _rankingContent(context, "0", accent);
            },
          ),
          mTrailing: _iconTrailing(Icons.star, accentBlue),
          mBackgroundColor: lightBlue
        ),
        RankingDataItem(
          mTitle: _rankingTitle(context, 'Monedas', accentYellow),
          mContent: _rankingContent(context, '0', Colors.black),
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
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 12
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: userRankingBloc.userStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              QuerySnapshot querySnapshotResponse = snapshot.data;
              List<User> allUsers = List<User>();

              querySnapshotResponse.documents.forEach((document) {
                allUsers.add(User.fromDocument(document.data));
              });
              allUsers.sort((userA, userB) => userB.score.compareTo(userA.score));

              bool rankingExists = false;

              allUsers.forEach((user) {
                if (user.score > 0) { rankingExists = true; }
              });

              if (rankingExists) {
                return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(height: 15),
                  itemCount: allUsers.length > 3 ? 3 : allUsers.length,
                  itemBuilder: (context, index) {
                  
                    return RankingDataSimple(
                      mItem: RankingDataItem(
                        mTitle: _rankingTitle(context, allUsers[index].username), 
                        mContent: _rankingContent(context, '${allUsers[index].score.toStringAsFixed(0)} puntos'), 
                        mTrailing: _rankingTrailing(context, (index + 1).toString())
                      ),
                      mAvatar: allUsers[index].avatar,
                    );
                  }
                );
              }

              return Center(
                child: Text("No existe la cantidad de usuarios para mostrar un ranking"),
              );
            }

            return Center(
              child: Text('No existe un ranking de jugadores aún'),
            );
          },
        )

      ),
    );
  }

  void updateSignalPoints() {

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
