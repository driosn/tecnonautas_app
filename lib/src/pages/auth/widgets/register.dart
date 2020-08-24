import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/auth/auth_bloc.dart';
import 'package:tecnonautas_app/core/bloc/register/register_bloc.dart';
import 'package:tecnonautas_app/core/bloc/user_ranking/user_ranking_bloc.dart';
import 'package:tecnonautas_app/src/pages/auth/auth_page.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/utils/parse_birthday.dart';
import 'package:tecnonautas_app/src/utils/show_loading.dart';
import 'package:tecnonautas_app/src/widgets/avatar_image_selector_dialog.dart';
import 'package:tecnonautas_app/src/widgets/main_yellow_button.dart';

class Register extends StatelessWidget {
  
  RegisterBloc registerBloc = RegisterBloc();

  // id
  // name
  // username
  // birthdate
  // phone
  // grade
  // avatar
  // city

  TextEditingController _birthdateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Crear nueva cuenta', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(height: 24),

                TextField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Nombre',
                  ),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                  onChanged: registerBloc.changeName,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Apellido'
                  ),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                  onChanged: registerBloc.changeLastname
                ),
                TextField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Nombre de usuario'
                  ),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                  onChanged: registerBloc.changeNickname
                ),
                TextField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Contraseña',
                  ),
                  obscureText: true,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                  onChanged: registerBloc.changePassword
                ),
                TextField(
                  controller: _birthdateController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Fecha de Nacimiento'
                  ),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                  onTap: () async {
                    final dateTime = await showDatePicker(
                      locale: Locale('es', 'ES'),
                      context: context, 
                      initialDate: DateTime.now(), 
                      firstDate: DateTime(1920), 
                      lastDate: DateTime.now()
                    );
                 
                    if (dateTime != null) {
                      registerBloc.changeBirthdate(dateTime.toString());
                      _birthdateController.text = parseBirthday(dateTime);
                    }
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Celular'
                  ),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                  onChanged: registerBloc.changePhone,
                  keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Curso'
                  ),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                  onChanged: registerBloc.changeGrade
                ),
                // TextField(
                //   decoration: InputDecoration(
                //     labelStyle: TextStyle(color: Colors.white),
                //     labelText: 'avatar'
                //   ),
                //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                //   onChanged: registerBloc.changeAvatar
                // ),

                if (registerBloc.avatar != "") SizedBox(height: 20),

                StreamBuilder(
                  initialData: "",
                  stream: registerBloc.avatarStream,
                  builder: (context, snapshot) {
                    String selectedImage = snapshot.data;
                    
                    return selectedImage == "" || selectedImage == null
                          ? Container()
                          : selectedAvatarImage(selectedImage);

                  }
                ),

                SizedBox(height: 20),

                RaisedButton(
                  color: primary,
                  child: Text(
                    'Seleccionar Avatar', 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                  ),
                  onPressed: () {
                    showAvatarSelectorDialog(context);
                  },
                ),

                TextField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Ciudad'
                  ),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                  onChanged: registerBloc.changeCity
                ),
                SizedBox(height: 50),
                _registerButton(),

                SizedBox(height: 50),
                changeToLoginButton(),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      )
    );
  }

  void showAvatarSelectorDialog(context) {
    showDialog(
      context: context,
      builder: (context) => AvatarImageSelectorDialog()
    );
  }

  Widget selectedAvatarImage(String mAvatarNumber) {
    return CircleAvatar(
      backgroundImage: AssetImage('assets/images/avatars/$mAvatarNumber.png'),
      radius: 40,
    );
  }

  Widget changeToLoginButton() {
    return FlatButton(
      child: Text(
        '¿Ya tienes cuenta?\nIniciar Sesion', 
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,  fontSize: 18),
      ),
      onPressed: () => authBloc.changeAuthOption(AuthOption.LOGIN)
    );
  }

  Widget _registerButton() {
    return StreamBuilder(
      stream: registerBloc.correctFormDataStream,
      builder: (context, snapshot) {
        bool correctForm = false;
        if (snapshot.hasData && snapshot.data == true) correctForm = true;
        
        print("Mi avatar");
        print(registerBloc.avatar);
        print("Fin de mi avatar");

        return (correctForm && registerBloc.avatar != null && registerBloc.avatar != "")
                ? MainYellowButton(
                    mOnPressed: () async {
                      try {
                        showLoading(context);
                        await registerBloc.createNewUser();

                        Navigator.pop(context);

                        resetRegisterValues();

                        authBloc.changeAuthOption(AuthOption.LOGIN);
                      } catch (error) {
                        Navigator.pop(context);
                        Flushbar(
                          title:  "Error",
                          message:  "No se pudo crear el usuario correctamente",
                          duration:  Duration(seconds: 3),              
                        )..show(context);
                      }
                    },
                    mText: 'Crear nuevo usuario',
                  )
                : MainYellowButton.disabled(
                    mOnPressed: null, 
                    mText: 'Crear nuevo usuario'
                  );
      },
    );
  }

  void resetRegisterValues() {
    registerBloc.changeName(null);
    registerBloc.changeLastname(null);
    registerBloc.changeNickname(null);
    registerBloc.changePassword(null);
    registerBloc.changeBirthdate(null);
    registerBloc.changePhone(null);
    registerBloc.changeGrade(null);
    registerBloc.changeAvatar(null);
    registerBloc.changeCity(null);    
  }
}