import 'package:chuyi/model/api_data.dart';
import 'package:chuyi/model/router.dart';
import 'package:chuyi/util/api.dart';
import 'package:chuyi/widget/reting_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui show window;
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPage extends StatefulWidget {
  final cookId;

  DetailPage(this.cookId,{Key key}): super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState(cookId);
}

final API _api = API();

class _DetailPageState extends State<DetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final cookId;
  _DetailPageState(this.cookId);
  DetailData _getDetailData;
  Start _getMarkStart;
  String startWeight;
  String _userId;
  DetailUser _cookUserStatus;
  ScrollController scrollController = ScrollController();
  double navAlpha = 0;
  MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
  
  @override
  void initState(){
    /// 获取详情
    _api.getDetail(cookId, (value) async{
      await value;
      _getDetailData = value;
      setState(() {
        this._getDetailData = value;
      });
    });
    /// 获取评分
    _api.getMarkStart(cookId, (value) async{
      await value;
      _getMarkStart = value['start'];
      startWeight = value['total'];
      setState(() {
        this._getMarkStart = value['start'];
        this.startWeight = value['total'];
      });
    });
    /// 获取用户信息
    _getUserId();

    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }
      } else if (offset < 160) {
        setState(() {
          navAlpha = 1 - (160 - offset) / 160;
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
      }
    });
    super.initState();
  }

  _getUserId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = (prefs.getString('userId') ?? null);
      /// 获取用户是否点赞收藏
      _userId != null ?? _api.getIsLike(_userId, cookId, (value) async{
        await value;
        _cookUserStatus = value;
      });
    });
  }


  @override
  void dispose(){
    scrollController.dispose();
    super.dispose();
  }

  back(){
    Navigator.pop(context);
  }
  
  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).textTheme.bodyText1.color;

    if ( _getDetailData == null) {
      return Scaffold(
        body: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      body: AnnotatedRegion(
        // 设置状态栏样式
        value: navAlpha > 0.5 ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: EdgeInsets.only(top: 0),
                    children: <Widget>[
                      buildBackground(_getDetailData.image),
                      storyTextScene(_getDetailData,textColor),
                      ingrView(),
                      recipeStepScene(),
                      tipsScene(),
                      ratingScene(),
                      //markScene(),
                      SizedBox(height: mediaQuery.padding.bottom+20)
                    ],
                  )
                )
              ],
            ),
            buildNavigationBar(),
            bottomBar(),
          ],
        ),
      ),
    );
  }

  Widget buildNavigationBar() {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;

    return Stack(
      children: <Widget>[
        Container(
          width: 42.0,
          height: mediaQuery.padding.top + kToolbarHeight,
          padding: EdgeInsets.fromLTRB(0, mediaQuery.padding.top - 14, 0, 0),
          child: GestureDetector(
            onTap: back,
            child: Icon(CupertinoIcons.left_chevron, color: Colors.white, size: 30),
          ),
        ),
        Opacity(
          opacity: navAlpha,
          child: CupertinoNavigationBar(
            padding: EdgeInsetsDirectional.only(start: 5.0,end: 5.0),
            leading: GestureDetector(
              onTap: () {
                back();
              },
              child: Icon(CupertinoIcons.left_chevron),
            ),
            middle: Text(
              '${_getDetailData.title}',
              softWrap: true,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(color: darkModeOn ? Colors.white : Colors.black),
            ),
            backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
            trailing: GestureDetector(
              onTap: () {
                Share.share('我在「厨易」App发现${_getDetailData.title}的做法');
              },
              child: Icon(
                CupertinoIcons.ellipsis
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildBackground(String image) {
    return Container(
      height: 228 + mediaQuery.padding.top,
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            '$image?x-oss-process=image/resize,m_fill,h_260' ?? 'assets/images/placeholder.jpg'
          ),
          fit: BoxFit.cover
        )
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 208 + mediaQuery.padding.top),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft:Radius.circular(18.0),topRight: Radius.circular(18.0)),
          child: Container(
            color: Theme.of(context).accentColor
          ),
        ),
      )
    );
  }

  Container storyTextScene(DetailData recipes, Color textColor) {
    return Container(
      color: Theme.of(context).accentColor,
      transform: Matrix4.translationValues(0.0, -1.0, 0.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    '${recipes.title}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize:25.0,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).accentColor,
                          image: DecorationImage(
                            image: NetworkImage(
                              '${recipes.avatar}'
                            ),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${recipes.nickname}', style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                          Text('${recipes.creaDate}', style: TextStyle(fontSize: 13, color: Colors.grey.shade600))
                        ],
                      )
                    ],
                  ),
                  
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RatingBar(recipes.score, size: 18.0,),
                  SizedBox(width: 10.0),
                  Icon(Icons.timer, size: 18, color: Color(0xFFFB7101).withAlpha(150)),
                  SizedBox(width: 5.0),
                  Text('${recipes.cookTime}', style: TextStyle(fontSize: 13.0,color: Colors.grey[600])),
                  SizedBox(width: 10.0),
                  Icon(Icons.whatshot, size: 18, color: Color(0xFFFB7101).withAlpha(150)),
                  SizedBox(width: 5.0),
                  Text('难度${recipes.difficult}', style: TextStyle(fontSize: 13.0,color: Colors.grey[600]))
                ],
              ),
            ),
            Divider(height: 1),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
              child: Text(
                '${recipes.story}',
                style: TextStyle(
                  fontSize: 15.0,
                  color: textColor
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ingrView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
      margin: EdgeInsets.only(top: 10.0),
      color: Theme.of(context).accentColor,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '食材准备',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
              // GestureDetector(
              //   onTap: () {},
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: <Widget>[
              //       Icon(Icons.add_shopping_cart, size: 18, color: Color(0xFFFB7101)),
              //       Text('加入采购清单', style: TextStyle(color:Color(0xFFFB7101), fontSize: 15.0))
              //     ],
              //   ),
              // )
            ],
          ),
          SizedBox(height:5),
          ingredientsScene(_getDetailData.ingredients),
        ],
      ),
    );
  }

  GridView ingredientsScene(List ingredients){
    // GridView.count ==> SliverGridDelegateWithFixedCrossAxisCount 的简写
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: ScrollPhysics(), //or: new NeverScrollableScrollPhysics() 禁止滚动
      padding: EdgeInsets.symmetric(vertical: 0),
      childAspectRatio: 6,
      children: List.generate(
        ingredients.length,
        (f) {
          return Row(
            children: <Widget>[
              Text(
                "${ingredients[f].amount}",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
              ),
              SizedBox(width: 8),
              Text(
                "${ingredients[f].description}",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
              )
            ],
          );
        }
      ),
    );
  }

  Widget recipeStepScene() {
    return Container(
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('烹饪步骤',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
              // Container(
              //   color: Theme.of(context).dividerColor.withAlpha(20),
              //   height: 1,
              //   margin: EdgeInsets.only(top: 5),
              //   width: MediaQuery.of(context).size.width / 1.5,
              // )
            ]
          ),
          ..._getDetailData.step.map<Padding>((RecipeIngredient step){
            return stepBuild(step, _getDetailData.step.length);
          })
        ],
      ),
    );
  }

  Padding stepBuild(RecipeIngredient step, int allStep) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${step.amount}/$allStep',
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500,color: Theme.of(context).textTheme.bodyText1.color),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap:() {},
            child: new Container(
              height: 300.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    '${step.img}?x-oss-process=image/resize,m_fill,h_320' ?? '',
                  ),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(12.0)
              )
            ),
          ),
          SizedBox(height: 10),
          Text('${step.txt}', style: TextStyle(fontSize: 15.0,color: Theme.of(context).textTheme.bodyText1.color)),
          SizedBox(height:15)
        ],
      ),
    );
  }

  Widget tipsScene(){
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      color: Theme.of(context).accentColor,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.lightbulb_outline),
              Text('小贴士',style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500))
            ],
          ),
          SizedBox(height: 5.0),
          Text('${_getDetailData.tips}')
        ],
      ),
    );
  }

  Widget ratingScene() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: MediaQuery.of(context).padding.bottom+10),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      color: Theme.of(context).accentColor,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('评分详情',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
              Container(
                color: Theme.of(context).dividerColor.withAlpha(20),
                height: 1,
                margin: EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width / 1.5,
              )
            ]
          ),
          SizedBox(height: 5.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Text(
                      '${startWeight.toString()}',
                      style: TextStyle(fontSize: 45.0)
                    ),
                    RatingBar(4.5,size: 17.0,fontSize: 0.0),
                    Text(
                      '${_getMarkStart.totalNum ?? _getDetailData.score}人评分',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildRatingRow('5', (_getMarkStart.fiveStart/_getMarkStart.totalNum).toDouble(),
                      '${_getMarkStart.fiveStart/_getMarkStart.totalNum*100 == 100 ? 100 : (_getMarkStart.fiveStart/_getMarkStart.totalNum*100).toStringAsFixed(1)}%'),
                    _buildRatingRow('4', (_getMarkStart.fourStart/_getMarkStart.totalNum).toDouble(),
                      '${_getMarkStart.fourStart/_getMarkStart.totalNum*100 == 100 ? 100 : (_getMarkStart.fourStart/_getMarkStart.totalNum*100).toStringAsFixed(1)}%'),
                    _buildRatingRow('3', (_getMarkStart.threeStart/_getMarkStart.totalNum).toDouble(),
                      '${_getMarkStart.threeStart/_getMarkStart.totalNum*100 == 100 ? 100 : (_getMarkStart.threeStart/_getMarkStart.totalNum*100).toStringAsFixed(1)}%'),
                    _buildRatingRow('2', (_getMarkStart.twoStart/_getMarkStart.totalNum).toDouble(), 
                      '${_getMarkStart.twoStart/_getMarkStart.totalNum*100 == 100 ? 100 : (_getMarkStart.twoStart/_getMarkStart.totalNum*100).toStringAsFixed(1)}%'),
                    _buildRatingRow('1', (_getMarkStart.oneStart/_getMarkStart.totalNum).toDouble(),
                      '${_getMarkStart.oneStart/_getMarkStart.totalNum*100 == 100 ? 100 : (_getMarkStart.oneStart/_getMarkStart.totalNum*100).toStringAsFixed(1)}%'),
                  ],
                )
              )
            ],
          ),
          SizedBox(height: 20),
          Divider(height: 0),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:10)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("评分",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    child: Row(
                          children: <Widget>[
                            SizedBox(
                              height: 38,
                              width: 26,
                              child: Icon(
                                Icons.edit,
                                size: 18,
                                color: Color(0xFFFB7101),
                              ),
                            ),
                            Text(
                              '评价这道菜',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Color(0xFFFB7101)
                              ),
                            ),
                          ],
                        ),
                    onTap: (){
                      print("object");
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.star_border, size: 48, color: Colors.grey,),
                  Icon(Icons.star_border, size: 48, color: Colors.grey),
                  Icon(Icons.star_border, size: 48, color: Colors.grey),
                  Icon(Icons.star_border, size: 48, color: Colors.grey),
                  Icon(Icons.star_border, size: 48, color: Colors.grey),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  // 评分详情
  Padding _buildRatingRow(String startNum, double level, String percentage) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3),
      child: Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(startNum,textAlign: TextAlign.right, style: TextStyle(color: Colors.grey, fontSize: 12.0))
        ),
        SizedBox(width: 8.0),
        Expanded(
          flex: 9,
          child: SizedBox(
            height: 7.5,
            child: ClipRRect(
            borderRadius: BorderRadius.circular(9.0),
            child: LinearProgressIndicator(
              value: level,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.yellow.shade800),
              backgroundColor: Colors.grey.shade300,
            ),
          )
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(percentage,textAlign: TextAlign.right,style: TextStyle(color: Colors.grey, fontSize: 12.0))
        )
      ],
    ),
    );
  }

  // bottom bar
  Widget bottomBar() {
    bool isLike = _cookUserStatus == null || _cookUserStatus.isLike == 0 ? false : true;
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      _userId == null ? Navigator.of(context).push(loginRoute()) : print("请求点赞接口");
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.thumb_up, color: isLike ? Color(0xFFFB7101) : Colors.grey),
                        Text('${_getDetailData.like ?? 0}', style: TextStyle(fontSize: 14, color: isLike ? Color(0xFFFB7101) : Colors.grey))
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.favorite_border, color:  Colors.grey),
                        Text('${_getDetailData.collect ?? ''}', style: TextStyle(fontSize: 14, color: Colors.grey))
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.chat_bubble_outline,color: Colors.grey),
                        Text('0', style: TextStyle(fontSize: 14, color: Colors.grey))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        )
      ],
    );
  }

}