import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/resources/image_sizes.dart';

class TecnonautasCircularAvatar extends StatelessWidget {
  
  double mAvatarRadius;
  final ImageProvider mAvatarImage;

  TecnonautasCircularAvatar({@required this.mAvatarRadius, @required this.mAvatarImage});

  TecnonautasCircularAvatar.small({@required this.mAvatarImage}) {
    this.mAvatarRadius = smallImage / 2;
  }

  TecnonautasCircularAvatar.medium({@required this.mAvatarImage}) {
    this.mAvatarRadius = mediumImage / 2;
  }

  TecnonautasCircularAvatar.large({@required this.mAvatarImage}) {
    this.mAvatarRadius = largeImage / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mAvatarRadius * 2,
      width: mAvatarRadius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: lightBlue, width: 3),
        image: DecorationImage(
          image: mAvatarImage
        )
      ),
    );
  }
}