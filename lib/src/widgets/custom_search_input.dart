import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class CustomSearchInput extends StatelessWidget {
  
  final double mWidth;
  final double mHeight;
  final IconData mIcon;
  final Color mTrailingColor;
  final String mHint;
  final Function(String) mOnChanged;

  final double iconButtonWidth = 90;

  const CustomSearchInput({
    @required this.mWidth, 
    this.mHeight = 50, 
    this.mIcon = Icons.search, 
    this.mTrailingColor = accentLight, 
    this.mHint = 'Buscar trivias',
    @required this.mOnChanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mHeight,
      width: mWidth,
      child: Row(
        children: <Widget>[
          _SearchInput(mHint, mWidth - iconButtonWidth, mHeight, mOnChanged),
          Expanded(child: _SearchInputIcon(mIcon, mHeight, mTrailingColor))
        ],
      )
    );
  }
}

class _SearchInput extends StatelessWidget {
  
  final String mHint;
  final double mWidth;
  final double mHeight;
  final Function(String) mOnChanged;

  _SearchInput(this.mHint, this.mWidth, this.mHeight, this.mOnChanged);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      height: mHeight,
      width: mWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15)
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: mHint,
          border: InputBorder.none
        ),
        onChanged: mOnChanged,
      ),
    );
  }
}

class _SearchInputIcon extends StatelessWidget {
  
  final IconData mIcon;
  final double mHeight;
  final Color mColor;
  
  _SearchInputIcon(this.mIcon, this.mHeight, this.mColor);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: mHeight,
        decoration: BoxDecoration(
          color: mColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15)
          )
        ),
        child: Center(
          child: Icon(mIcon, size: 30, color: Colors.white),
        ),
      ),
      onTap: () {},
    );
  }
}