import 'package:cy_flutter/util/request.dart';
import 'package:cy_flutter/model/api_data.dart';

typedef RequestCallBack<T> = void Function(T value);

class API {
  static const BASE_URL = 'https://api.goxianguo.com/v2/';

  static const String TODAYREPICE = 'weekRecipes';
  static const String NEWRECIPES = 'newRecipesList';

  var _request = HttpRequest(API.BASE_URL);

  void getTodayRepice(RequestCallBack requestCallBack) async {
    // 获取今日推荐
    Map request = await _request.get(TODAYREPICE);
    var resultList = request['result'];
    var lunch = resultList['lunch'];
    var oth = resultList['dinner'];
    var breakfast = resultList['breakfast'];
    List<Subject> list1 = breakfast.map<Subject>((item) => Subject.fromMap(item)).toList();
    List<Subject> list2 = lunch.map<Subject>((item) => Subject.fromMap(item)).toList();
    List<Subject> list3 = oth.map<Subject>((item) => Subject.fromMap(item)).toList();
    requestCallBack({'breakfast': [list1[0],list2[0],list2[1],list3[0]]});
  }

  /// 获取新菜谱
  void getNewRecipes(RequestCallBack requestCallBack) async {
    Map result = await _request.get(NEWRECIPES);
    var resultList = result['result'];
    List<Subject> list = resultList.map<Subject>(
      (item) => Subject.fromMap(item)
    ).toList();
    requestCallBack(list);
  }
  
}