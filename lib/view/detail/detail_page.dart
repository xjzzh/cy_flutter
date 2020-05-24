import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final cookId;

  DetailPage({Key key, this.cookId}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState(cookId);
}

class _DetailPageState extends State<DetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final cookId;
  _DetailPageState(this.cookId);

  @override
  void initState(){

  }
  
  @override
  Widget build(BuildContext context) {
    if (_getDetail == null) {
      return Scaffold(
        body: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(delegate: null)
        ],
      ),
    );
  }


}