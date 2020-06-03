import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/pages/home/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xff41C0D3),
        accentColor: Color(0xff723A7C),
        primaryColorLight: Color(0xff99E0E8),
        textTheme: TextTheme(
          title: TextStyle(
            color: Color(0xff723A7C),
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
          subtitle: TextStyle(
            color: Color(0xff41C0D3),
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        )
      ),
      home: HomePage(),
    );
  }
}