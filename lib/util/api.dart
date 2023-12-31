import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:crypto/crypto.dart';
import 'package:chuyi/util/request.dart';
import 'package:chuyi/model/api_data.dart';

typedef RequestCallBack<T> = void Function(T value);

class API {
  static const BASE_URL = 'https://api.goxianguo.com/';
  static const String TODAYREPICE = 'v2/weekRecipes';
  static const String NEWRECIPES = 'v2/newRecipesList';
  static const String HOTRECIPES = 'v2/hotRecipesList';
  static const String CLASSIFY = 'getCookSort';
  static const String EXPLOREREPICE = 'getIndexList';
  static const String DETAIL = 'getCookDetail';
  static const String USERISLIKE = 'getCookUserStatus';
  static const String MARKSTART = 'getMarkStart';
  static const String SENDSMSCODE = 'sendSMSCode';
  static const String LOGINCODE = 'verificationCodeLogin';
  static const String GETCOOKLIKE = 'getCookLike';
  static const String GETCOOKCOLLECT = 'getCookCollect';

  static const String GETUSERINFO = 'getProfile';


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
      'pageNo': '2',
      'pageSize': '10'
    };
    data['sign'] = signParams(data);
    final result = await _request.post(EXPLOREREPICE, json.encode(data));
    var resultList = result['result']['indexList'];
    List<Subject> indexList = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    requestCallBack(indexList);
  }

  /// 获取详情
  void getDetail(int id, RequestCallBack requestCallBack) async {
    Map data = {
      'nonce_str': nonceStr,
      'cokId': id.toString(),
    };
    data['sign'] = signParams(data);
    final result = await _request.post(DETAIL, json.encode(data));
    var resultList = result['result'];
    DetailData detail = DetailData.fromJson(resultList);
    requestCallBack(detail);
  }

  /// 获取评分详情
  void getMarkStart(int id, RequestCallBack requestCallBack) async{
    Map data = {
      'nonce_str': nonceStr,
      'cokId': id.toString()
    };
    data['sign'] = signParams(data);
    final result = await _request.post(MARKSTART, json.encode(data));
    var markStart = result['result']['start'];
    var startWeight = result['result']['startWeight'];
    Start start = Start.fromJson(markStart);
    requestCallBack({'start':start,'total':startWeight});
  }

  var dio = Dio();
  var cookieJar= CookieJar();

  /// 发送验证码
  void sendSMSCode(String phoneNumbers, RequestCallBack requestCallBack) async {
    dio.interceptors.add(CookieManager(cookieJar));
    Map data = {
      'nonce_str': nonceStr,
      'phone_numbers': phoneNumbers
    };
    data['sign'] = signParams(data);
    Response result = await dio.post(BASE_URL+SENDSMSCODE,data: jsonEncode(data));
    DetailUser res = DetailUser.fromJson(json.decode(result.data));
    requestCallBack(res);
  }
  /// 登录
  void codeLogin(String phoneNumbers, String code, RequestCallBack requestCallBack) async {
    dio.interceptors.add(CookieManager(cookieJar));
    Map data = {
      'nonce_str': nonceStr,
      'phone_numbers': phoneNumbers,
      'code': code
    };
    data['sign'] = signParams(data);
    Response result = await dio.post(BASE_URL+LOGINCODE, data: jsonEncode(data));
    DetailUser res = DetailUser.fromJson(json.decode(result.data));
    requestCallBack(res);
  }

  /// 查询用户点赞收藏状态
  void getIsLike(String userId, int id,RequestCallBack requestCallBack) async {
    Map data = {
      'nonce_str': nonceStr,
      'userId': userId,
      'cokId': id.toString()
    };
    data['sign'] = signParams(data);
    final result = await _request.post(USERISLIKE, jsonEncode(data));
    DetailUser res = DetailUser.fromJson(result['result']);
    requestCallBack(res);
  }

  /// 请求点赞接口
  void getCookLike(String userId, int id, RequestCallBack requestCallBack) async{
    Map data = {
      'nonce_str': nonceStr,
      'userId': userId,
      'id': id.toString()
    };
    data['sign'] = signParams(data);
    final result = await _request.post(GETCOOKLIKE, jsonEncode(data));
    requestCallBack(result['result']);
  }

  /// 请求收藏
  void getFavorite(String userId, int id, RequestCallBack requestCallBack) async {
    Map data = {
      'nonce_str': nonceStr,
      'userId': userId,
      'id': id.toString()
    };
    data['sign'] = signParams(data);
    final result = await _request.post(GETCOOKCOLLECT, jsonEncode(data));
    requestCallBack(result['result']);
  }

  /// 获取用户资料
  void getUserInfo(String userId, RequestCallBack requestCallBack) async {
    Map data = {
      'nonce_str': nonceStr,
      'userId': userId,
    };
    data['sign'] = signParams(data);
    final result = await _request.post(GETUSERINFO, jsonEncode(data));
    UserInfo res = UserInfo.fromJson(result['result']);
    requestCallBack(res);
  }
}