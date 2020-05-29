import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:chuyi/model/api_data.dart';
import 'package:chuyi/util/api.dart';
import 'package:chuyi/widget/reting_bar.dart';
import 'package:chuyi/model/router.dart';

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
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 10,
                childAspectRatio: (MediaQuery.of(context).size.width/2)/300,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: List.generate(
                  math.min(getExplore.length, 10),(index) {
                    return _exploreRecipesList(context, index);
                  },
                )
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _exploreRecipesList(BuildContext context, index) {
    return GestureDetector(
      onTap: (){
        homeRouter(context, getExplore[index&getExplore.length].id);
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Stack(
          children: <Widget>[
            Container(
              color: Theme.of(context).accentColor,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 188.0,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: FadeInImage.assetNetwork(
                            placeholder:'assets/images/placeholder.jpg',
                            image:'${getExplore[index%getExplore.length].images}?x-oss-process=image/resize,m_fill,w_360,h_400', 
                            fit: BoxFit.cover,
                          ),
                        ),
                      ]
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${getExplore[index%getExplore.length].title}',
                          softWrap: true,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 5),
                        RatingBar(double.parse(getExplore[index%getExplore.length].score))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 173,
              left: 10,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2,color: Colors.white.withOpacity(0.8)),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${getExplore[index%getExplore.length].avatar}'
                    ),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}