import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class FavoriteButton extends StatelessWidget {
  
  final bool isFavorite;
  final Function onPressed;

  FavoriteButton({
    @required this.isFavorite,
    @required this.onPressed
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: isFavorite
              ? Icon(Icons.favorite, color: favoriteColor)
              : Icon(Icons.favorite_border, color: darkGrey),
        onTap: onPressed,
      )
    );
  }
}