import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/pages/ranking/widgets/ranking_data_bar.dart';
import 'package:tecnonautas_app/src/resources/image_sizes.dart';
import 'package:tecnonautas_app/src/widgets/tecnonautas_circular_avatar.dart';

export 'package:tecnonautas_app/src/pages/ranking/widgets/ranking_data_bar.dart';

class RankingDataSimple extends StatelessWidget {

  final RankingDataItem mItem;
  final String mAvatar;
  double mWidth;

RankingDataSimple({
  @required this.mItem, 
  this.mWidth,
  @required this.mAvatar
}) {
  if(this.mWidth != null && this.mWidth < 300) this.mWidth = 300;
}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Stack(
          children: <Widget>[
            Container(
              height: mediumImage,
              width: mWidth,
              child: Center(
                child: RankingDataBar(
                  mHeight: mediumImage * 0.6,
                  mMargin: EdgeInsets.only(left: 15),
                  mItem: mItem,
                  mBorderRadius: 15,
                )
              ),
            ),
            TecnonautasCircularAvatar.medium(
              mAvatarImage: AssetImage('assets/images/avatars/$mAvatar.png')
            ),
          ],
        ),
      ),
    );
  }
}