import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/widgets/custom_plain_appbar.dart';

class SettingsItem {

  final IconData itemIcon;  
  final String title;

  SettingsItem(
    this.itemIcon,
    this.title,
  );
}

class SettingsPage extends StatelessWidget {
  
  final List<SettingsItem> _items = [
    SettingsItem(FontAwesomeIcons.edit, 'Editar mi información'),
    SettingsItem(FontAwesomeIcons.lock, 'Cambiar contraseña'),
    SettingsItem(FontAwesomeIcons.questionCircle, 'Preguntas Frecuentes'),
    SettingsItem(FontAwesomeIcons.mailBulk, 'Contáctanos'),
    SettingsItem(FontAwesomeIcons.plus, '¿Quiénes somos?'),
    SettingsItem(FontAwesomeIcons.windowClose, 'Salir'),
  ];
  
  final double _settingsPadding = 14;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomPlainAppbar(mTitle: 'Ajustes'),
      body: Padding(
        padding: EdgeInsets.all(_settingsPadding),
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (BuildContext context, int index) {

            return _settingsListTile(context, _items[index]);

          },
        ),
      ),
    );
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
      onTap: () => _goToSelectedPage(context, SettingsPage()),
    );
  }

  void _goToSelectedPage(BuildContext context, Widget mPage) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => mPage
    ));
  }

}