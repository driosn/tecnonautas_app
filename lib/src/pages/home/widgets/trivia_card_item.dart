import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/models/trivia.dart';
import 'package:tecnonautas_app/src/pages/home/widgets/trivia_info_dialog.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/utils/db_provider.dart';
import 'package:tecnonautas_app/src/utils/local_trivias.dart';
import 'package:tecnonautas_app/src/widgets/circle_container.dart';

class TriviaItem {

  final int mTriviaId;
  final int questionsNumber;
  final bool isCompleted;
  bool isFavorite;
  final String triviaTitle;

  TriviaItem({
    @required this.mTriviaId,
    @required this.questionsNumber,
    @required this.isCompleted,
    @required this.isFavorite,
    @required this.triviaTitle
  });

}

class TriviaCardItem extends StatefulWidget {
  
  TriviaItem mTriviaItem; 
  TriviaCardItem(this.mTriviaItem);

  @override
  _TriviaCardItemState createState() => _TriviaCardItemState();
}

class _TriviaCardItemState extends State<TriviaCardItem> {  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
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
                  mChild: Text(widget.mTriviaItem.questionsNumber.toString(), style: Theme.of(context).textTheme.subtitle.copyWith(color: accent)),
                ),
                SizedBox(width: 5),
                Text('Preguntas', style: TextStyle(fontSize: 10)),
                Spacer(),
                if(widget.mTriviaItem.isCompleted) Icon(Icons.check, color: accent), 
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Text(
                    widget.mTriviaItem.triviaTitle, 
                    style: Theme.of(context).textTheme.subtitle.copyWith(color: accent),
                    textAlign: TextAlign.center,
                  ),
                )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  child: widget.mTriviaItem.isFavorite
                        ? Icon(Icons.favorite, color: favoriteColor)
                        : Icon(Icons.favorite_border, color: darkGrey),
                  onTap: () async {
                    if (widget.mTriviaItem.isFavorite) {
                      await DBProvider.db.setTriviaToNotFavorite(widget.mTriviaItem.mTriviaId);
                    } else {
                      await DBProvider.db.setTriviaToFavorite(widget.mTriviaItem.mTriviaId);
                    }
                    setState(() {
                      widget.mTriviaItem.isFavorite = !widget.mTriviaItem.isFavorite;
                    });
                  },
                )
              ],
            )
          ],
        ),
      ),

      onTap: () {

        Trivia selectedTrivia = localTrivias.firstWhere((element) => int.parse(element.id) == widget.mTriviaItem.mTriviaId);
        showDialog(
          context: context,
          builder: (context) {
            return TriviaInfoDialog(mTrivia: selectedTrivia, localTrivia: true);
          }
        );

      },


    );
  }
}