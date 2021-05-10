import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/auth/auth_bloc.dart';
import 'package:tecnonautas_app/core/bloc/login/login_bloc.dart';
import 'package:tecnonautas_app/core/bloc/user_ranking/user_ranking_bloc.dart';
import 'package:tecnonautas_app/core/models/user.dart';
import 'package:tecnonautas_app/src/pages/home/trivias_page.dart';
import 'package:tecnonautas_app/src/pages/portal_home/portal_home_page.dart';
import 'package:tecnonautas_app/src/pages/verify_phone/verify_phone.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/utils/show_loading.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';
import 'package:tecnonautas_app/src/widgets/main_yellow_button.dart';

class Login extends StatelessWidget {
  
  LoginBloc loginBloc = LoginBloc();
  
  UserPreferences prefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 120),
              
              Container(
                height: 120,
                child: Image.asset('assets/images/logo_tecnonautas_mobile.png'),
              ),

              SizedBox(height: 30),

              TextField(
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white, fontFamily: 'Gibson', fontSize: 16),
                  labelText: 'Nombre de Usuario',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: primary
                    )
                  )
                ),
                style: TextStyle(color: Colors.white),
                onChanged: loginBloc.changeUsername,
              ),
              TextField(
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white, fontFamily: 'Gibson', fontSize: 16),
                  labelText: 'Contraseña',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: primary
                    ),
                  ),
                ),
                obscureText: true,
                style: TextStyle(color: Colors.white),
                onChanged: loginBloc.changePassword
              ),

              SizedBox(height: 50),
              _loginButton(context),

              SizedBox(height: 80),
              changeToRegisterButton(),
              SizedBox(height: 20)

            ],
          ),
        ),
          ),
      ), 
    );
  }

  Widget changeToRegisterButton() {
    return FlatButton(
      child: Text(
        '¿No tienes Cuenta?\nCrear Cuenta',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      onPressed: () => authBloc.changeAuthOption(AuthOption.REGISTER)
    );
  }

  Widget _loginButton(context) {
    return MainYellowButton(
      mText: 'INGRESAR',
      mOnPressed: () async {
        try {
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
      });
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
    if (mUser.isValidated) {
      prefs.updateCompleteUser(mUser);
      
      UserRankingBloc userRankingBloc = UserRankingBloc();
      await userRankingBloc.createOrUpdateUserRanking();

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => PortalHomePage()), (route) => false);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => VerifyPhone(mUser)));
    }
  }
}