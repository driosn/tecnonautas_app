import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecnonautas_app/core/bloc/active_trivia/active_trivia_bloc.dart';
import 'package:tecnonautas_app/core/bloc/local_trivias/local_trivias_bloc.dart';
import 'package:tecnonautas_app/core/bloc/search_trivia/search_trivia_bloc.dart';
import 'package:tecnonautas_app/core/models/db_local_trivia.dart';
import 'package:tecnonautas_app/core/models/trivia.dart';
import 'package:tecnonautas_app/src/pages/home/widgets/active_trivia_card.dart';
import 'package:tecnonautas_app/src/pages/home/widgets/trivia_card_item.dart';
import 'package:tecnonautas_app/src/providers/portal_home_model.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';
import 'package:tecnonautas_app/src/utils/db_provider.dart';
import 'package:tecnonautas_app/src/widgets/appbar/tecnonautas_appbar.dart';
import 'package:tecnonautas_app/src/widgets/circle_icon_button.dart';
import 'package:tecnonautas_app/src/widgets/custom_search_input.dart';
import 'package:tecnonautas_app/src/widgets/transparent_container.dart';

class TriviasPage extends StatefulWidget {

  @override
  _TriviasPageState createState() => _TriviasPageState();
}

class _TriviasPageState extends State<TriviasPage> {
  
  LocalTriviasBloc localTriviasBloc;

  @override
  void initState() {

    localTriviasBloc = LocalTriviasBloc();
    localTriviasBloc.reloadTrivias();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final portalHomeModel = Provider.of<PortalHomeModel>(context, listen: false);
      portalHomeModel.isTriviasPage = true;
    });

    super.initState();
    searchTriviaBloc.changeFilterType(FilterType.NONE);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _BackgroundContainer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TecnonautasAppbar(),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    _ActiveTrivia(),
                    _SearchTriviaSection(),
                    
                    StreamBuilder<FilterType> (
                      initialData: FilterType.NONE,
                      stream: searchTriviaBloc.filterTypeStream,
                      builder: (context, snapshot) {
                        FilterType mFilterType = snapshot.data;

                        return StreamBuilder(
                          stream: searchTriviaBloc.searchTriviaStream,
                          initialData: "",
                          builder: (context, snapshot) {
                            String searchResult = snapshot.data;
      
                            if (searchResult.isEmpty) {
                              return StreamBuilder(
                                stream: localTriviasBloc.localTriviasStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<DBLocalTrivia> triviasResult = snapshot.data;
                                    List<String> categoryList = List<String>();
            
                                    if (mFilterType == FilterType.PLAYED) {
                                      triviasResult.removeWhere((element) => element.played == false);
                                    }
                                    if (mFilterType == FilterType.FAVORITE) {
                                      triviasResult.removeWhere((element) => element.favorite == false);
                                    }
      
                                    triviasResult.forEach((element) {
                                      if (!categoryList.contains(element.category)) categoryList.add(element.category);
                                    });
            
                                    Map<String, List<DBLocalTrivia>> triviasByCategory = Map<String, List<DBLocalTrivia>>();
                                    
                                    categoryList.forEach((category) {
                                      triviasByCategory.putIfAbsent(category, () => List<DBLocalTrivia>());
                                      triviasResult.forEach((trivia) {
                                        if (trivia.category == category) {
                                          List<DBLocalTrivia> currentList = triviasByCategory[category];
                                          currentList.add(trivia);
                                          triviasByCategory[category] = currentList;
                                        }
                                      });
                                    });
                                    
                                    List<Widget> triviaListSectionList = List<Widget>();
                                    
                                    triviasByCategory.forEach((key, value) {
                                      triviaListSectionList.add(
                                        _TriviaListSection(
                                          mIcon: Icons.add,
                                          mCategoryName: key,
                                          mTriviaItemList: value.map(
                                            (dbTrivia) => TriviaItem(
                                              mTriviaId: dbTrivia.id, 
                                              questionsNumber: dbTrivia.questionsQuantity, 
                                              isCompleted: dbTrivia.played, 
                                              isFavorite: dbTrivia.favorite, 
                                              triviaTitle: dbTrivia.name
                                            )).toList(),
                                        )
                                      );
                                    });
            
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: triviaListSectionList,
                                    );
                                  }
            
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );
                            } else {
                              // Is not empty
                              return FutureBuilder(
                                future: DBProvider.db.readLocalTrivias(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<DBLocalTrivia> triviasResult = snapshot.data;
                                    triviasResult.removeWhere((element) => !(element.name.toUpperCase()).contains(searchResult.toUpperCase()));
                                    List<String> categoryList = List<String>();
            
                                    if (mFilterType == FilterType.PLAYED) {
                                      triviasResult.removeWhere((element) => element.played == false);
                                    }
                                    if (mFilterType == FilterType.FAVORITE) {
                                      triviasResult.removeWhere((element) => element.favorite == false);
                                    }

                                    triviasResult.forEach((element) {
                                      if (!categoryList.contains(element.category)) categoryList.add(element.category);
                                    });
            
                                    Map<String, List<DBLocalTrivia>> triviasByCategory = Map<String, List<DBLocalTrivia>>();
                                    
                                    categoryList.forEach((category) {
                                      triviasByCategory.putIfAbsent(category, () => List<DBLocalTrivia>());
                                      triviasResult.forEach((trivia) {
                                        if (trivia.category == category) {
                                          List<DBLocalTrivia> currentList = triviasByCategory[category];
                                          currentList.add(trivia);
                                          triviasByCategory[category] = currentList;
                                        }
                                      });
                                    });
                                    
                                    List<Widget> triviaListSectionList = List<Widget>();
      
                                    triviasByCategory.forEach((key, value) {
                                      triviaListSectionList.add(
                                        _TriviaListSection(
                                          mIcon: Icons.add,
                                          mCategoryName: key,
                                          mTriviaItemList: value.map(
                                            (dbTrivia) => TriviaItem(
                                              mTriviaId: dbTrivia.id, 
                                              questionsNumber: dbTrivia.questionsQuantity, 
                                              isCompleted: dbTrivia.played, 
                                              isFavorite: dbTrivia.favorite, 
                                              triviaTitle: dbTrivia.name
                                            )).toList(),
                                        )
                                      );
                                    });



                                    return triviaListSectionList.isNotEmpty
                                      ? Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: triviaListSectionList,
                                        )
                                      : Container(
                                          margin: EdgeInsets.only(
                                            top: 10.0,
                                            bottom: 32.0,
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'No existen trivias que coincidan con la busqueda',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16
                                              ),
                                            ),
                                          ),
                                        );
                                  }
            
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ); 
                            }
                          },
                        );

                      },
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
              // RoundedButton(mHeight: 30, mWidth: 80, mText: Text('Ver Todo'), mRadius: 15)
            ],
          ),
          Container(
            height: 160,
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

class _SearchTriviaSection extends StatefulWidget {

  _SearchTriviaSection();

  @override
  __SearchTriviaSectionState createState() => __SearchTriviaSectionState();
}

class __SearchTriviaSectionState extends State<_SearchTriviaSection> {
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final sizedBoxWidth = (size.width / 2) - 8;

    FilterType mFilterType = searchTriviaBloc.filterType;

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
                  CircleIconButton(
                    mSize: 40, 
                    mIcon: Icons.check,
                    mColor: mFilterType == FilterType.PLAYED ? accent : darkGrey,
                    mOnPressed: () {
                      setState(() {
                        if (mFilterType == FilterType.PLAYED) {
                          searchTriviaBloc.changeFilterType(FilterType.NONE);
                        } else {
                          searchTriviaBloc.changeFilterType(FilterType.PLAYED);
                        }
                      });
                    }
                  ),
                  SizedBox(width: 10),
                  CircleIconButton(
                    mSize: 40, 
                    mIcon: Icons.favorite,
                    mColor: mFilterType == FilterType.FAVORITE ? accent : darkGrey,
                    mOnPressed: () {
                      print("Favorite");
                      setState(() {
                        if (mFilterType == FilterType.FAVORITE) {
                          searchTriviaBloc.changeFilterType(FilterType.NONE);
                        } else {
                          searchTriviaBloc.changeFilterType(FilterType.FAVORITE);
                        }
                      });
                    }
                  ),
                ],
              ),
              SizedBox(height: 15),
              CustomSearchInput(
                mWidth: size.width - 24, 
                mOnChanged: (value) {
                  searchTriviaBloc.changeSearchTrivia(value);
              })
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
 
              StreamBuilder<QuerySnapshot>(
                stream: activeTriviaBloc.activeTriviaStream,
                builder: (context, snapshot) {

                  if (snapshot.hasData && snapshot.data.documents.length > 0) {
                    List<Widget> childrens = List<Widget>();
                    snapshot.data.documents.forEach((element) {
                      childrens.add(
                        ActiveTriviaCard(mTrivia: Trivia.fromSnapshot(element))
                      );
                      childrens.add(SizedBox(height: 15));
                    });
                            
                    return Container(
                      child: Column(
                        children: childrens
                      ),
                    );
                  }
                  
                  return Text(
                    'Ninguna trivia activa',
                    style: TextStyle(color: Colors.white)
                  );
                },
              )
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