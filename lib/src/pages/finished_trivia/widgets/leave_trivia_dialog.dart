import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/widgets/gradient_button.dart';
import 'package:tecnonautas_app/src/widgets/gradient_container.dart';
import 'package:tecnonautas_app/src/widgets/rounded_button.dart';

class LeaveTriviaDialog extends StatelessWidget {

  final double _verticalSpacing = 20;
  final double _mainRadius = 12;

  final double _positionValue = -5;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_mainRadius)
      ),
      child: _Content(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _leaveTitle(context),
            SizedBox(height: _verticalSpacing),
            _leaveWarning(),
            SizedBox(height: _verticalSpacing),
            _leaveButton(context),
          ],
        ),
      )
    );
  }


  Widget _leaveTitle(BuildContext context) {
    return Text(
      'Abandonar Trivia',
      style: Theme.of(context).textTheme.subtitle2.copyWith(
        color: accent
      ),
    );
  }

  Widget _leaveWarning() {
    final String warningLbl = 'Estas seguro que quieres abandonar la trivia?\nTodas las respuestas quedarán eliminadas si abandonas la trivia.';
    
    return Text(
      warningLbl,
      textAlign: TextAlign.center,
    );
  }

  Widget _leaveButton(BuildContext context) {
    final double _buttonWidth = 155;
    final double _buttonHeight = 38;
    
    final Color _firstColor = Color(0xffB90808);
    final Color _secondColor = Color(0xffED6238);

    return GradientButton(
      mRadius: _mainRadius,
      mHeight: _buttonHeight,
      mWidth: _buttonWidth,
      mText: Text(
        'ABANDONAR TRIVIA',
        style: Theme.of(context).textTheme.subhead,
      ),
      mColors: <Color> [
        _firstColor,
        _secondColor
      ],
      mOnPressed: () => _leaveTrivia(context),
    );
  }

  void _leaveTrivia(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/');
  }
}

class _Content extends StatelessWidget {
  
  final Widget child;

  _Content({@required this.child});

  final double _dialogWidth = 100;
  final double _verticalPadding = 30;
  final double _horizontalPadding = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: _verticalPadding / 2,
        left: _horizontalPadding,
        right: _horizontalPadding,
        bottom: _verticalPadding
      ),
      width: _dialogWidth,    
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(alignment: Alignment.centerRight, child: _closeIcon(context)),
          child
        ],
      ),
    );
  }

  Widget _closeIcon(BuildContext context) {
    return GestureDetector(
      child: Icon(Icons.close),
      onTap: () => Navigator.pop(context),
    );
  }

}

