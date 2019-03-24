import 'package:flutter/material.dart';
import 'package:banner_view/banner_view.dart';
import 'package:wanandroid_flutter_app/http/commonService.dart';
import 'package:wanandroid_flutter_app/page/webViewPage.dart';
import 'package:wanandroid_flutter_app/widget/articleItem.dart';

class ArticlePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ArticlePageState();
  }
}

class _ArticlePageState extends State<ArticlePage> {
  ScrollController _controller = new ScrollController();
  bool _isHide = true;
  List articles = [];
  List banners = [];
  var totalCount = 0;
  var curPage = 0;

  //每次widget插入widget树时，都会调用，只有调用一次
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels && curPage < totalCount) {
        _getArticleList();
      }
    });
    _pullToRefresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      //帧布局
      children: <Widget>[
        Offstage(
          offstage: !_isHide, //是否隐藏widget树的其他部分
          ///正在加载
          child: new Center(
            child: CircularProgressIndicator(),
          ),
        ),

        //内容
        Offstage(
          offstage: _isHide,
          child: new RefreshIndicator(
              child: ListView.builder(
                itemCount: articles.length + 1,
                itemBuilder: (context, i) => _buildItem(i),
                controller: _controller,
              ),
              onRefresh: _pullToRefresh),
        )
      ],
    );
  }

  Widget _buildItem(int i) {
    if (i == 0) {
      return new Container(
        height: 180,
        child: _bannerView(),
      );
    }
    var itemData = articles[i - 1];
    return new ArticleItem(itemData);
  }

  Widget _bannerView() {
    List<Widget> list = banners.map((item) {
//      return Image.network(
//        item['imagePath'],
//        fit: BoxFit.cover,
//      );
      return InkWell(
        child: Image.network(
          item['imagePath'],
          fit: BoxFit.cover,
        ),
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return WebViewPage(item);
          }));
        },
      );
    }).toList();

    return list.isNotEmpty
        ? BannerView(list, intervalDuration: const Duration(seconds: 3))
        : null;
  }

  Future<void> _pullToRefresh() async {
    curPage = 0;
    Iterable<Future> futures = [_getArticleList(), _getBanner()];
    await Future.wait(futures);
    _isHide = false;
    setState(() {});
    return null;
  }

  _getArticleList([bool update = true]) async {
    var data = await CommonService.getInstance().getArticleList(curPage);
    if (data != null) {
      var map = data['data'];
      var articleList = map['datas'];
      totalCount = map['pageCount'];
      if (curPage == 0) {
        articles.clear();
      }
      curPage++;
      articles.addAll(articleList);
      if (update) {
        setState(() {});
      }
    }
  }

  _getBanner([bool update = true]) async {
    var data = await CommonService.getInstance().getBanner();
    if (data != null) {
      banners.clear();
      banners.addAll(data['data']);
      if (update) {
        setState(() {});
      }
    }
  }
}
