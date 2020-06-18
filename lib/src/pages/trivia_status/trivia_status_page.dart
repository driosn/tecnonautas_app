import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/pages/trivia_status/widgets/question_status_button.dart';
import 'package:tecnonautas_app/src/pages/trivia_status/widgets/trivia_status_description.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/widgets/info_card.dart';

class TriviaStatusPage extends StatelessWidget {
  
  final double _horizontalPadding = 10;
  final double _verticalPadding = 15;
  final double _cardHeight = 160;
  final double _verticalSpacing = 10;
  final double _horizontalSpacing = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TriviaStatusPage')),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _horizontalPadding, 
            vertical: _verticalPadding
          ),
          child: Column(
            children: <Widget>[
              TriviaStatusDescription(
                mTitle: 'Fórmulas Químicas',
                mDescription: 'Las fórmulas químicas son la representación de los elementos que forman un compuesto y la proporción en que se encuentran.',
                mIsFavorite: false,
              ),
              SizedBox(height: _verticalSpacing),
              _triviaInformation(context),
              SizedBox(height: _verticalSpacing),
              _questionsStatusList()
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardContent(BuildContext context, String mNumber, String mMiniDesc, {bool isGold}) {
    
    final double contentPadding = 12;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: contentPadding),
        Text(
          mNumber, 
          style: Theme.of(context).textTheme.headline4.copyWith(
            color: Colors.black54, fontWeight: FontWeight.bold
        )),
        Text(
          mMiniDesc, 
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400),
        ) 
      ],
    );
  }

  Widget _triviaInformation(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: InfoCard(
              mHeight: _cardHeight, 
              mTitle: 'Responde', 
              mIcon: Icon(Icons.ac_unit, color: accent), 
              mChild: _cardContent(context, '4', 'Preguntas \n(lo antes posible)', isGold: false)
            ),
          ),
          SizedBox(width: _horizontalSpacing),
          Expanded(
            child: InfoCard(
              mHeight: _cardHeight, 
              mTitle: 'Gana', 
              mIcon: Image.asset('assets/images/gold_coin.png'), 
              mChild: _cardContent(context, '4', 'Preguntas \n(lo antes posible)', isGold: true)
            ),
          ),
        ],
      ),
    );
  }

  Widget _questionsStatusList() {
    return Container(
      child: Column(
        children: <Widget>[
          QuestionStatusButton.correct(
            mPointsNumber: 0, 
            mQuestionNumber: 1,
            mOnPressed:_questionButtonAction,
          ),
          SizedBox(height: 10),
          QuestionStatusButton.incorrect(
            mPointsNumber: 2.5, 
            mQuestionNumber: 2,
            mOnPressed: _questionButtonAction,
          ),
          SizedBox(height: 10),
          QuestionStatusButton.ready(
            mPointsNumber: 2.5, 
            mQuestionNumber: 3,
            mOnPressed: _questionButtonAction,
          ),
          SizedBox(height: 10),
          QuestionStatusButton.waiting(
            mPointsNumber: 2.5, 
            mQuestionNumber: 4,
            mOnPressed: _questionButtonAction,
          ),
        ],
      ),
    );
  }

  void _questionButtonAction() {

  }

}