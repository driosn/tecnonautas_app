import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tecnonautas_app/src/pages/edit_profile/widgets/profile_info_label.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/widgets/custom_plain_appbar.dart';
import 'package:tecnonautas_app/src/widgets/gradient_button.dart';
import 'package:tecnonautas_app/src/widgets/tecnonautas_circular_avatar.dart';

class EditProfilePage extends StatelessWidget {
  
  final double _pagePadding = 20;
  final double _buttonRadius = 12;

  final double _verticalSpacing = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPlainAppbar(mTitle: 'Editar mi información'),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(_pagePadding),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _editPhoto(),
              _profileData(),
              SizedBox(height: _verticalSpacing),
              GradientButton(
                mRadius: _buttonRadius,
                mText: _saveChangesLbl(), 
                mColors: <Color> [
                  accent,
                  primary
                ], 
                mOnPressed: _saveChanges
              )
            ],
          ),
        ),
      ),
    );    
  }

  Widget _saveChangesLbl() {
    final double _spaceSize = 5;
    
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(FontAwesomeIcons.checkCircle, color: Colors.white),
          SizedBox(width: _spaceSize),
          Text(
            'GUARDAR CAMBIOS', 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _profileData() {
    final double _verticalSpacing = 35;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: double.infinity),
        ProfileInfoLabel(
          title: 'Nombres', 
          content: Text('David Samuel')
        ),
        SizedBox(height: _verticalSpacing),
        ProfileInfoLabel(
          title: 'Apellidos', 
          content: Text('Rios Nuñez')
        ),
        SizedBox(height: _verticalSpacing),
        ProfileInfoLabel(
          title: 'Fecha de Nacimiento', 
          content: Text('03 de Febrero de 1999')
        ),
        SizedBox(height: _verticalSpacing),
        ProfileInfoLabel(
          title: 'Ciudad', 
          content: Text('La Paz')
        ),
        SizedBox(height: _verticalSpacing),
        ProfileInfoLabel(
          title: 'Numero de Teléfono', 
          content: Text('67305722')
        ),
      ],
    );
  }

  Widget _editPhoto() {
    final double _width = 200;

    return Stack(
      children: <Widget>[
        Container(
          width: _width,
          child: TecnonautasCircularAvatar.large(
            mAvatarImage: AssetImage('assets/images/avatar.jpg'),
          ),
        ),

        Positioned(
          right: 0,
          bottom: 0,
          child: _editButton(),
        )
      ],
    );
  }

  Widget _editButton() {
    final Icon editIcon = Icon(FontAwesomeIcons.edit, color: leadingColor);
    final double _horizontalSpace = 5;

    return GestureDetector(
      child: Container(
        child: Row(
          children: <Widget>[
            editIcon,
            SizedBox(width: _horizontalSpace),
            Text('Editar', style: TextStyle(color: leadingColor))
          ],
        ),
      ),
      onTap: _editImage,
    );
  }

  // TODO: Edit Image Action
  void _editImage() {

  }

  // TODO: Save Changes
  void _saveChanges() {

  }
}