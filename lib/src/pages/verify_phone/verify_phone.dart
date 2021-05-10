import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/user_ranking/user_ranking_bloc.dart';
import 'package:tecnonautas_app/core/models/user.dart';
import 'package:tecnonautas_app/src/pages/home/trivias_page.dart';
import 'package:tecnonautas_app/src/pages/portal_home/portal_home_page.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';
import 'package:tecnonautas_app/src/widgets/main_yellow_button.dart';

class VerifyPhone extends StatelessWidget {
  
  User mUser;
  
  VerifyPhone(this.mUser);

  TextEditingController _codeController = TextEditingController();
  String smsCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color> [
              accent,
              primary
            ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity),
            Text(
              "Tu cuenta aún no fué verificada.\nEnviaremos un SMS con el código de verificacíón.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 48),
            _sendCodeButton(context)
          ],
        ),
      ),
    );
  }

  Widget _sendCodeButton(context) {
    return MainYellowButton(
      mText: 'Enviar codigo',
      mOnPressed: () async {
        try {
          FirebaseAuth _auth = FirebaseAuth.instance;
  
          await _auth.verifyPhoneNumber(
            phoneNumber: "+591" + this.mUser.phone, 
            timeout: Duration(seconds: 120), 
            verificationCompleted: (authCredential) {
              print("Verification Completed");
              print(authCredential);
            }, 
            verificationFailed: (authException) {
              print("Verification Failed");
              print(authException);
            }, 
            codeSent: (String verificationid, [int forceResendingToken]) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  title: Text("Ingresa codigo de verificación"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        style: TextStyle(color: accent),
                        controller: _codeController,
                        keyboardType: TextInputType.numberWithOptions(
                          signed: false, 
                          decimal: false
                        ),
                      )
                    ],
                  ),
  
                  actions: [
                    MainYellowButton(
                      mText: 'Verificar',
                      mOnPressed: () {
                        FirebaseAuth auth = FirebaseAuth.instance;
  
                        smsCode = _codeController.text.trim();
  
  
                        final _credential = PhoneAuthProvider.getCredential(
                          verificationId: verificationid, 
                          smsCode: smsCode
                        );
  
                        print("Credential");
                        print(_credential.toString());
                        print("Fin de credencial");
  
                        auth.signInWithCredential(_credential)
                            .then((AuthResult result) async {
                              
                              await Firestore.instance.collection("user").document(mUser.id).updateData({
                                "isValidated" : true
                              });
  
                              UserPreferences prefs = UserPreferences();
                              prefs.updateCompleteUser(mUser);
  
                              UserRankingBloc userRankingBloc = UserRankingBloc();
                              await userRankingBloc.createOrUpdateUserRanking();
  
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PortalHomePage()
                                ),
                                (route) => false
                              );
                            })
                            .catchError((e) {
                              
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Codigo incorrecto"),
                                  );
                                }
                              );
                            });
                      }, 
                    )
                  ],
                )
              );
            }, 
            codeAutoRetrievalTimeout: null
          );
        } catch (error) {
          print(error.toString());
        }
      },
    );
  }
}