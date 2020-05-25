import 'package:flutter/material.dart';
import 'package:cy_flutter/model/api_data.dart';
import 'package:cy_flutter/util/api.dart';
import 'package:cy_flutter/widget/network_image.dart';
import 'dart:math' as math;

class ClassifyHomeView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const ClassifyHomeView({Key key, this.animationController, this.animation}) : super(key: key);

  @override
  _ClassifyHomeViewState createState() => _ClassifyHomeViewState();
}

final API _api = API();

class _ClassifyHomeViewState extends State<ClassifyHomeView> with TickerProviderStateMixin {
  List<Subject> getClassify = List();

  @override
  void initState() {
     _api.getClassify((value) {
      setState(() {
        getClassify = value;
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
                  itemBuilder: (context, index) => _classifyList(context, index),
                  itemCount: math.min(getClassify.length, 5),
                ),
              ),
            ),
          )
        );
      }
    );
  }

  Widget _classifyList(BuildContext context,int index) {
    return GestureDetector(
      onTap: (){
        //homeRouter(context,getClassify[index%getClassify.length].id);
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
                child: PNetworkImage(
                  '${getClassify[index%getClassify.length].sortImg}?x-oss-process=image/resize,m_fill,w_220,h_275/format,webp',
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
                        Colors.black54,
                        Colors.transparent
                      ]
                    )
                  ),
                ),
              ),
              Positioned.fill(
                left: 12,
                bottom: 12,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '${getClassify[index%getClassify.length].sortName}',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}