import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class CustomPlainAppbar extends StatelessWidget with PreferredSizeWidget{
  
  final String mTitle;

  CustomPlainAppbar({@required this.mTitle});
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        mTitle,
        style: Theme.of(context).textTheme.subtitle2.copyWith(
          color: accent
        ),
      ),
      leading: Align(
        alignment: Alignment.centerLeft,
        child: _backButton(context),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    final double _iconSize = 18;
    
    return IconButton(
      icon: FaIcon(
        FontAwesomeIcons.chevronLeft,
        size: _iconSize,
        color: lightGreyColor,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}