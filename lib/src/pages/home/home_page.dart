import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/pages/home/widgets/active_trivia_card.dart';
import 'package:tecnonautas_app/src/widgets/subtitie.dart';
import 'package:tecnonautas_app/src/widgets/tecnonautas_header.dart';
import 'package:tecnonautas_app/src/widgets/transparent_container.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _BackgroundContainer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TecnonautasHeader(),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    _ActiveTrivia(),
                    TransparentContainer(
                      mWidth: double.infinity,
                      mHeight: 100,
                      mMargin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    ),
                    TransparentContainer(
                      mWidth: double.infinity,
                      mHeight: 110,
                      mMargin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    ),
                    TransparentContainer(
                      mWidth: double.infinity,
                      mHeight: 110,
                      mMargin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

class _ActiveTrivia extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        TransparentContainer(
          mPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          mMargin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          mWidth: double.infinity,
          mChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Activa', style: Theme.of(context).textTheme.subtitle),
              SizedBox(height: 10),
              ActiveTriviaCard()
            ],
          ),
        ),
      ],
    );
  }
}

class _BackgroundContainer extends StatelessWidget {
  
  final Widget child;
  final EdgeInsetsGeometry padding;

  _BackgroundContainer({
    this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: padding,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color> [
            Theme.of(context).accentColor,
            Theme.of(context).primaryColor,
          ]
        )
      ),
    );
  }
}