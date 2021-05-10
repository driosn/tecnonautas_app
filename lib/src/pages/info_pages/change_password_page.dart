import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:password/password.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/utils/show_loading.dart';
import 'package:tecnonautas_app/src/utils/user_preferences.dart';
import 'package:tecnonautas_app/src/widgets/custom_plain_appbar.dart';
import 'package:tecnonautas_app/src/widgets/main_yellow_button.dart';

class ChangePasswordPage extends StatelessWidget {
  
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPlainAppbar(mTitle: 'Cambiar contraseña'),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.black54),
                controller: _currentPasswordController,
                decoration: InputDecoration(
                  labelText: "Contraseña actual",
                ),
              ),
              SizedBox(height: 24),
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.black54),
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: "Nueva contraseña"
                ),
              ),
              SizedBox(height: 24),
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.black54),
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: "Confirmación nuevo password"
                ),
              ),
              SizedBox(height: 48),
              MainYellowButton(
                mOnPressed: () => submitButton(context), 
                mText: "Cambiar contraseña"
              )
            ],
          ),
        )
      ),
    );
  }

  void submitButton(BuildContext context) async {
    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;
  
    if (newPassword == confirmPassword && newPassword.length >= 8 && newPassword.length >= 8) {
      try {
        showLoading(context);
        UserPreferences prefs = UserPreferences();
        QuerySnapshot response = await Firestore.instance
                                      .collection("user")
                                      .where("id", isEqualTo: prefs.id)
                                      .getDocuments();
  
        if (response.documents.length > 0) {
          DocumentSnapshot document = response.documents.first;
          // if (Password.verify(currentPassword, document.data["password"])) {
          // if (Password.verify(currentPassword, document.data["password"])) {
          if (encodePassword(currentPassword) == document.data["password"]) {
              await response.documents.first.reference.updateData({
                // "password" : Password.hash(newPassword, new PBKDF2())
                "password" : encodePassword(newPassword)
              });
              Navigator.pop(context);
              Flushbar(
                message:  "La contraseña se cambió correctamente",
                duration:  Duration(seconds: 4),
                backgroundColor: accent,       
              )..show(context);
            }

          } else {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(
                    "La contraseña actual no es correcta", 
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54
                    )
                  ),
                  actions: [
                    FlatButton(
                      child: Text("Aceptar"),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                );
              }
            );      
          }
          return null;
        // }
        // return null;
      } catch (e) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                "La contraseña actual no es correcta", 
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54
                )
              ),
              actions: [
                FlatButton(
                  child: Text("Aceptar"),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            );
          }
        );      
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              "La nueva contraseña debe coincidir con la confirmación y debe ser de mínimo 8 caracteres.", 
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black54
              )
            ),
            actions: [
              FlatButton(
                child: Text("Aceptar"),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        }
      );
    }
  }

  String encodePassword(String currentPassword) {
    String encodedPassword = "";
    for(int i = 0; i < currentPassword.length; i++) {
      encodedPassword += String.fromCharCode(currentPassword.codeUnitAt(i) + 1);
    }
    return encodedPassword;
  }
}