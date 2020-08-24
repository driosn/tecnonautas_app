import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tecnonautas_app/core/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:tecnonautas_app/src/pages/edit_profile/widgets/profile_info_label.dart';
import 'package:tecnonautas_app/src/pages/portal_home/portal_home_page.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/utils/parse_birthday.dart';
import 'package:tecnonautas_app/src/utils/show_loading.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';
import 'package:tecnonautas_app/src/widgets/avatar_image_selector_dialog.dart';
import 'package:tecnonautas_app/src/widgets/custom_plain_appbar.dart';
import 'package:tecnonautas_app/src/widgets/gradient_button.dart';
import 'package:tecnonautas_app/src/widgets/tecnonautas_circular_avatar.dart';

class EditProfilePage extends StatefulWidget {
  
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  
  final double _pagePadding = 20;
  final double _buttonRadius = 12;
  final double _verticalSpacing = 20;

  UserPreferences prefs = UserPreferences();
  EditProfileBloc editProfileBloc = EditProfileBloc();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    editProfileBloc.changeAvatar(prefs.avatar);
    editProfileBloc.changeName(prefs.name);
    editProfileBloc.changeLastname(prefs.lastname);
    editProfileBloc.changeBirthdate(prefs.birthdate);
    editProfileBloc.changeCity(prefs.city);
    editProfileBloc.changePhone(int.parse(prefs.phone));

    _nameController.text = prefs.name;
    _lastnameController.text = prefs.lastname;
    _birthdateController.text = parseBirthday(DateTime.parse(prefs.birthdate));
    _cityController.text = prefs.city;
    _phoneController.text = prefs.phone;
  }

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
                mOnPressed: () => _saveChanges(context)
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

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: double.infinity),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nombre',
              labelStyle: TextStyle(color: titleSettingColor, fontSize: 18, fontWeight: FontWeight.normal),
              border: InputBorder.none
            ),
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),
            onChanged: editProfileBloc.changeName,
          ),
          TextField(
            controller: _lastnameController,
            decoration: InputDecoration(
              labelText: 'Apellido',
              labelStyle: TextStyle(color: titleSettingColor, fontSize: 18, fontWeight: FontWeight.normal),
              border: InputBorder.none
            ),
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),
            onChanged: editProfileBloc.changeLastname,
          ),
          TextField(
            controller: _birthdateController,
            decoration: InputDecoration(
              labelText: 'Fecha de Nacimiento',
              labelStyle: TextStyle(color: titleSettingColor, fontSize: 18, fontWeight: FontWeight.normal),
              border: InputBorder.none
            ),
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),
            onTap: () async {
                final dateTime = await showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(), 
                  firstDate: DateTime(1920), 
                  lastDate: DateTime.now()
                );
             
                if (dateTime != null) {
                  editProfileBloc.changeBirthdate(dateTime.toString());
                  _birthdateController.text = parseBirthday(DateTime.parse(editProfileBloc.birthdate));
                }
              },
            ),
          TextField(
            controller: _cityController,
            decoration: InputDecoration(
              labelText: 'Ciudad',
              labelStyle: TextStyle(color: titleSettingColor, fontSize: 18, fontWeight: FontWeight.normal),
              border: InputBorder.none
            ),
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),
            onChanged: editProfileBloc.changeCity,
          ),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: 'Numero de Telefono',
              labelStyle: TextStyle(color: titleSettingColor, fontSize: 18, fontWeight: FontWeight.normal),
              border: InputBorder.none
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),
            onChanged: (newPhone) => editProfileBloc.changePhone(int.parse(newPhone)),
          ),
        ],
      ),
    );
  }

  Widget _editPhoto() {
    final double _width = 200;

    return Stack(
      children: <Widget>[
        StreamBuilder(
          initialData: prefs.avatar,
          stream: editProfileBloc.avatarStream,
          builder: (context, snapshot) {
            String imageName = snapshot.data;
            
            return Container(
              width: _width,
              child: TecnonautasCircularAvatar.large(
                mAvatarImage: AssetImage('assets/images/avatars/$imageName.png'),
              ),
            );
          }
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
      onTap: () {
        showAvatarSelectorDialog(context);
      },
    );
  }

  void showAvatarSelectorDialog(context) {
    showDialog(
      context: context,
      builder: (context) => AvatarImageSelectorDialog.edit(
        mEditProfileBloc: this.editProfileBloc
      )
    );
  }

  void _editImage() {

  }

  void _saveChanges(context) async {
    try {
      showLoading(context);
      final response = await editProfileBloc.updateProfile();
      
      if (response) {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => PortalHomePage()), (route) => false);
      }
    } catch (error) {
      Navigator.pop(context);
    }

  }
}