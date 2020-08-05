import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/widgets/card_container.dart';
import 'package:tecnonautas_app/src/widgets/tecnonautas_circular_avatar.dart';

class AvatarTriviaInfo extends StatelessWidget {
  
  final int finalCoins;
  final int avatarRanking;
  final int totalPlayers;

  AvatarTriviaInfo({
    @required this.finalCoins,
    @required this.avatarRanking,
    @required this.totalPlayers
  });

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
          mAvatarImage: AssetImage('assets/images/avatar.jpg')
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
        _rankingLabel(context)
      ],
    );
  }

  Widget _nameLabel(BuildContext context) {
    return Text('David', style: Theme.of(context).textTheme.subtitle2);
  }

  Widget _coinLabel(BuildContext context) {
    final double _wordSpace = 5;

    return Row(
      children: <Widget>[
        Text('Monedas ganadas: ', style: Theme.of(context).textTheme.subtitle2.copyWith(
          fontWeight: FontWeight.normal, color: goldColor
        )),
        SizedBox(width: _wordSpace),
        Text('6', style: Theme.of(context).textTheme.subtitle2.copyWith(color: goldColor)),
        SizedBox(width: _wordSpace),
        Image.asset('assets/images/gold_coin.png')
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
        Text('$avatarRanking de $totalPlayers', style: Theme.of(context).textTheme.subtitle2.copyWith(
          color: Colors.black45, fontWeight: FontWeight.normal
        )),
      ],
    );
  }
}