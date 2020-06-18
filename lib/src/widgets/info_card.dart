import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class InfoCard extends StatelessWidget {
  
  final double mHeight;
  final double mWidth;
  final String mTitle;
  final Widget mIcon;
  final Widget mChild;

  InfoCard({
    @required this.mHeight, 
    this.mWidth,
    @required this.mTitle,
    @required this.mIcon,
    @required this.mChild,
  });

  double _infoPadding = 12;
  double _infoBorderRadius = 15;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mHeight,
      width: mWidth,
      padding: EdgeInsets.all(_infoPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_infoBorderRadius)
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(mTitle, style: Theme.of(context).textTheme.subtitle),
                mIcon
              ],
            ),
          ),
          Expanded(
            child: Center(child: mChild)
          )
        ],
      ),
    );
  }
}