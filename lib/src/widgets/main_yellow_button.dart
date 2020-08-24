import 'package:flutter/material.dart';

class MainYellowButton extends StatelessWidget {
  
  final Function mOnPressed;
  final String mText;

  bool isDisabled = false;

  MainYellowButton({
    @required this.mOnPressed,
    @required this.mText
  });

  MainYellowButton.disabled({
    @required this.mOnPressed,
    @required this.mText
  }) {
    isDisabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: isDisabled ? () {} : this.mOnPressed,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      color: isDisabled ? Colors.grey[400] : Color(0xffFBB52C),
      child: Text(mText, style: TextStyle(color: isDisabled ? Colors.white : Colors.black)),
    );
  }
}