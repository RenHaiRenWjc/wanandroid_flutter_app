import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';

class BaseNetwork {
  Dio _dio;
  static BaseNetwork _instance;

  PersistCookieJar _persistCookieJar;

  factory BaseNetwork.getInstance() {
    if (null == _instance) {
      _instance = new BaseNetwork._internal();
    }
    return _instance;
  }

//重定向构造方法
  BaseNetwork._internal() {
    BaseOptions options = new BaseOptions(
        baseUrl: Api.BASE_URL, connectTimeout: 10000, receiveTimeout: 10000);
    _dio = new Dio(options);
    _initDio();
  }

  void _initDio() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var path = Directory(join(directory.path, 'cookie')).path;
    _persistCookieJar = PersistCookieJar(dir: path);
    _dio.interceptors.add(CookieManager(_persistCookieJar));
  }

  request(url, {data, String method = "get"}) async {
    Options options = new Options(method: method);
    Response response = await _dio.request(url, data: data, options: options);
    return response.data;
  }

  void clearCookie() {
    _persistCookieJar.deleteAll();
  }
}
