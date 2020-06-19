import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/widgets/appbar/avatar_level_bar.dart';
import 'package:tecnonautas_app/src/widgets/appbar/avatar_status.dart';

class TecnonautasAppbar extends StatelessWidget {

  final Color mBackgroundColor;

  TecnonautasAppbar({
    this.mBackgroundColor = Colors.white
  });

  final double _contentHeight = 70;
  final double _topMargin = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: _topMargin),
      width: double.infinity,
      child: Container(
        height: _contentHeight,
        child: Stack(
          children: <Widget>[
            AvatarStatus(),
            Container(
              child: Image.asset('assets/images/logo_tecnonautas_2x.png')
            ),
          ],
        ),
      ),      
    );
  }

}