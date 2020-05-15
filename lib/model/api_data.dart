import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/images/home.png',
      selectedImagePath: 'assets/images/home_s.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/images/class.png',
      selectedImagePath: 'assets/images/class_s.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/images/collect.png',
      selectedImagePath: 'assets/images/collect_s.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/images/user.png',
      selectedImagePath: 'assets/images/user_s.png',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}

class Subject {
  var title;
  var avatar;
  var collect;
  int like;
  int id;
  int tag;
  String images; 
  String nickname;
  String score;

  Subject.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    images =  map['cov_img'];
    id = map['cok_id'] as int;
    tag = map['tag'] as int;
    avatar = map['avatar'];
    nickname = map['nickname'];
    score = map['score'];
    like = map['like_num'];
    collect = map['collect_num'];
  }
}

class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/images/breakfast.png',
      titleTxt: '早餐',
      startColor: '0XFFFA7D82',
      endColor: '0XFFFFB295',
    ),
    MealsListData(
      imagePath: 'assets/images/lunch.png',
      titleTxt: '午餐',
      startColor: '0XFF738AE6',
      endColor: '0XFF5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/images/dinner.png',
      titleTxt: '晚餐',
      startColor: '0XFF6F72CA',
      endColor: '0XFF1E1466',
    ),
  ];
}
