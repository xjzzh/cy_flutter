import 'package:chuyi/model/api_data.dart';
import 'package:chuyi/model/router.dart';
import 'package:chuyi/util/api.dart';
import 'package:flutter/material.dart';

final API _api  = API();
class MealsListView extends StatefulWidget {
  const MealsListView({Key key, this.mainScreenAnimationController, this.mainScreenAnimation}) : super(key:key);
  
  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;

  @override
  _MealsListViewState createState() => _MealsListViewState();
}

class _MealsListViewState extends State<MealsListView> with TickerProviderStateMixin {
  AnimationController animationController;
  List<MealsListData> mealsListData = MealsListData.tabIconsList;
  List<Subject> breakfast = List();
  
  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000), vsync: this
    );
    
    _api.getTodayRepice((item) {
      setState(() {
        breakfast = item['breakfast'];
      });
    });
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Transform(
            transform: Matrix4.translationValues(
              0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0
            ),
            child: Container(
              height: 216,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = mealsListData.length > 5 ? 5 : mealsListData.length;
                  final Animation<double> animation = CurvedAnimation(
                    parent: animationController, 
                    curve: Interval(
                      (1 / count) * index, 1.0,
                      curve: Curves.fastOutSlowIn
                    )
                  );
                  animationController.forward();
                  return MealsView(
                    mealsListData: mealsListData[index],
                    netWorkData: breakfast[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
                itemCount: breakfast.length,
              ),
            ),
          ),
        );
      }
    );
  }

}

class MealsView extends StatelessWidget {
  const MealsView({Key key, this.mealsListData, this.netWorkData, this.animationController, this.animation}) : super(key: key);
  final MealsListData mealsListData;
  final netWorkData;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
              100 * (1.0 - animation.value), 0.0, 0.0
            ),
            child: SizedBox(
              width: 130,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      child: Container(
                        width: 120,
                        height: 160,
                        child: FadeInImage.assetNetwork(
                          image: '${netWorkData.images}?x-oss-process=image/resize,m_fill,w_120,h_160',
                          placeholder: "assets/images/placeholder.jpg",
                          fit: BoxFit.cover,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Color(mealsListData.endColor).withOpacity(0.4),
                              offset: const Offset(1.0, 4.0),
                              blurRadius: 12.0
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 32,
                    child: Container(
                      width: 120,
                      height: 160,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(mealsListData.startColor),
                            Color(mealsListData.endColor).withOpacity(.6)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor.withAlpha(100),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 85,
                    left: 10,
                    width: 100,
                    child: GestureDetector(
                      onTap: (){
                        homeRouter(context, netWorkData.id);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${mealsListData.titleTxt}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 0.5,
                              color: Colors.white
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    "${netWorkData.title}",
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.fade,
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      height: 1.2,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                  Positioned(
                    top: 0,
                    left: 8,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(mealsListData.imagePath),
                    ),
                  )
                ]
              ),
            ),
          ),
        );
      }
    );
  }
}