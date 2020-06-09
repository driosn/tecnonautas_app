import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/widgets/puzzle_piece_button.dart';

class QuestionsPage extends StatelessWidget {
  
  final double pieceHeight = 140;
  final double pieceWidth = 190;
  final double containerHeight = 290;
  final double containerWidth = 390;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _pieceButtons()
        ],
      ),
    );
  }

  Widget _pieceButtons() {
    return Container(
      height: containerHeight,
      width: containerWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              PuzzlePieceButton(
                mHeight: pieceHeight,
                mWidth: pieceWidth, 
                mColor: redPiece,
                piecePlace: PiecePlace.TOP_LEFT,
              ),
              Spacer(),
              PuzzlePieceButton(
                mHeight: pieceHeight,
                mWidth: pieceWidth, 
                mColor: bluePiece,
                piecePlace: PiecePlace.TOP_RIGHT,
              ),
            ],
          ),
          Spacer(),
          Row(
            children: <Widget>[
              PuzzlePieceButton(
                mHeight: pieceHeight,
                mWidth: pieceWidth, 
                mColor: greenPiece,
                piecePlace: PiecePlace.BOTTOM_LEFT,
              ),
              Spacer(),
              PuzzlePieceButton(
                mHeight: pieceHeight,
                mWidth: pieceWidth, 
                mColor: orangePiece,
                piecePlace: PiecePlace.BOTTOM_RIGHT,
              ),
            ],
          )
        ],
      ),
    );
  }
}