import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/pages/ranking/widgets/ranking_data_bar.dart';
import 'package:tecnonautas_app/src/resources/image_sizes.dart';
import 'package:tecnonautas_app/src/widgets/tecnonautas_circular_avatar.dart';

export 'package:tecnonautas_app/src/pages/ranking/widgets/ranking_data_bar.dart';

class RankingDataOwn extends StatelessWidget {

  final List<RankingDataItem> mItems;
  double mWidth;

RankingDataOwn({@required this.mItems, this.mWidth}) {
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: mItems.map(
                    (mItem) => RankingDataBar(
                      mHeight: mediumImage * 0.2,
                      mMargin: EdgeInsets.only(left: 15, bottom: 5),
                      mItem: mItem,
                      mBorderRadius: 5,
                    )
                  ).toList(),
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