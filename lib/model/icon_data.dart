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

class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String> meals;
  int kacl;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/fitness_app/breakfast.png',
      titleTxt: '早餐',
      kacl: 525,
      meals: <String>['Bread,', 'Peanut butter,', 'Apple'],
      startColor: '0XFFFA7D82',
      endColor: '0XFFFFB295',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/lunch.png',
      titleTxt: '午餐',
      kacl: 602,
      meals: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
      startColor: '0XFF738AE6',
      endColor: '0XFF5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      titleTxt: '晚餐',
      kacl: 0,
      meals: <String>['Recommend:', '703 kcal'],
      startColor: '0XFF6F72CA',
      endColor: '0XFF1E1466',
    ),
  ];
}
