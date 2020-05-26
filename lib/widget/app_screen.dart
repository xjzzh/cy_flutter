import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:chuyi/model/api_data.dart';
import 'package:chuyi/widget/bottom_bar.dart';
import 'package:chuyi/view/home/home_page.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget pageBody = Container();

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    pageBody = HomePageScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Stack(
              children: <Widget>[
                pageBody,
                bottomBar(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget bottomBar() {
    return Column(
      children:<Widget>[
        const Expanded(
          child: SizedBox()
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  pageBody = HomePageScreen(animationController: animationController);
                });
              });
            }
          }
        )
      ]
    );
  }

}