import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class TecnonautasCircularAvatar extends StatelessWidget {
  
  double mAvatarRadius;
  final ImageProvider mAvatarImage;

  TecnonautasCircularAvatar({@required this.mAvatarRadius, @required this.mAvatarImage});

  TecnonautasCircularAvatar.small({@required this.mAvatarImage}) {
    this.mAvatarRadius = 25;
  }

  TecnonautasCircularAvatar.medium({@required this.mAvatarImage}) {
    this.mAvatarRadius = 50;
  }

  TecnonautasCircularAvatar.large({@required this.mAvatarImage}) {
    this.mAvatarRadius = 60;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mAvatarRadius * 2,
      width: mAvatarRadius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: primary, width: 3),
        image: DecorationImage(
          image: mAvatarImage
        )
      ),
    );
  }
}