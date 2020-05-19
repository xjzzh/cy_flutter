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
  /// 底部tabbar icon
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

class NowDate {
  var now = new DateTime.now();
  String todayWeek() {
    var weekday = now.weekday.toString();
    
    var todayWeek = '';
    if (weekday == '1') {
      todayWeek = '星期一';
    } else if (weekday == '2') {
      todayWeek = '星期二';
    } else if (weekday == '3') {
      todayWeek = '星期三';
    } else if (weekday == '4') {
      todayWeek = '星期四';
    } else if (weekday == '5') {
      todayWeek = '星期五';
    } else if (weekday == '6') {
      todayWeek = '星期六';
    } else {
      todayWeek = '星期日';
    }
    return todayWeek;
  }

  String hours() {
    var hour = int.parse(now.hour.toString());
    if (hour >= 5 && hour < 10) {
      return '记得吃早餐喔 🥪';
    } else if (hour >=10 && hour < 15) {
      return '午餐准备好了吗 🍛';
    } else if (hour >=15 && hour < 17){
      return '喝水是必不可少的 🥤';
    } else if (hour >= 17 && hour < 20) {
      return '和家人共进晚餐吧 🥘';
    } else {
      return '晚安,好梦💤';
    }
    
  }

}

/// 解析home api
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
  // 分类
  String sortName;
  String sortImg;

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

    sortImg = map['sort_img'];
    sortName = map['sort_name'];
  }
}

class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor,
    this.endColor,
  });

  String imagePath;
  String titleTxt;
  int startColor;
  int endColor;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/images/breakfast.png',
      titleTxt: '早餐',
      startColor: 0xFFFA7D82,
      endColor: 0xFFFFB295,
    ),
    MealsListData(
      imagePath: 'assets/images/lunch.png',
      titleTxt: '午餐',
      startColor: 0xFF738AE6,
      endColor: 0xFF5C5EDD,
    ),
    MealsListData(
      imagePath: 'assets/images/dinner.png',
      titleTxt: '晚餐',
      startColor: 0xFF6F72CA,
      endColor: 0xFF1E1466,
    ),
    MealsListData(
      imagePath: 'assets/images/snack.png',
      titleTxt: '小吃零食',
      startColor: 0xFFFE95B6,
      endColor: 0xFFFF5287,
    ),
  ];
}
