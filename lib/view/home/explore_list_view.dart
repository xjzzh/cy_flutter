import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:cy_flutter/model/api_data.dart';
import 'package:cy_flutter/util/api.dart';
import 'package:cy_flutter/widget/network_image.dart';
import 'package:cy_flutter/widget/reting_bar.dart';

class ExploreRecipesView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;
  

  const ExploreRecipesView({Key key, this.animationController, this.animation})
  : super(key: key);

  @override
  _ExploreRecipesViewState createState() => _ExploreRecipesViewState();
}
final API _api = API();
class _ExploreRecipesViewState extends State<ExploreRecipesView> with TickerProviderStateMixin {
  List<Subject> getExplore = List();
  String pageNo = '1';

  @override
  void initState() {
    _api.getExploreRecipes(pageNo, (value) async {
      await value;
      setState(() {
        getExplore = value;
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
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: (1 / 1.62),
                  crossAxisCount: 2
                ),
                itemCount: math.min(getExplore.length, 10),
                itemBuilder:(BuildContext context, int index) {
                  return _exploreRecipesList(context, index);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _exploreRecipesList(BuildContext context, index) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        width: 160,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1,
                    child: PNetworkImage(
                      '${getExplore[index%getExplore.length].images}?x-oss-process=image/resize,m_fill,w_160,h_200/format,webp',
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
                          flex: 1,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, top: 18, bottom: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 50,
                                    child: Text(
                                      '${getExplore[index%getExplore.length].title}',
                                      softWrap: true,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: RatingBar(double.parse(getExplore[index%getExplore.length].score)),
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
                bottom: 88,
                left: 8,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2,color: Theme.of(context).accentColor),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        '${getExplore[index%getExplore.length].avatar}'
                      ),
                      fit: BoxFit.cover
                    )
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );    
  }
}