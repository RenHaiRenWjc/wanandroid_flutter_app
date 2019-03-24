import 'package:flutter/material.dart';
import 'package:wanandroid_flutter_app/page/webViewPage.dart';

class ArticleItem extends StatelessWidget {
  final itemDate;

  const ArticleItem(this.itemDate);

  @override
  Widget build(BuildContext context) {
    //水平线性布局  时间与作者
    Row author = new Row(
      children: <Widget>[
        //linearLayout weight
        new Expanded(
            child: Text.rich(TextSpan(children: [
          TextSpan(text: "作者:"),
          TextSpan(
              text: itemDate['author'],
              style: new TextStyle(color: Theme.of(context).primaryColor))
        ]))),
        new Text(itemDate['niceDate'])
      ],
    );

    Text title = new Text(
      itemDate['title'],
      style: new TextStyle(fontSize: 16.0, color: Colors.black),
      textAlign: TextAlign.left,
    );

    Text chapterName = new Text(
      itemDate['chapterName'],
      style: new TextStyle(color: Theme.of(context).primaryColor),
    );

    //垂直线性布局
    Column column = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.all(10.0),
          child: author,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10, 5.0, 10.0, 5.0),
          child: title,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: chapterName,
        )
      ],
    );
    return new Card(
      elevation: 4.0,
      child: InkWell(
        child: column,
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            itemDate['url'] = itemDate['link'];
            return WebViewPage(itemDate);
          }));
        },
      ),
    );
  }
}
