import 'package:cy_flutter/model/api_data.dart';
import 'package:cy_flutter/util/api.dart';
import 'package:cy_flutter/widget/network_image.dart';
import 'package:cy_flutter/widget/reting_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

final API _api = API();
class NewRecipesView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const NewRecipesView({Key key, this.animationController, this.animation}) 
      : super(key: key);
  
  @override
  _NewRecipesViewState createState() => _NewRecipesViewState();

}

class _NewRecipesViewState extends State<NewRecipesView> with TickerProviderStateMixin {
  List<Subject> getNewRecipes = List();

  @override
  void initState(){
    _api.getNewRecipes((item) {
      setState(() {
        getNewRecipes = item;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
              0.0, 30 * (1.0 - widget.animation.value), 0.0
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                height: 236,
                child: ListView.builder(
                  itemBuilder: (context, index) => _newReciptsList(context, index),
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  itemCount: math.min(getNewRecipes.length, 10),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
  
  Widget _newReciptsList(BuildContext context, index){
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        width: 160,
        margin: EdgeInsets.only(right: 8,left: 6),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1,
                    child: PNetworkImage(
                      '${getNewRecipes[index%getNewRecipes.length].images}?x-oss-process=image/resize,m_fill,w_160,h_200/format,webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    color: Theme.of(context).accentColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${getNewRecipes[index%getNewRecipes.length].title}',
                                    softWrap: true,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '${getNewRecipes[index%getNewRecipes.length].collect.toString()}人收藏',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: RatingBar(4.5),
                                  )
                                ],
                              ),
                            ),
                          )
                        )
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.favorite_border,
                        color: Color(0xFFFB7101),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
