import 'package:flutter/material.dart';
import 'package:gradient_bottom_navigation_bar/gradient_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:tecnonautas_app/src/pages/home/trivias_page.dart';
import 'package:tecnonautas_app/src/pages/ranking/ranking_page.dart';
import 'package:tecnonautas_app/src/providers/portal_home_model.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class NavbarItem {

  IconData mIcon;
  String mTitle;

  NavbarItem({@required this.mIcon, @required this.mTitle});

}

class PortalHomePage extends StatefulWidget {
  
  @override
  _PortalHomePageState createState() => _PortalHomePageState();
}

class _PortalHomePageState extends State<PortalHomePage> {
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _SelectedPage(),
      bottomNavigationBar: _BottomNavBar()
    );
  }
}

class _SelectedPage extends StatelessWidget {

  final List<Widget> widgetPages = [
    TriviasPage(),
    RankingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    
    final portalHomeModel = Provider.of<PortalHomeModel>(context);
    
    return Center(
      child: widgetPages.elementAt(portalHomeModel.selectedNavbarIndex),
    );
  }
}

class _BottomNavBar extends StatefulWidget {
  @override
  __BottomNavBarState createState() => __BottomNavBarState();
}

class __BottomNavBarState extends State<_BottomNavBar> {
  
  List<NavbarItem> navbarItemList = [
    new NavbarItem(mIcon: Icons.line_weight, mTitle: 'Trivias'),
    new NavbarItem(mIcon: Icons.line_weight, mTitle: 'Ranking'),
  ]; 

  @override
  Widget build(BuildContext context) {
    
    final portalHomeModel = Provider.of<PortalHomeModel>(context);
    
    return GradientBottomNavigationBar(
      backgroundColorStart: portalHomeModel.isTriviasPage ? Colors.white : accent,
      backgroundColorEnd: portalHomeModel.isTriviasPage ? Colors.white : primary,
      items: navbarItemList.map((item) {

        int itemIndex = navbarItemList.indexOf(item);

        return BottomNavigationBarItem(
          icon: Icon(item.mIcon),
          title: itemIndex == portalHomeModel.selectedNavbarIndex
                ? _underlinedText(item.mTitle)
                : Text(item.mTitle)
        );


      }).toList(),
      currentIndex: portalHomeModel.selectedNavbarIndex,
      onTap: (index) => _onItemTapped(index, context),
      fixedColor: portalHomeModel.isTriviasPage ? accent : Colors.white,
    );
  }

  Widget _underlinedText(String title) {  
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(title),
        SizedBox(height: 5),
        Container(
          width: size.width / 5,
          height: 5,
          color: Colors.white,
        )
      ],
    );
  }

  void _onItemTapped(int index, context) {
    final portalHomeModel = Provider.of<PortalHomeModel>(context, listen: false);
    print('Index: ' + index.toString());
    portalHomeModel.selectedNavbarIndex = index;
  }
}