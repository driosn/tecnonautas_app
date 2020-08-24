import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tecnonautas_app/src/providers/portal_home_model.dart';
import 'package:tecnonautas_app/src/providers/push_notifications_provider.dart';
import 'package:tecnonautas_app/src/router/router.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPreferences();

  
  runApp(MyApp());
}
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

    final pushProvider = new PushNotificationsProvider();
    pushProvider.initNotifications();

    pushProvider.mensajesStream.listen((argumento) {
      
      print('Argumento desde main: $argumento');

    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PortalHomeModel())
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('es', 'ES')
        ],
        debugShowCheckedModeBanner: false,
        title: 'Tecnonautas App',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xff40C1D4),
          accentColor: Color(0xff723A7C),
          primaryColorLight: Color(0xff99E0E8),
          scaffoldBackgroundColor: Color(0xffF4F7FD),
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
            subhead: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold
            ) 
          )
        ),
        initialRoute: '/',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}