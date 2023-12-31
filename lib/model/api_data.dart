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

  String earthly() {
    // 地支
    var earthly = int.parse(DateFormat('HH').format(now));
    if (earthly >= 23 && earthly < 1) {
      return '子时，夜半更深';
    } else if (earthly >= 1 && earthly < 3) {
      return '丑时，东方未明';
    } else if (earthly >= 3 && earthly < 5) {
      return '寅时，晨光熹微';
    } else if (earthly >= 5 && earthly < 7) {
      return '卯时，东方破晓';
    } else if (earthly >= 7 && earthly < 9) {
      return '辰时，旭日东升';
    } else if (earthly >= 9 && earthly < 11) {
      return '巳时，丽日临空';
    } else if (earthly >= 11 && earthly < 13) {
      return '午时，当午日明';
    } else if (earthly >= 13 && earthly < 15) {
      return '未时，午后风和';
    } else if (earthly >= 15 && earthly < 17) {
      return '申时，日已偏西';
    } else if (earthly >= 17 && earthly < 19) {
      return '酉时，夕阳西下';
    } else if (earthly >= 19 && earthly < 21) {
      return '戌时，华灯初上';
    } else if (earthly >= 21 && earthly < 23) {
      return '亥时，夜阑人静';
    }
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
  String creatDate;
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
    this.creatDate,
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
    story = jsonRes['story'];
    like = jsonRes['like_num'] as int;
    collect = jsonRes['collect_num'] as int;
    title = jsonRes['title'];
    nickname = jsonRes['nickname'];
    avatar = jsonRes['avatar'];
    creatDate = readTimestamp(int.parse(jsonRes['crea_date']));
    difficult = degreeDifficulty(jsonRes['difficult'] as double);
    score = double.parse(jsonRes['score']);
    cookTime = jsonRes['time_consum'];
    tips = jsonRes['tips'];
    ingredients = jsonRes['ingr'] == null ? [] : jsonRes['ingr'].map<RecipeIngredient>((i) => RecipeIngredient.fromJson(i)).toList();
    step = jsonRes['step'] == null ? [] : jsonRes['step'].map<RecipeIngredient>((item) => RecipeIngredient.fromJson(item)).toList();
  }
}
class RecipeIngredient {
  RecipeIngredient({
    this.amount,
    this.description,
    this.img,
    this.txt,
  });

  String amount;
  String description;
  String img;
  String txt;

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) {
    return RecipeIngredient(
      amount: json['tit'],
      description: json['value'],
      txt: json['txt'],
      img: json['img']
    );
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

class UserInfo {
  String city;
  String avatar;
  String createdTime;
  String phoneNumber;
  String userId;
  String points;
  String nickname;
  int gender;
  int isActive;
  String province;

  UserInfo(
      {this.city,
      this.avatar,
      this.createdTime,
      this.phoneNumber,
      this.userId,
      this.points,
      this.nickname,
      this.gender,
      this.isActive,
      this.province});

  UserInfo.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    avatar = json['avatar'];
    createdTime = json['created_time'];
    phoneNumber = json['phone_number'];
    userId = json['user_id'];
    points = json['points'];
    nickname = json['nickname'];
    gender = json['gender'];
    isActive = json['is_active'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['avatar'] = this.avatar;
    data['created_time'] = this.createdTime;
    data['phone_number'] = this.phoneNumber;
    data['user_id'] = this.userId;
    data['points'] = this.points;
    data['nickname'] = this.nickname;
    data['gender'] = this.gender;
    data['is_active'] = this.isActive;
    data['province'] = this.province;
    return data;
  }
}
