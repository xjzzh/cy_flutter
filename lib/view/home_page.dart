import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key key, this.animationController}) : super(key:key);
  final AnimationController animationController;

  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }
}