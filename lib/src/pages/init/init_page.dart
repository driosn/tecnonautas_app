import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/pages/auth/auth_page.dart';
import 'package:tecnonautas_app/src/pages/home/trivias_page.dart';
import 'package:tecnonautas_app/src/pages/portal_home/portal_home_page.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';

class InitPage extends StatelessWidget {
  
  UserPreferences prefs = UserPreferences();
  
  @override
  Widget build(BuildContext context) {
    if (prefs.id != null) {
      return PortalHomePage();
    }
    return AuthPage();
  }
}