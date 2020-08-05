import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class ProfileInfoLabel extends StatelessWidget {
  
  final String title;
  final Widget content;

  ProfileInfoLabel({@required this.title, @required this.content});

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _title(),
          content
        ],
      ),      
    );
  }

  Widget _title() {
    return Text(
      this.title,
      style: TextStyle(color: titleSettingColor),
    );
  }
}