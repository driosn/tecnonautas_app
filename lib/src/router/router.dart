import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/pages/auth/auth_page.dart';
import 'package:tecnonautas_app/src/pages/edit_profile/edit_profile_page.dart';
import 'package:tecnonautas_app/src/pages/finished_trivia/finished_trivia_page.dart';
import 'package:tecnonautas_app/src/pages/init/init_page.dart';
import 'package:tecnonautas_app/src/pages/play/play_page.dart';
import 'package:tecnonautas_app/src/pages/portal_home/portal_home_page.dart';
import 'package:tecnonautas_app/src/pages/questions/question_page.dart';
import 'package:tecnonautas_app/src/pages/ranking/ranking_page.dart';
import 'package:tecnonautas_app/src/pages/settings/settings_page.dart';
import 'package:tecnonautas_app/src/pages/trivia_status/trivia_status_page.dart';
import 'package:tecnonautas_app/src/pages/verify_phone/verify_phone.dart';

class Router {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    
    switch(settings.name) {
      case '/':
        // return MaterialPageRoute(builder: (_) => VerifyPhone());
        return MaterialPageRoute(builder: (_) => InitPage());
        return MaterialPageRoute(builder: (_) => AuthPage());
        return MaterialPageRoute(builder: (_) => PortalHomePage());
        // return MaterialPageRoute(builder: (_) => TriviaStatusPage());
        // return MaterialPageRoute(builder: (_) => FinishedTriviaPage());
      case 'ranking':
        return MaterialPageRoute(builder: (_) => RankingPage());
      case 'play':
        return MaterialPageRoute(builder: (_) => PlayPage());
      case 'questions':
        return MaterialPageRoute(builder: (_) => QuestionPage());
      case 'settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case 'edit_profile':
        return MaterialPageRoute(builder: (_) => EditProfilePage());
      default: 
        return MaterialPageRoute(builder: (_) => PortalHomePage());
    }

  }
}