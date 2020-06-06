import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/pages/ranking/widgets/ranking_data_bar.dart';
import 'package:tecnonautas_app/src/resources/image_sizes.dart';
import 'package:tecnonautas_app/src/widgets/tecnonautas_circular_avatar.dart';

export 'package:tecnonautas_app/src/pages/ranking/widgets/ranking_data_bar.dart';

class RankingDataSimple extends StatelessWidget {

  final RankingDataItem mItem;
  double mWidth;

RankingDataSimple({@required this.mItem, this.mWidth}) {
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
                  mBackgroundColor: Colors.purple,
                  mMargin: EdgeInsets.only(left: 15),
                  mItem: mItem
                )
              ),
            ),
            TecnonautasCircularAvatar.medium(
              mAvatarImage: AssetImage('assets/images/cat_image.jpg')
            ),
          ],
        ),
      ),
    );
  }
}