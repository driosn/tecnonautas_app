import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecnonautas_app/src/providers/portal_home_model.dart';

class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final portalHomeModel = Provider.of<PortalHomeModel>(context, listen: false);
      portalHomeModel.isTriviasPage = false;
    });

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Ranking page'),
      ),
    );
  }
}