import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/widgets/custom_plain_appbar.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPlainAppbar(mTitle: '¿Quiénes somos?'),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 24
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           _content("Tecnonautas es una institución boliviana que se dedica a estimular las mentes de los estudiantes, buscando potenciar las habilidades del siglo XXI, necesarias para enfrentar el mundo actual y el futuro.  Es parte de EnerGea, emprendimiento dedicado a coadyuvar al desarrollo sostenible mediante servicios de eficiencia energética, reciclaje y educación.\n\nBuscamos que  nuestros niñas, niños y jóvenes exploten su potencial, dándoles herramientas multidisciplinarias y habilidades imprescindibles para el futuro como la resolución de problemas, creatividad y autoaprendizaje. Tenemos programas educativos desde los 4 años en adelante!\nSomos los primeros en implementar la educación STEAM en Bolivia, con programas desde el año 2016, y proyectos de programas sin costo como Chiquintervenciones el 2019, y Club STEAM desde el 2020.\n\n¿Quieres saber más? Visítanos en www.tecnonautasbolivia.com")
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