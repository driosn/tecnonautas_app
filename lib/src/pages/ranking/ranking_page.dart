import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/pages/ranking/widgets/trivias_status_card.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
// import 'package:tecnonautas_app/src/widgets/circle_avatar.dart';
import 'package:tecnonautas_app/src/widgets/gradient_container.dart';
import 'package:tecnonautas_app/src/widgets/tecnonautas_circular_avatar.dart';

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

    final double triviaCardHeight = 120;

    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          avatarSummary(),
          Text('TRIVIAS', style: TextStyle(fontWeight: FontWeight.bold, color: darkGrey)),
          Row(
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
                  mTriviasNumber: 3, 
                ),
              ),
              Expanded(
                child: TriviasStatusCard.neutral(
                  mHeight: triviaCardHeight,
                  mLabel: 'Sin respuesta', 
                  mTriviasNumber: 3, 
                )
              ),
            ],
          )
        ],
      )
    );
  }

  Widget avatarSummary() {
    return GradientContainer(
      mMargin: EdgeInsets.all(12),
      mHeight: containerHeight,
      mWidth: double.infinity,
      mRadius: 15,
      mChild: Center(
        child: TecnonautasCircularAvatar.medium(
          mAvatarImage: AssetImage('assets/images/cat_image.jpg')
        )
      ),
    );
  }
}