import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/pages/portal_home/portal_home_page.dart';
import 'package:tecnonautas_app/src/pages/ranking/ranking_page.dart';

class Router {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    
    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => PortalHomePage());
      case 'ranking':
        return MaterialPageRoute(builder: (_) => RankingPage());
      default: 
        return MaterialPageRoute(builder: (_) => PortalHomePage());
    }

  }
}