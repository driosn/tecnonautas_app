import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/question/selected_question_bloc.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

enum PiecePlace {
  TOP_LEFT,
  TOP_RIGHT,
  BOTTOM_LEFT,
  BOTTOM_RIGHT
}

class PuzzlePieceButton extends StatelessWidget {
  
  final double mHeight;
  final double mWidth;
  final Color mColor;
  final PiecePlace piecePlace;
  final String mText;
  final bool mDrawBorder;


  PuzzlePieceButton({
    this.mHeight,
    this.mWidth,
    @required this.mColor,
    @required this.piecePlace,
    @required this.mText,
    @required this.mDrawBorder
  });
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: mHeight,
          width: mWidth,
          child: CustomPaint(
            painter: _PuzzlePiecePainter(piecePlace, mColor, mText, mDrawBorder)
          ),
        ),
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: mWidth * 0.25,
              vertical: mHeight * 0.1
            ),
            child: Container(
              child: Align(
                alignment: Alignment.center,
                child: Text(mText, style: TextStyle(color: Colors.white))
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _PuzzlePiecePainter extends CustomPainter {
  
  final Color mColor;
  final PiecePlace piecePlace;
  final String mLabel;
  final bool mDrawBorder;

  _PuzzlePiecePainter(
    this.piecePlace, 
    this.mColor,
    this.mLabel,
    this.mDrawBorder
  );

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = new Paint()
    ..color = mColor
    ..style = PaintingStyle.fill
    ..strokeWidth = 5.0;

    Path path = _generatePuzzlePiece(piecePlace, size);
      
    canvas.drawShadow(path, Colors.black38, 8, false);  
    canvas.drawPath(path, paint);

    paint = new Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 12;
    paint.color = accent;

    if (mDrawBorder) {
      canvas.drawPath(path, paint);
    }
  }

  Path _generatePuzzlePiece(PiecePlace piecePlace, Size size) {

    if(piecePlace == PiecePlace.TOP_LEFT) return _generateTopLeftPiece(size);
    if(piecePlace == PiecePlace.TOP_RIGHT) return _generateTopRightPiece(size);
    if(piecePlace == PiecePlace.BOTTOM_LEFT) return _generateBottomLeftPiece(size);
    if(piecePlace == PiecePlace.BOTTOM_RIGHT) return _generateBottomRightPiece(size);
    
    return _generateTopLeftPiece(size);

  }

  Path _generateTopLeftPiece(Size size) {
    Path path = new Path();
    final double borderDiff = 20;

    path.moveTo(borderDiff, 0);
    path.lineTo(size.width - borderDiff, 0);
    path.quadraticBezierTo(size.width, 0, size.width, borderDiff);
    path.lineTo(size.width, size.height * 0.3);
    path.quadraticBezierTo(size.width - borderDiff * 2, size.height * 0.3, size.width - borderDiff * 2, size.height * 0.5);
    path.quadraticBezierTo(size.width - borderDiff * 2, size.height * 0.7, size.width, size.height * 0.7);
    path.lineTo(size.width, size.height - borderDiff);
    path.quadraticBezierTo(size.width, size.height, size.width - borderDiff, size.height);

    path.lineTo(size.width * 0.725, size.height);
    path.quadraticBezierTo(size.width * 0.7, size.height + borderDiff * 1.5, size.width * 0.5, size.height + borderDiff * 1.5);
    path.quadraticBezierTo(size.width * 0.3, size.height + borderDiff * 1.5, size.width * 0.275, size.height);
    
    path.lineTo(borderDiff, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - borderDiff);
    path.lineTo(0, borderDiff);
    path.quadraticBezierTo(0, 0, borderDiff, 0);
  
    return path;
  }

  Path _generateTopRightPiece(Size size) {
    Path path = new Path();
    final double borderDiff = 20;

    path.moveTo(borderDiff, 0);
    path.lineTo(size.width - borderDiff, 0);
    path.quadraticBezierTo(size.width, 0, size.width, borderDiff);
    path.lineTo(size.width, size.height - borderDiff);
    path.quadraticBezierTo(size.width, size.height, size.width - borderDiff, size.height);

    path.lineTo(size.width * 0.725, size.height);
    path.quadraticBezierTo(size.width * 0.7, size.height - borderDiff * 1.5, size.width * 0.5, size.height - borderDiff * 1.5);
    path.quadraticBezierTo(size.width * 0.3, size.height - borderDiff * 1.5, size.width * 0.275, size.height);
    
    path.lineTo(borderDiff, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - borderDiff);
    
    path.lineTo(0, size.height * 0.7);
    path.quadraticBezierTo(- borderDiff * 2, size.height * 0.7, -borderDiff * 2, size.height * 0.5);
    path.quadraticBezierTo(- borderDiff * 2, size.height * 0.3, 0, size.height * 0.3);

    
    path.lineTo(0, borderDiff);
    path.quadraticBezierTo(0, 0, borderDiff, 0);
  
    return path;
  }

  Path _generateBottomLeftPiece(Size size) {
    Path path = new Path();
    final double borderDiff = 20;

    path.moveTo(borderDiff, 0);
    
    path.lineTo(size.width * 0.275, 0);
    path.quadraticBezierTo(size.width * 0.3, borderDiff * 1.5, size.width * 0.5, borderDiff * 1.5);
    path.quadraticBezierTo(size.width * 0.7, borderDiff * 1.5, size.width * 0.725, 0);
    path.lineTo(size.width - borderDiff, 0);

    path.quadraticBezierTo(size.width, 0, size.width, borderDiff);
    path.lineTo(size.width, size.height * 0.3);
    path.quadraticBezierTo(size.width + borderDiff * 2, size.height * 0.3, size.width + borderDiff * 2, size.height * 0.5);
    path.quadraticBezierTo(size.width + borderDiff * 2, size.height * 0.7, size.width, size.height * 0.7);
    path.lineTo(size.width, size.height - borderDiff);
    path.quadraticBezierTo(size.width, size.height, size.width - borderDiff, size.height);

    path.lineTo(borderDiff, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - borderDiff);
    path.lineTo(0, borderDiff);
    path.quadraticBezierTo(0, 0, borderDiff, 0);
  
    return path;
  }

  Path _generateBottomRightPiece(Size size) {
    Path path = new Path();
    final double borderDiff = 20;

    path.moveTo(borderDiff, 0);

    path.lineTo(size.width * 0.275, 0);
    path.quadraticBezierTo(size.width * 0.3, -borderDiff * 1.5, size.width * 0.5, -borderDiff * 1.5);
    path.quadraticBezierTo(size.width * 0.7, -borderDiff * 1.5, size.width * 0.725, 0);
    path.lineTo(size.width - borderDiff, 0);

    path.quadraticBezierTo(size.width, 0, size.width, borderDiff);
    path.lineTo(size.width, size.height - borderDiff);
    path.quadraticBezierTo(size.width, size.height, size.width - borderDiff, size.height);

    path.lineTo(borderDiff, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - borderDiff);
    
    path.lineTo(0, size.height * 0.7);
    path.quadraticBezierTo(borderDiff * 2, size.height * 0.7, borderDiff * 2, size.height * 0.5);
    path.quadraticBezierTo(borderDiff * 2, size.height * 0.3, 0, size.height * 0.3);
    path.lineTo(0, borderDiff);
    path.quadraticBezierTo(0, 0, borderDiff, 0);
  
    return path;
  }
  
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}