import 'package:chuyi/model/api_data.dart';
import 'package:chuyi/util/api.dart';
import 'package:chuyi/model/router.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HotRecipesView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const HotRecipesView({Key key, this.animationController, this.animation}) : super(key: key);

  @override
  _HotRecipesViewState createState() => _HotRecipesViewState();
}

final API _api = API();

class _HotRecipesViewState extends State<HotRecipesView> with TickerProviderStateMixin {
  List<Subject> getHotRecipes = List();

  @override
  void initState() {
    _api.getHotRecipes((value) {
      setState(() {
        getHotRecipes = value;
      });
    });

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child){
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
              0.0, 30 * (1.0 - widget.animation.value), 0.0
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) => _hotReciptsList(context, index),
                  itemCount: math.min(getHotRecipes.length, 10),
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _hotReciptsList(BuildContext context,int index){
    return GestureDetector(
      onTap: (){
        homeRouter(context, getHotRecipes[index%getHotRecipes.length].id);
      },
      child: Container(
        width: 160,
        height: 200,
        margin: EdgeInsets.only(right: 8,left: 6),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          child: Stack(
            children: <Widget>[
              Container(
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.jpg',
                  image: '${getHotRecipes[index%getHotRecipes.length].images}?x-oss-process=image/resize,m_fill,w_220,h_275/format,webp',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                child: Container(
                  width: 160,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black38,
                        Colors.transparent,
                        Colors.black38
                      ]
                    )
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2,color: Colors.white.withOpacity(0.8)),
                        image: DecorationImage(
                          image: NetworkImage(
                            '${getHotRecipes[index%getHotRecipes.length].avatar}'
                          ),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${getHotRecipes[index%getHotRecipes.length].nickname}',
                      style: TextStyle(fontSize: 14.0,color: Colors.white),
                    )
                  ],
                )
              ),
              Positioned(
                left: 8,
                bottom: 16,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      '${getHotRecipes[index%getHotRecipes.length].title}',
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                )
              ),
              Positioned(
                left: 8,
                bottom: 38,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.white,size: 20),
                    SizedBox(width: 2),
                    Text(
                      '${getHotRecipes[index].score}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                      ),
                    )
                  ],
                )
              )
            ],
          ),
        )
      ),
    );
  }
}
