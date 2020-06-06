import 'package:flutter/material.dart';

class RankingDataItem { 

  final Widget mTitle;
  final Widget mContent;
  final Widget mTrailing;

  RankingDataItem({
    @required this.mTitle, 
    @required this.mContent, 
    @required this.mTrailing
  });

}

class RankingDataBar extends StatelessWidget {
  
  final double mHeight;
  final double mWidth;  
  final EdgeInsetsGeometry mPadding;
  final EdgeInsetsGeometry mMargin;
  final Color mBackgroundColor;
  final RankingDataItem mItem;
  
  RankingDataBar({
    this.mHeight,
    this.mWidth,
    this.mPadding,
    this.mMargin,
    this.mBackgroundColor,
    this.mItem
  });

  @override
  Widget build(BuildContext context) {
    
    final double borderRadius = 15;
    final double padding = 10;

    return Container(
      width: mWidth,
      height: mHeight,
      padding: mPadding,
      margin: mMargin,
      decoration: BoxDecoration(
        color: mBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius)
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 100),
          Expanded(child: mItem.mTitle),
          Expanded(child: mItem.mContent),
          Expanded(child: 
            Container(
              child: Align(alignment: 
                Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 15),
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