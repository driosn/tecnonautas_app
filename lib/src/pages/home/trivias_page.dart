import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecnonautas_app/src/pages/home/widgets/active_trivia_card.dart';
import 'package:tecnonautas_app/src/pages/home/widgets/trivia_card_item.dart';
import 'package:tecnonautas_app/src/providers/portal_home_model.dart';
import 'package:tecnonautas_app/src/widgets/circle_icon_button.dart';
import 'package:tecnonautas_app/src/widgets/custom_search_input.dart';
import 'package:tecnonautas_app/src/widgets/rounded_button.dart';
import 'package:tecnonautas_app/src/widgets/tecnonautas_header.dart';
import 'package:tecnonautas_app/src/widgets/transparent_container.dart';

class TriviasPage extends StatefulWidget {

  @override
  _TriviasPageState createState() => _TriviasPageState();
}

class _TriviasPageState extends State<TriviasPage> {
  final List<TriviaItem> mathTriviaItemList =  [
    new TriviaItem(triviaTitle: 'Paralelo y perpendicular', isCompleted: true, isFavorite: true, questionsNumber: 7),
    new TriviaItem(triviaTitle: 'Secuencias', isCompleted: false, isFavorite: false, questionsNumber: 5),
    new TriviaItem(triviaTitle: 'Raices y potencias', isCompleted: true, isFavorite: true, questionsNumber: 3),
    new TriviaItem(triviaTitle: 'Paralelo y perpendicular', isCompleted: false, isFavorite: true, questionsNumber: 7),
    new TriviaItem(triviaTitle: 'Secuencias', isCompleted: false, isFavorite: true, questionsNumber: 5),
    new TriviaItem(triviaTitle: 'Raices y potencias', isCompleted: true, isFavorite: false, questionsNumber: 3),
  ];

  final List<TriviaItem> natTriviaItemList =  [
    new TriviaItem(triviaTitle: 'Las Plantas', isCompleted: false, isFavorite: true, questionsNumber: 7),
    new TriviaItem(triviaTitle: 'El cuerpo Humano', isCompleted: true, isFavorite: false, questionsNumber: 5),
    new TriviaItem(triviaTitle: 'Animales Mamíferos', isCompleted: false, isFavorite: true, questionsNumber: 3),
    new TriviaItem(triviaTitle: 'Las Plantas', isCompleted: true, isFavorite: false, questionsNumber: 7),
    new TriviaItem(triviaTitle: 'El cuerpo Humano', isCompleted: false, isFavorite: true, questionsNumber: 5),
    new TriviaItem(triviaTitle: 'Animales Mamíferos', isCompleted: true, isFavorite: false, questionsNumber: 3),
  ];

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final portalHomeModel = Provider.of<PortalHomeModel>(context, listen: false);
      portalHomeModel.isTriviasPage = true;
    });

    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  
    print('disposeeeee');
    // final portalHomeModel = Provider.of<PortalHomeModel>(context, listen: false);
    // portalHomeModel.isTriviasPage = false;

  }

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
                    _SearchTriviaSection(),
                    _TriviaListSection(
                      mIcon: Icons.add,
                      mCategoryName: 'Matematicas',
                      mTriviaItemList: mathTriviaItemList,
                    ),
                    _TriviaListSection(
                      mIcon: Icons.library_books,
                      mCategoryName: 'Ciencias Naturales',
                      mTriviaItemList: natTriviaItemList,
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

class _TriviaListSection extends StatelessWidget {

  final IconData mIcon;
  final String mCategoryName;
  List<TriviaItem> mTriviaItemList;

  _TriviaListSection({
    @required this.mIcon,
    @required this.mCategoryName,
    @required this.mTriviaItemList
  });

  @override
  Widget build(BuildContext context) {
    return TransparentContainer(
      mWidth: double.infinity,
      mMargin: EdgeInsets.symmetric(vertical: 12),
      mPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      mChild: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              subtitleLabel(mIcon, mCategoryName),
              Spacer(),
              RoundedButton(mHeight: 30, mWidth: 80, mText: 'Ver Todo', mRadius: 15)
            ],
          ),
          Container(
            height: 140,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: ListView.separated(
              itemCount: mTriviaItemList.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 20),
              itemBuilder: (context, index) => TriviaCardItem(mTriviaItemList[index]),
            ),
          )
        ],
      ),
    );
  }

  Widget subtitleLabel(IconData mIcon, String mText) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(mIcon, color: Colors.white),
        Text(mText, style: TextStyle(color: Colors.white))
      ],
    );
  }

}

class _SearchTriviaSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final sizedBoxWidth = (size.width / 2) - 8;

    return TransparentContainer(
      mWidth: double.infinity,
      mMargin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      mPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      mChild: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CircleIconButton(mSize: 40, mIcon: Icons.check, mOnPressed: () {}),
                  SizedBox(width: 10),
                  CircleIconButton(mSize: 40, mIcon: Icons.favorite, mOnPressed: () {}),
                ],
              ),
              SizedBox(height: 15),
              CustomSearchInput(mWidth: size.width - 24, mOnChanged: (value) {})
            ],
          ),
          Positioned.fill(
            top: 5,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Trivias', 
                style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
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