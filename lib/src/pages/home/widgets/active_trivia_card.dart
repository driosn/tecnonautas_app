import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/pages/home/widgets/trivia_info_dialog.dart';
import 'package:tecnonautas_app/src/widgets/circle_container.dart';
import 'package:tecnonautas_app/src/widgets/subtitie.dart';

class ActiveTriviaCard extends StatelessWidget {
  
  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: <Widget> [
                Row(
                  children: <Widget> [
                    Text(
                      'Fórmulas Químicas', 
                      style: Theme.of(context).textTheme.subtitle.merge(
                        TextStyle(color: Theme.of(context).accentColor)
                      )
                    ),
                    Expanded(child: SizedBox(height: 0)),
                    Text('10', 
                      style: Theme.of(context).textTheme.subtitle.merge(
                        TextStyle(color: Theme.of(context).accentColor)
                      )
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.android, size: 18, color: Theme.of(context).accentColor)
                  ]
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget> [
                          CircleContainer(
                            mSize: 55,
                            mColor: Theme.of(context).primaryColorLight,
                            mChild: Text('4', style: Theme.of(context).textTheme.title),
                          ),
                          SizedBox(width: 30),
                          Expanded(
                            child: Text(
                              'Las fórmulas químicas son la representación de los elementos que forman un compuesto y la proporción en que se encuentran',
                              maxLines: 100,
                            )
                          )
                        ]
                      ),
                      Text('Preguntas', style: TextStyle(fontSize: 12))                
                    ],
                  ),
                )
              ]
            )
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.add_circle_outline),
              color: Colors.grey,
            ),
          )
        ],
      ),
      onTap: () => _showActiveTriviaDialog(context),
    );
  }

  void _showActiveTriviaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => TriviaInfoDialog()
    );
  } 
}

