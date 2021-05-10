import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:password/password.dart';
import 'package:tecnonautas_app/core/bloc/auth/auth_bloc.dart';
import 'package:tecnonautas_app/core/bloc/login/login_bloc.dart';
import 'package:tecnonautas_app/core/bloc/register/register_bloc.dart';
import 'package:tecnonautas_app/core/bloc/user_ranking/user_ranking_bloc.dart';
import 'package:tecnonautas_app/core/models/user.dart';
import 'package:tecnonautas_app/src/pages/auth/auth_page.dart';
import 'package:tecnonautas_app/src/pages/portal_home/portal_home_page.dart';
import 'package:tecnonautas_app/src/pages/verify_phone/verify_phone.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/utils/parse_birthday.dart';
import 'package:tecnonautas_app/src/utils/show_loading.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';
import 'package:tecnonautas_app/src/utils/validators.dart';
import 'package:tecnonautas_app/src/widgets/avatar_image_selector_dialog.dart';
import 'package:tecnonautas_app/src/widgets/main_yellow_button.dart';
import 'package:uuid/uuid.dart';

class Register extends StatefulWidget {
  
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  RegisterBloc registerBloc = RegisterBloc();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> _grades = [
    "1 Prim.",
    "2 Prim.",
    "3 Prim.",
    "4 Prim.",
    "5 Prim.",
    "6 Prim.",
    "1 Sec.",
    "2 Sec.",
    "3 Sec.",
    "4 Sec.",
    "5 Sec.",
    "6 Sec.",
  ];

  List<String> _cities = [
    "La Paz",
    "Santa Cruz",
    "Cochabamba",
    "Beni",
    "Pando",
    "Oruro",
    "Sucre",
    "Tarija",
    "Potosi"
  ];

  String _selectedCity;
  String _selectedGrade;
  
  TextEditingController _birthdateController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();

  final double mTextSize = 16;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),

                      Container(
                        padding: EdgeInsets.all(12),
                        child: Center(
                          child: Text(
                            "Ingresa tus datos completos, nombres y apellidos como aparecen en tu Cedula de Identidad. Esta información puede ser usada para realizar premiaciones.",
                            style: TextStyle(
                              color: accent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: accent,
                            style: BorderStyle.solid,
                            width: 3
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(3, 3),
                              blurRadius: 10,
                              spreadRadius: 4,
                              color: Colors.black12
                            )
                          ]
                        ),
                      ),

                      SizedBox(height: 24),

                      TextFormField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Nombre',
                        ),
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: mTextSize),
                        validator: Validators.nameValidator,
                        onChanged: registerBloc.changeName
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Apellido',
                        ),
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: mTextSize),
                        validator: Validators.nameValidator,
                        onChanged: registerBloc.changeLastname
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Nombre de usuario',
                        ),
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: mTextSize),
                        validator: Validators.nameValidator,
                        onChanged: registerBloc.changeNickname
                      ),

                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Contraseña',
                        ),
                        obscureText: true,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: mTextSize),
                        validator: Validators.passwordValidator,
                        onChanged: registerBloc.changePassword
                      ),

                      TextFormField(
                        controller: _rePasswordController,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Confirmar contraseña',
                        ),
                        obscureText: true,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: mTextSize),
                        validator: (rePassword) {
                          if (Validators.passwordValidator(rePassword) != null) {
                            return Validators.passwordValidator(rePassword);
                          }

                          final password = _passwordController.text;
                          if (rePassword == password) {
                            return null;
                          } else {
                            return "Las contraseñas no coinciden";
                          }
                        },
                        onChanged: registerBloc.changeConfirmPassword
                      ),

                      TextField(
                        controller: _birthdateController,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Fecha de Nacimiento'
                        ),
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: mTextSize),
                        onTap: () async {
                          final dateTime = await showDatePicker(
                            locale: Locale('es', 'ES'),
                            context: context, 
                            initialDate: registerBloc.birthdate != null && registerBloc.birthdate != ""
                                         ? DateTime.parse(registerBloc.birthdate)
                                         : DateTime.now(), 
                            firstDate: DateTime(1920), 
                            lastDate: DateTime.now()
                          );
                       
                          if (dateTime != null) {
                            registerBloc.changeBirthdate(dateTime.toString());
                            _birthdateController.text = parseBirthday(dateTime);
                          }
                        },
                      ),

                      
                      TextFormField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Celular'
                        ),
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: mTextSize),
                        validator: Validators.phoneValidator,
                        onChanged: registerBloc.changePhone,
                        keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                      ),
                      
                      SizedBox(height: 20),

                      DropdownButton(
                        dropdownColor: accent,
                        value: _selectedGrade,
                        hint: Text("Seleccionar curso", style: TextStyle(color: Colors.white, fontSize: 16)),
                        items: _grades.map((grade) {
                          return DropdownMenuItem(
                            value: grade,
                            child: Text(grade, style: TextStyle(fontSize: 16),)
                          );
                        }).toList(), 
                        onChanged: (newGrade) {
                          setState(() {
                            _selectedGrade = newGrade;
                            registerBloc.changeGrade(newGrade);
                          });
                        }
                      ),


                      if (registerBloc.avatar != "") SizedBox(height: 20),

                      StreamBuilder(
                        initialData: "",
                        stream: registerBloc.avatarStream,
                        builder: (context, snapshot) {
                          String selectedImage = snapshot.data;
                          
                          return selectedImage == "" || selectedImage == null
                                ? Container()
                                : Center(child: selectedAvatarImage(selectedImage));

                        }
                      ),


                      Center(
                        child: RaisedButton(
                          color: primary,
                          child: Text(
                            'Seleccionar Avatar', 
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                          ),
                          onPressed: () {
                            showAvatarSelectorDialog(context);
                          },
                        ),
                      ),

                      SizedBox(height: 20),

                      DropdownButton(
                        dropdownColor: accent,
                        value: _selectedCity,
                        hint: Text("Seleccionar ciudad", style: TextStyle(color: Colors.white, fontSize: 16)),
                        items: _cities.map((city) {
                          return DropdownMenuItem(
                            value: city,
                            child: Text(city, style: TextStyle(fontSize: 16),)
                          );
                        }).toList(), 
                        onChanged: (newCity) {
                          setState(() {
                            _selectedCity = newCity;
                            registerBloc.changeCity(newCity);
                          });
                        }
                      ),

                      SizedBox(height: 25),
                      Center(child: _registerButton()),

                      SizedBox(height: 50),
                      Center(child: changeToLoginButton()),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          )
        ),

        StreamBuilder(
          initialData: false,
          stream: registerBloc.isLoadingStream,
          builder: (context, snapshot) {
            return snapshot.data
                  ? Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.2),
                        height: double.infinity,
                        width: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator()
                        ),
                      )
                    )
                  : Container();
          },
        )
      ],
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
                        
                        Flushbar(
                          message:  "Usuario creado correctamente",
                          duration:  Duration(seconds: 4),
                          backgroundColor: accent,       
                        )..show(context);

                        await _login(context);
                        authBloc.changeAuthOption(AuthOption.LOGIN);

                        registerBloc.reInitValue();
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

  Future<void> _login(context)async {
    try {
      LoginBloc loginBloc = LoginBloc();
      loginBloc.changeUsername(registerBloc.nickname);
      loginBloc.changePassword(registerBloc.password);

      showLoading(context);
      final User response = await loginBloc.checkUserLogin();
      Navigator.pop(context);

      if (response != null) {
        _verifyIsValidated(context, response);
      } else {
        _showIncorrectUserOrPwdDialog(context);
      }
    } catch (e) {
      Navigator.pop(context);
      _showIncorrectUserOrPwdDialog(context);
    }
  }

  void _showIncorrectUserOrPwdDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Text('Usuario o contraseña incorrecta'),
        );
      }
    );
  }

  void _verifyIsValidated(context, User mUser) async {
    UserPreferences prefs = UserPreferences();
    
    if (mUser.isValidated) {
      prefs.updateCompleteUser(mUser);
      
      UserRankingBloc userRankingBloc = UserRankingBloc();
      await userRankingBloc.createOrUpdateUserRanking();

      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (_) => PortalHomePage()), 
        (route) => false
      );
      
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => VerifyPhone(mUser)));
    }
  }

  void resetRegisterValues() {
    registerBloc.changeIsLoading(false);
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