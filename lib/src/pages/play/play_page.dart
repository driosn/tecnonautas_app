import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecnonautas_app/src/pages/play/widgets/game_counter.dart';
import 'package:tecnonautas_app/src/pages/questions/questions_page.dart';
import 'package:tecnonautas_app/src/providers/questions_model.dart';

class PlayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => QuestionsModel(),
        child: Builder(
          builder: (BuildContext context) {
            
            final isCounter = Provider.of<QuestionsModel>(context).isCounter;

            return isCounter ? GameCounter() :  QuestionsPage();

          },
        )
      ),
    );
  }
}