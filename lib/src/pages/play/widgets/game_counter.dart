import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecnonautas_app/src/providers/questions_model.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class _CounterItem {
  String content;
  Color color;

  _CounterItem({this.content, this.color});
}

class GameCounter extends StatefulWidget {
  
  @override
  _GameCounterState createState() => _GameCounterState();
}

class _GameCounterState extends State<GameCounter> {
  
  Timer _timer;
  int _counterIndex = 0;

  List<_CounterItem> counterItemList = [
    new _CounterItem(content: '3', color: numberThree),
    new _CounterItem(content: '2', color: numberTwo),
    new _CounterItem(content: '1', color: numberOne),
    new _CounterItem(content: 'Vamos!', color: finalMessage),
  ];

  @override
  void initState() {
    super.initState();
 
    startTimer();
  }
  
  void startTimer() {
    final questionsModel = Provider.of<QuestionsModel>(context, listen: false);
    
    const oneSec = const Duration(seconds: 1);
      _timer = new Timer.periodic(
        oneSec,
        (Timer timer) => setState(
          () {
            if (_counterIndex > 2) {
              questionsModel.isCounter = false;
              timer.cancel();
            } else {
              _counterIndex = _counterIndex + 1;
            }
          },
        ),
    );
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Builder(
          builder: (BuildContext context) {

            // final counterIndex = Provider.of<_GameCounterModel>(context, listen: false).counterIndex;
            return _CounterNumber(counterItemList[_counterIndex]);

          },  
        ),
      )
    );
  }
}

class _CounterNumber extends StatelessWidget {
  
  final _CounterItem counterItem;
  
  _CounterNumber(this.counterItem);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${counterItem.content}',
      style: Theme.of(context).textTheme.headline2.copyWith(
        fontWeight: FontWeight.bold,
        color: counterItem.color
      ),
    );
  }
}

class _GameCounterModel with ChangeNotifier {

  int _counterIndex = 0;

  int get counterIndex => this.counterIndex;

  void addOne() {
    this._counterIndex++;
    notifyListeners();
  }

}