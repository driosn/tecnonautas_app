import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/auth/auth_bloc.dart';
import 'package:tecnonautas_app/src/pages/auth/widgets/login.dart';
import 'package:tecnonautas_app/src/pages/auth/widgets/register.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class AuthPage extends StatelessWidget {
  
  AuthBloc authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color> [
              accent,
              primary,
            ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: StreamBuilder<AuthOption>(
                initialData: AuthOption.LOGIN,
                stream: authBloc.authOptionStream,
                builder: (context, snapshot) => snapshot.data == AuthOption.LOGIN 
                                                ? Login()
                                                : Register()
              ),
            ),
          ],
        ),
      ),
    );
  }
}