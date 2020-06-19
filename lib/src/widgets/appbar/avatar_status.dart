import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/resources/image_sizes.dart';
import 'package:tecnonautas_app/src/widgets/appbar/avatar_coins.dart';
import 'package:tecnonautas_app/src/widgets/appbar/avatar_level_bar.dart';
import 'package:tecnonautas_app/src/widgets/tecnonautas_circular_avatar.dart';

class AvatarStatus extends StatelessWidget {
 
  final double _statusTotalWidth = 200;
  final double _statusWidth = 140;
  final double _spacing = 10;

  @override
  Widget build(BuildContext context) {
    
    final Size size = MediaQuery.of(context).size;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(width: size.width),
        Container(
          height: smallImage,
          width: size.width,
          // color: Colors.pink,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(width: _spacing),
              Expanded(
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        child: Container(
                          width: size.width,
                          height: 2,
                          color: primary,
                        ),
                        bottom: 5,
                      ),
                      Positioned(
                        child: Row(
                          children: <Widget>[
                            AvatarCoins(),
                            SizedBox(width: 10),
                            AvatarLevelBar()
                          ],
                        ),
                        bottom: 5,
                        right: 5,
                      ),
                      Positioned(
                        right: 0,
                        child: TecnonautasCircularAvatar.small(mAvatarImage: AssetImage('assets/images/avatar.jpg'))
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}