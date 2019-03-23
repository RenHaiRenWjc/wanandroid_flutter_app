import 'package:flutter/material.dart';
import 'package:wanandroid_flutter_app/page/articlePage.dart';

void main() => runApp(new ArticleApp());

class ArticleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "文章",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: new ArticlePage(),
      ),
    );
  }
}
