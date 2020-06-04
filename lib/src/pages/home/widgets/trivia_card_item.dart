import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/widgets/circle_container.dart';

class TriviaItem {

  final int questionsNumber;
  final bool isCompleted;
  final bool isFavorite;
  final String triviaTitle;

  TriviaItem({
    @required this.questionsNumber,
    @required this.isCompleted,
    @required this.isFavorite,
    @required this.triviaTitle
  });

}

class TriviaCardItem extends StatelessWidget {
  
  TriviaItem mTriviaItem;
  
  TriviaCardItem(this.mTriviaItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleContainer(
                mColor: primaryLight,
                mSize: 30,
                mChild: Text(mTriviaItem.questionsNumber.toString(), style: Theme.of(context).textTheme.subtitle.copyWith(color: accent)),
              ),
              SizedBox(width: 5),
              Text('Preguntas', style: TextStyle(fontSize: 10)),
              Spacer(),
              if(mTriviaItem.isCompleted) Icon(Icons.check, color: accent), 
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                mTriviaItem.triviaTitle, 
                style: Theme.of(context).textTheme.subtitle.copyWith(color: accent),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              InkWell(
                child: mTriviaItem.isFavorite
                      ? Icon(Icons.favorite, color: favoriteColor)
                      : Icon(Icons.favorite_border, color: darkGrey),
                onTap: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}