import 'dart:ui';
import 'package:chuyi/model/api_data.dart';
import 'package:chuyi/util/api.dart';
import 'package:chuyi/view/home/classify_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chuyi/view/home/meals_list_view.dart';
import 'package:chuyi/view/home/new_recipes_view.dart';
import 'package:chuyi/view/home/hot_recipes_view.dart';
import 'package:chuyi/view/home/explore_list_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key key, this.animationController}) : super(key:key);

  final AnimationController animationController;
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

final API _api = API();

class _HomePageScreenState extends State<HomePageScreen> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  List<Widget> listViews = <Widget>[];
  NowDate todayDate = NowDate();
  String _userId;
  UserInfo userInfo;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)
      )
    );

    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

    _getUserId();

    super.initState();
  }

  /// 获取用户信息
  _getUserId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = (prefs.getString('userId') ?? null);
    });
    /// 获取用户信息
    if (_userId != null) {
      _api.getUserInfo(_userId, (value) async{
        await value;
        setState(() {
          userInfo = value;
        });
      });
    }
  }
  
  void addAllListData() {
    const int count = 9;
    listViews.add(
      TitleView(
        titleTxt: '今日推荐',
        subTxt: '更多',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * 0, 1.0,
              curve: Curves.fastOutSlowIn
            )
          )
        ),
        animationController: widget.animationController,
      )
    );
    listViews.add(
      /// 今日推荐Widget
      MealsListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * 1, 1.0,
              curve: Curves.fastOutSlowIn
            )
          )
        ),
        mainScreenAnimationController: widget.animationController,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: '新菜谱',
        subTxt: '全部',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController, 
            curve: Interval(
              (1 / count) * 2, 1.0, 
              curve: Curves.fastOutSlowIn
            )
          )
        ),
        animationController: widget.animationController,
      )
    );
    listViews.add(
      NewRecipesView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * 3, 1.0,
              curve: Curves.fastOutSlowIn
            )
          )
        ),
        animationController: widget.animationController,
      )
    );

    listViews.add(
      TitleView(
        titleTxt: '大家都在做',
        subTxt: '',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController, 
            curve: Interval(
              (1 / count) * 4, 1.0, 
              curve: Curves.fastOutSlowIn
            )
          )
        ),
        animationController: widget.animationController,
      )
    );
    listViews.add(
      HotRecipesView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * 5, 1.0,
              curve: Curves.fastOutSlowIn
            )
          )
        ),
        animationController: widget.animationController,
      )
    );

    listViews.add(
      TitleView(
        titleTxt: '菜谱速览',
        subTxt: '全部分类',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController, 
            curve: Interval(
              (1 / count) * 6, 1.0, 
              curve: Curves.fastOutSlowIn
            )
          )
        ),
        animationController: widget.animationController,
      )
    );
    listViews.add(
      ClassifyHomeView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * 7, 1.0,
              curve: Curves.fastOutSlowIn
            )
          )
        ),
        animationController: widget.animationController,
      )
    );

    listViews.add(
      TitleView(
        titleTxt: '美食灵感',
        subTxt: '',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController, 
            curve: Interval(
              (1 / count) * 8, 1.0, 
              curve: Curves.fastOutSlowIn
            )
          )
        ),
        animationController: widget.animationController,
      )
    );
    listViews.add(
      ExploreRecipesView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * 9, 1.0,
              curve: Curves.fastOutSlowIn
            )
          )
        ),
        animationController: widget.animationController,
      )
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            getMainList(),
            getAppBar(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainList() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top + 24,
              bottom: 62 + MediaQuery.of(context).padding.bottom
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listViews[index];
            }
          );
        }
      }
    );
  }

  Widget getAppBar() {
    return Column(
      children:<Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                  0.0, 30 * (1.0 - topBarAnimation.value), 0.0
                ),
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: <Widget>[
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
                          child: Padding(
                            padding: EdgeInsets.only(top:MediaQuery.of(context).padding.top,left: 16.0,right: 16.0,bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${new DateTime.now().month.toString()}月${new DateTime.now().day.toString()}日 ${todayDate.todayWeek()}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: 0.2,
                                          color: Colors.grey
                                        ),
                                      ),
                                      Text(
                                        "${todayDate.hours()}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17
                                        ),
                                      )
                                    ],
                                  )
                                ),
                                GestureDetector(
                                  onTap:(){},
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    child: userInfo.avatar == null ? Image.asset('assets/images/userImage.png') : 
                                    FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/userImage.png', 
                                      image: '${userInfo.avatar}'
                                    )
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  
                ),
              ),
            );
          },
        ),
      ]
    );
  }
}

class TitleView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final AnimationController animationController;
  final Animation animation;

  const TitleView(
      {Key key,
      this.titleTxt: "",
      this.subTxt: "",
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        titleTxt,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              subTxt,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Color(0xFFFB7101)
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 26,
                              child: Icon(
                                subTxt != '' ? Icons.arrow_forward : null,
                                size: 18,
                                color: Color(0xFFFB7101),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
