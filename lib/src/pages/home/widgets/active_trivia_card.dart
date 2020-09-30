import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tecnonautas_app/core/models/trivia.dart';
import 'package:tecnonautas_app/src/pages/home/widgets/trivia_info_dialog.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/widgets/circle_container.dart';
import 'package:tecnonautas_app/src/widgets/subtitie.dart';

class ActiveTriviaCard extends StatelessWidget {
  
  final Trivia mTrivia;

  ActiveTriviaCard({@required this.mTrivia});

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
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          mTrivia.name, 
                          style: Theme.of(context).textTheme.subtitle.merge(
                            TextStyle(color: Theme.of(context).accentColor)
                          ),
                        ),
                      ),
                    ),
                    Text(mTrivia.points.toString(), 
                      style: Theme.of(context).textTheme.subtitle.merge(
                        TextStyle(color: Theme.of(context).accentColor)
                      )
                    ),
                    SizedBox(width: 5),
                    SvgPicture.asset('assets/icons/cup.svg', color: accent),
                    // FaIcon(FontAwesomeIcons.trophy, size: 18, color: Theme.of(context).accentColor)
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
                            mChild: Text(mTrivia.questions.length.toString(), style: Theme.of(context).textTheme.title),
                          ),
                          SizedBox(width: 30),
                          Expanded(
                            child: Text(
                              // 'Las fórmulas químicas son la representación de los elementos que forman un compuesto y la proporción en que se encuentran',
                              mTrivia.description,
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
          // Positioned(
            // bottom: 0,
            // right: 0,
            // child: IconButton(
              // onPressed: () {},
              // icon: Icon(Icons.add_circle_outline),
              // color: Colors.grey,
            // ),
          // )
        ],
      ),
      onTap: () => _showActiveTriviaDialog(context),
    );
  }

  void _showActiveTriviaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => TriviaInfoDialog(mTrivia: mTrivia)
    );
  } 
}

