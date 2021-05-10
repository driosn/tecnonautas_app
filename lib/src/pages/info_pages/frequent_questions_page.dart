import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/widgets/custom_plain_appbar.dart';

class FrequentQuestionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPlainAppbar(mTitle: 'Preguntas Frecuentes'),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 24
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _subtitle("¿Qué es esto?"),
            SizedBox(height: 8),
            _content("Es la App de Tecnonautas Bolivia, donde podrás aprender, enterarte de novedades en Educación STEM/STEAM, participar de nuestras trivias y competir por distintos premios!"),
            SizedBox(height: 24),
            _subtitle("¿Cómo participar?"),
            SizedBox(height: 8),
            _content("Ingresa a www.tecnonautasbolivia.com para enterarte de los horarios y canales donde tendremos nuestras transmisiones. ¡Durante éstas lanzaremos distintas trivias que debes responder para ganar puntos!"),
            SizedBox(height: 24),
            _subtitle("¿Qué es el ranking?"),
            SizedBox(height: 8),
            _content("El ranking está basado en los puntos que cada usuario obtiene respondiendo las trivias en directo (que son lanzadas durante nuestras transmisiones). ¡Mientras más puntos obtienes en la temporada, subirás en el ranking!"),
            SizedBox(height: 24),
            _subtitle("Para qué sirven las monedas?"),
            SizedBox(height: 8),
            _content("Puedes obtener monedas respondiendo a las trivias offline en el momento que desees. Las monedas sirven para canjearlas, pronto te enterarás por qué puedes canjearlas!")
          ],
        ),
      )
    );
  }

  Widget _subtitle(String mSubtitle) {
    return Text(
      mSubtitle,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: accent,
      ),
    );
  }

  Widget _content(String mContent) {
    return Text(
      mContent,
      style: TextStyle(
        fontSize: 16
      ),
    );
  }
}