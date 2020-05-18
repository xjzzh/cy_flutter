import 'package:cy_flutter/model/api_data.dart';
import 'package:cy_flutter/util/api.dart';
import 'package:cy_flutter/widget/network_image.dart';
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
      onTap: () {},
      child: Container(
        width: 160,
        height: 220,
        margin: EdgeInsets.only(right: 8,left: 6),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          child: Stack(
            children: <Widget>[
              Container(
                child: PNetworkImage(
                  '${getHotRecipes[index%getHotRecipes.length].images}?x-oss-process=image/resize,m_fill,w_180,h_230/format,webp',
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
              )
            ],
          ),
        )
      ),
    );
  }
}
