import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cy_flutter/util/request.dart';
import 'package:cy_flutter/model/api_data.dart';
import 'package:http/http.dart';

typedef RequestCallBack<T> = void Function(T value);

class API {
  static const BASE_URL = 'https://api.goxianguo.com/';

  static const String TODAYREPICE = 'v2/weekRecipes';
  static const String NEWRECIPES = 'v2/newRecipesList';
  static const String HOTRECIPES = 'v2/hotRecipesList';
  static const String CLASSIFY = 'getCookSort';
  static const String EXPLOREREPICE = 'getIndexList';
  var nonceStr = new DateTime.now().millisecondsSinceEpoch.toString();

  String signParams(Map params) {
    String key = "&key=Wky9F3JmbK";
    params['nonce_str'] = nonceStr.toString();
    /// 存储key
    List<String> allKeys = [];
    params.keys.where((k) => params[k].isEmpty) // 筛选空值
    .toList()
    .forEach(params.remove);  //  删除空值
    params.forEach((key, value) => allKeys.add('$key=$value'));
    // 字典序排序
    allKeys.sort((x,y) => x.compareTo(y));
    //allKeys.join('&');
    // 数组转String
    String pairsString = allKeys.join("&");
    // 拼接字符串
    String sign = pairsString + key;
    String signString = md5.convert(utf8.encode(sign)).toString().toUpperCase();
    return signString;
  }

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
  
  /// 获取热门菜谱
  void getHotRecipes(RequestCallBack requestCallBack) async {
    final Map result = await _request.get(HOTRECIPES);
    var resultList = result['result'];
    List<Subject> list = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    requestCallBack(list);
  }

  /// 获取分类 1
  void getClassify(RequestCallBack requestCallBack) async {
    Map data = {'nonce_str': nonceStr};
    data['sign'] = signParams(data);
    final result = await _request.post(CLASSIFY, json.encode(data));
    var resultList = result['result']['1'];
    List<Subject> sort = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    requestCallBack(sort);
  }

  /// 获取发现
  void getExploreRecipes(pageNo, RequestCallBack requestCallBack) async {
    Map data = {
      'nonce_str': nonceStr,
      'pageNo': pageNo,
      'pageSize': '10'
    };
    data['sign'] = signParams(data);
    final result = await _request.post(EXPLOREREPICE, json.encode(data));
    var resultList = result['result']['indexList'];
    List<Subject> indexList = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    requestCallBack(indexList);
  }

}