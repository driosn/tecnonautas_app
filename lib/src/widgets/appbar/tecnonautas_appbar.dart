import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/widgets/appbar/avatar_level_bar.dart';
import 'package:tecnonautas_app/src/widgets/appbar/avatar_status.dart';

class TecnonautasAppbar extends StatelessWidget {

  final Color mBackgroundColor;

  TecnonautasAppbar({
    this.mBackgroundColor = Colors.white
  });

  final double _contentHeight = 70;
  final double _verticalPadding = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: _verticalPadding
      ),
      width: double.infinity,
      color: Colors.orange,
      child: Container(
        height: _contentHeight,
        color: Colors.green,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              color: Colors.purpleAccent,
              child: Image.asset('assets/images/logo_tecnonautas_2x.png')
            ),
            AvatarStatus()
          ],
        ),
      ),      
    );
  }

}