import 'package:dio/dio.dart';
import 'api.dart';

class CommonService {
  Dio _dio;
  static CommonService _instance;

  factory CommonService.getInstance() {
    if (null == _instance) {
      _instance = new CommonService._internal();
    }
    return _instance;
  }

//重定向构造方法
  CommonService._internal() {
    BaseOptions options = new BaseOptions(
        baseUrl: Api.BASE_URL, connectTimeout: 10000, receiveTimeout: 10000);
    _dio = new Dio(options);
  }

  _request(url, {String method = "get"}) async {
    Options options = new Options(method: method);
    Response response = await _dio.request(url, options: options);
    return response.data;
  }

  //  https://www.wanandroid.com/article/list/0/json
  getArticleList(int page) async {
    return await CommonService.getInstance()
        ._request('${Api.ARTICLE_LIST}$page/json');
  }

  getBanner() async {
    return await CommonService.getInstance()._request(Api.BANNERS);
  }
}
