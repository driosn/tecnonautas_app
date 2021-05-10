import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tecnonautas_app/src/pages/auth/auth_page.dart';
import 'package:tecnonautas_app/src/pages/edit_profile/edit_profile_page.dart';
import 'package:tecnonautas_app/src/pages/home/trivias_page.dart';
import 'package:tecnonautas_app/src/pages/info_pages/about_us_page.dart';
import 'package:tecnonautas_app/src/pages/info_pages/change_password_page.dart';
import 'package:tecnonautas_app/src/pages/info_pages/contact_us_page.dart';
import 'package:tecnonautas_app/src/pages/info_pages/frequent_questions_page.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';
import 'package:tecnonautas_app/src/widgets/custom_plain_appbar.dart';

class SettingsItem {

  final IconData itemIcon;  
  final String title;
  final Function mOnPressed;

  SettingsItem(
    this.itemIcon,
    this.title,
    this.mOnPressed
  );
}

class SettingsPage extends StatelessWidget {
  
 
  
  final double _settingsPadding = 14;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomPlainAppbar(mTitle: 'Ajustes'),
      body: Padding(
        padding: EdgeInsets.all(_settingsPadding),
        child: ListView.builder(
          itemCount: _items(context).length,
          itemBuilder: (BuildContext context, int index) {

            return _settingsListTile(context, _items(context)[index]);

          },
        ),
      ),
    );
  }

  List<SettingsItem> _items(context) {
    List<SettingsItem> items = [
      SettingsItem(FontAwesomeIcons.edit, 'Editar mi información', () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
      }),

      SettingsItem(FontAwesomeIcons.lock, 'Cambiar contraseña', () => _goToSelectedPage(context, ChangePasswordPage())),

      SettingsItem(FontAwesomeIcons.questionCircle, 'Preguntas Frecuentes', () => _goToSelectedPage(context, FrequentQuestionsPage())),

      SettingsItem(FontAwesomeIcons.mailBulk, 'Contáctanos', () => _goToSelectedPage(context, ContactUsPage())),

      SettingsItem(FontAwesomeIcons.plus, '¿Quiénes somos?', () => _goToSelectedPage(context, AboutUsPage())),

      SettingsItem(FontAwesomeIcons.windowClose, 'Salir', () {
        UserPreferences prefs = UserPreferences();
        prefs.deleteUser();

        Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (_) => AuthPage()), (route) => false);
      }),
    ];

    return items;
  }

  Widget _settingsListTile(BuildContext context, SettingsItem mItem) {
    final double _iconSize = 20;
    
    return ListTile(
      leading: FaIcon(
        mItem.itemIcon,
        color: leadingColor,
        size: _iconSize,
      ),
      title: Text(
        mItem.title,
        style: TextStyle(color: titleTileColor),
      ),
      onTap: mItem.mOnPressed,
    );
  }

  void _goToSelectedPage(BuildContext context, Widget mPage) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => mPage
    ));
  }

}