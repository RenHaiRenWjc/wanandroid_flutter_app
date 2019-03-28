//  https://www.wanandroid.com/blog/show/2   玩android api
import 'package:dio/dio.dart';
import 'package:wanandroid_flutter_app/http/baseNetwork.dart';

class Api {
  static const String BASE_URL = "https://www.wanandroid.com/";

  //  https://www.wanandroid.com/article/list/0/json
  static const String ARTICLE_LIST = BASE_URL + "article/list/";

  static const String BANNERS = BASE_URL + "banner/json";

  // https://www.wanandroid.com/user/login
  static const String LOGIN = BASE_URL + '/user/login';

//  https://www.wanandroid.com/user/register
  static const String REGISTER = BASE_URL + '/user/register';

//  https://www.wanandroid.com/lg/collect/list/0/json
  static const String COLLECT_LIST = BASE_URL + '/lg/collect/list/';

  static getArticleList(int page) async {
    return await BaseNetwork.getInstance().request('$ARTICLE_LIST$page/json');
  }

  static getBanner() async {
    return await BaseNetwork.getInstance().request(Api.BANNERS);
  }

  static login(String userName, String pwd) async {
    var fromData = FormData.from({'username': userName, 'password': pwd});
    return await BaseNetwork.getInstance().request(
      LOGIN,
      data: fromData,
      method: 'post',
    );
  }

  static register(String userName, String pwd) async {
    var fromData = FormData.from({'username': userName, 'pwd': pwd});
    return await BaseNetwork.getInstance()
        .request(REGISTER, data: fromData, method: 'post');
  }

  static clearCookie() {
    BaseNetwork.getInstance().clearCookie();
  }

  static getCollectList(int page) async {
    return await BaseNetwork.getInstance().request('$COLLECT_LIST$page/json');
  }
}
