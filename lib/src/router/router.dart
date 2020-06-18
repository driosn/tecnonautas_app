import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/pages/play/play_page.dart';
import 'package:tecnonautas_app/src/pages/portal_home/portal_home_page.dart';
import 'package:tecnonautas_app/src/pages/questions/question_page.dart';
import 'package:tecnonautas_app/src/pages/ranking/ranking_page.dart';
import 'package:tecnonautas_app/src/pages/trivia_status/trivia_status_page.dart';

class Router {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    
    switch(settings.name) {
      case '/':
        // return MaterialPageRoute(builder: (_) => PortalHomePage());
        return MaterialPageRoute(builder: (_) => TriviaStatusPage());
      case 'ranking':
        return MaterialPageRoute(builder: (_) => RankingPage());
      case 'play':
        return MaterialPageRoute(builder: (_) => PlayPage());
      case 'questions':
        return MaterialPageRoute(builder: (_) => QuestionPage());
      default: 
        return MaterialPageRoute(builder: (_) => PortalHomePage());
    }

  }
}