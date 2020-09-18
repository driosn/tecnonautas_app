import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecnonautas_app/src/pages/play/widgets/game_counter.dart';
import 'package:tecnonautas_app/src/pages/questions/question_page.dart';
import 'package:tecnonautas_app/src/pages/questions_local/question_local_page.dart';
import 'package:tecnonautas_app/src/providers/questions_model.dart';

class PlayPageLocal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => QuestionsModel(),
        child: Builder(
          builder: (BuildContext context) {
            
            final isCounter = Provider.of<QuestionsModel>(context).isCounter;

            return isCounter ? GameCounter() :  QuestionLocalPage();

          },
        )
      ),
    );
  }
}