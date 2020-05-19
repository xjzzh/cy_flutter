import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cy_flutter/model/api_data.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView({Key key, this.tabIconsList, this.changeIndex, this.addClick}) : super(key:key);

  final Function(int index) changeIndex;
  final Function addClick;
  final List<TabIconData> tabIconsList;

  @override
  _BottomBarViewState createState() => _BottomBarViewState();

}

class _BottomBarViewState extends State<BottomBarView> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState(){
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000)
    );
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return Transform(
              transform: Matrix4.translationValues(0.0, 0.0, 0.0),
              child: Container(
                color: Theme.of(context).primaryColor.withOpacity(.9),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50.0 + MediaQuery.of(context).padding.bottom,
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Padding(
                            padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: MediaQuery.of(context).padding.bottom),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: TabIcons(
                                      tabIconData: widget.tabIconsList[0],
                                      removeAllSelect: () {
                                        setRemoveAllSelection(widget.tabIconsList[0]);
                                        widget.changeIndex(0);
                                      }),
                                ),
                                Expanded(
                                  child: TabIcons(
                                      tabIconData: widget.tabIconsList[1],
                                      removeAllSelect: () {
                                        setRemoveAllSelection(
                                            widget.tabIconsList[1]);
                                        widget.changeIndex(1);
                                      }),
                                ),
                                Expanded(
                                  child: TabIcons(
                                      tabIconData: widget.tabIconsList[2],
                                      removeAllSelect: () {
                                        setRemoveAllSelection(
                                          widget.tabIconsList[2]);
                                          widget.changeIndex(2);
                                      }),
                                ),
                                Expanded(
                                  child: TabIcons(
                                      tabIconData: widget.tabIconsList[3],
                                      removeAllSelect: () {
                                        setRemoveAllSelection(
                                          widget.tabIconsList[3]);
                                          widget.changeIndex(3);
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            );
          }
        )
      ],
    );
  }

  void setRemoveAllSelection(TabIconData tabIconData) {
    if (!mounted) return;
    setState(() {
      widget.tabIconsList.forEach((TabIconData tab) {
        tab.isSelected = false;
        if (tabIconData.index == tab.index) {
          tab.isSelected = true;
        }
      });
    });
  }

}

class TabIcons extends StatefulWidget {
  const TabIcons({Key key, this.tabIconData, this.removeAllSelect}) : super(key: key);
  final TabIconData tabIconData;
  final Function removeAllSelect;
  @override
  _TabIconsState createState() => _TabIconsState();
}

class _TabIconsState extends State<TabIcons> with TickerProviderStateMixin {
  @override
  void initState() {
    widget.tabIconData.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          widget.removeAllSelect();
          widget.tabIconData.animationController.reverse();
        }
      });
    super.initState();
  }

  void setAnimation() {
    widget.tabIconData.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if (!widget.tabIconData.isSelected) {
              setAnimation();
            }
          },
          child: IgnorePointer(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                ScaleTransition(
                  alignment: Alignment.center,
                  scale: Tween<double>(begin: 0.88, end: 1.0).animate(
                    CurvedAnimation(
                      parent: widget.tabIconData.animationController,
                      curve: Interval(0.1, 1.0, curve: Curves.fastOutSlowIn)
                    )
                  ),
                  child: Image.asset(
                    widget.tabIconData.isSelected
                      ? widget.tabIconData.selectedImagePath
                      : widget.tabIconData.imagePath
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 6,
                  right: 0,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.tabIconData.animationController,
                            curve: Interval(0.2, 1.0,
                                curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Color(0xFFFB7101),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 6,
                  bottom: 8,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.tabIconData.animationController,
                            curve: Interval(0.5, 0.8,
                                curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color(0xFFFB7101),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 8,
                  bottom: 0,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.tabIconData.animationController,
                            curve: Interval(0.5, 0.6,
                                curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Color(0xFFFB7101),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
