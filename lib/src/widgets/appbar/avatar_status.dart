import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/image_sizes.dart';
import 'package:tecnonautas_app/src/widgets/appbar/avatar_level_bar.dart';
import 'package:tecnonautas_app/src/widgets/tecnonautas_circular_avatar.dart';

class AvatarStatus extends StatelessWidget {
 
  final double _statusWidth = 140;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: smallImage,
      width: _statusWidth,
      color: Colors.pink,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: AvatarLevelBar(),
            bottom: 5,
          ),
          Positioned(
            right: 0,
            child: TecnonautasCircularAvatar.small(mAvatarImage: AssetImage('assets/images/avatar.jpg'))
          ),
        ],
      ),
    );
  }
}