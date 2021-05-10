import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/widgets/custom_plain_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPlainAppbar(mTitle: 'Contáctanos'),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 24
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 18),
                text: "Puedes escribirnos a ",
                recognizer: new TapGestureRecognizer()..onTap = () => _openGmail(),
                children: [
                  TextSpan(
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                    text: "info@tecnonautas.energea.com.bo",
                    recognizer: new TapGestureRecognizer()..onTap = () => _openGmail()
                  ),
                  TextSpan(
                    text: " , y visitarnos en "
                  ),
                  TextSpan(
                    style: TextStyle(color: Colors.blue, fontSize: 18, decoration: TextDecoration.underline),
                    text: "www.facebook.com/energeabolivia",
                    recognizer: TapGestureRecognizer()..onTap = () => _openFacebook()
                  )
                ]
              ),
            )
          ],
        ),
      )
    );
  }

  void _openGmail() {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'info@tecnonautas.energea.com.bo',
    );

    launch(_emailLaunchUri.toString());
  }

  void _openFacebook() async {
    const url = 'https://www.facebook.com/energeabolivia';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}