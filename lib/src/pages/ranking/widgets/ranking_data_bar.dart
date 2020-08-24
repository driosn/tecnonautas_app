import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/resources/image_sizes.dart';

class RankingDataItem { 

  final Widget mTitle;
  final Widget mContent;
  final Widget mTrailing;
  final Color mBackgroundColor;

  RankingDataItem({
    @required this.mTitle, 
    @required this.mContent, 
    @required this.mTrailing,
    this.mBackgroundColor = accent
  });

}

class RankingDataBar extends StatelessWidget {
  
  final double mHeight;
  final double mWidth;  
  final EdgeInsetsGeometry mPadding;
  final EdgeInsetsGeometry mMargin;
  final RankingDataItem mItem;
  final double mBorderRadius; 
  
  RankingDataBar({
    this.mHeight,
    this.mWidth,
    this.mPadding,
    this.mMargin,
    this.mItem,
    this.mBorderRadius
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: mWidth,
      height: mHeight,
      padding: mPadding,
      margin: mMargin,
      decoration: BoxDecoration(
        color: mItem.mBackgroundColor,
        borderRadius: BorderRadius.circular(mBorderRadius)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: mediumImage - 10),
          Expanded(child: mItem.mTitle),
          Expanded(child: mItem.mContent),
          Expanded(child: 
            Container(
              child: Align(alignment: 
                Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 5),
                  child: mItem.mTrailing,
                ),
              )
            )
          )
        ],
      ),
    );
  }
}