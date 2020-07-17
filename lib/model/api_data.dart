import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    // List txt = [
    //   '夜半酣酒江月下，美人纤手炙鱼头。',
    //   '惟有莼鲈堪漫吃，下官亦为啖鱼回。',
    //   '时绕麦田求野荠，强为僧舍煮山羹。',
    //   '长江绕郭知鱼美，好竹连山觉笋香。',
    //   '色如玉版猫头笋，味抵驼峰牛尾猩。',
    //   '扬州鲜笋趁鲥鱼，烂煮春风三月初。',
    //   '蒸鸡最知名，美不数鱼鳖。',
    //   '夜雨剪春韭，新炊间黄梁。',
    //   '围炉聚炊欢呼处，百味消融小釜中。',
    //   '雪沫乳花浮午盏 蓼茸蒿笋试春盘 人间有味是清欢。',
    //   '桂花香馅裹胡桃，江米如珠井水淘。',
    //   '螯封嫩玉双双满，壳凸红脂块块香。'
    // ];
    // var rng = new Random();
    // return txt[rng.nextInt(txt.length)];
    var hour = int.parse(now.hour.toString());
    if (hour >= 5 && hour < 10) {
      return '夜雨剪春韭，新炊间黄梁。';
    } else if (hour >=10 && hour < 15) {
      return '兰陵美酒郁金香，玉碗盛来琥珀光。';
    } else if (hour >=15 && hour < 17){
      return '螯封嫩玉双双满，壳凸红脂块块香。';
    } else if (hour >= 17 && hour < 20) {
      return '围炉聚炊欢呼处，百味消融小釜中。';
    } else {
      return '雪沫乳花浮午盏，蓼茸蒿笋试春盘。人间有味是清欢。';
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
  // 直接返回
  int resCode;
  String msg;

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

    resCode = map['code'];
    msg = map['msg'];
  }
}
/// 解析Detail
class DetailData {
  String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('yyyy-MM-dd');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';
    if (diff.inDays == 0) {
      time = '今天';
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      time = diff.inDays.toString() + '天前';
    } else if (diff.inDays > 7 && diff.inDays < 32) {
       time = (diff.inDays / 7).floor().toString() + '周前';     
    } else {
      time = format.format(date);
    }
    return time;
  }
  String degreeDifficulty(double degreen) {
    var difficulty = '';
    if (degreen <= 2.0) {
      difficulty = '初级';
    } else if (degreen > 2.0 && degreen < 3.5) {
      difficulty = "中级";
    } else {
      difficulty = "高级";
    }
    return difficulty;
  }
  String image;
  String story;
  String nickname;
  String title;
  int like;
  int collect;
  double score;
  String creaDate;
  String avatar;
  String difficult;
  String cookTime;
  String tips;
  List<RecipeIngredient> ingredients;
  List<RecipeIngredient> step;

  DetailData({
    this.image,
    this.story,
    this.like,
    this.collect,
    this.score,
    this.nickname,
    this.creaDate,
    this.title,
    this.avatar,
    this.difficult,
    this.cookTime,
    this.tips,
    this.ingredients,
    this.step,
  });
  DetailData.fromJson(jsonRes) {
    image = jsonRes['cov_img'];
    story = jsonRes["story"];
    like = jsonRes["like_num"] as int;
    collect = jsonRes['collect_num'] as int;
    title = jsonRes["title"];
    nickname = jsonRes["nickname"];
    avatar = jsonRes["avatar"];
    creaDate = readTimestamp(int.parse(jsonRes["crea_date"]));
    difficult = degreeDifficulty(jsonRes["difficult"] as double);
    score = double.parse(jsonRes['score']);
    cookTime = jsonRes["time_consum"];
    tips = jsonRes["tips"];
    ingredients = jsonRes["ingr"].map<RecipeIngredient>((i) => RecipeIngredient.fromMap(i)).toList();
    step = jsonRes['step'].map<RecipeIngredient>((item) => RecipeIngredient.fromMap(item)).toList();
  }
}
class RecipeIngredient {
  RecipeIngredient({
    this.amount, 
    this.description, 
    this.img,
  });

  String amount;
  String description;
  String img;
  String txt;

  RecipeIngredient.fromMap(Map<String, dynamic> map) {
    amount = map["tit"];
    description = map["value"];
    txt = map['txt'];
    img = map['img'];
  }
}

class Start {
  Start({
    this.totalNum,
    this.oneStart,
    this.twoStart,
    this.threeStart,
    this.fourStart,
    this.fiveStart
  });
  num totalNum;
  num fiveStart;
  num fourStart;
  num oneStart;
  num threeStart;
  num twoStart;

  Start.fromJson(jsonRes) {
    totalNum = jsonRes['TotalNum'] == null ? 0 : jsonRes['TotalNum'];
    oneStart = jsonRes['oneStart'] == null ? 0 : jsonRes['oneStart'];
    twoStart = jsonRes['twoStart'] == null ? 0 : jsonRes['twoStart'];
    threeStart = jsonRes['threeStart'] == null ? 0 : jsonRes['threeStart'];
    fourStart = jsonRes['fourStart'] == null ? 0 : jsonRes['fourStart'];
    fiveStart = jsonRes['fiveStart'] == null ? 0 : jsonRes['fiveStart']; 
  }

}

class DetailUser {
  String message;
  String result;
  int code;
  int isCollect;
  int isLike;

  DetailUser({
    this.message,
    this.result,
    this.code,
    this.isCollect,
    this.isLike
  });

  DetailUser.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result = json['result'];
    code = json['code'];
    isCollect = json['is_collect'];
    isLike = json['is_like'];
  }
}
