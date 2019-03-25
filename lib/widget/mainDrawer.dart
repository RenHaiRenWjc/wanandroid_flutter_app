import 'package:flutter/material.dart';
import 'package:wanandroid_flutter_app/page/loginPage.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  var _userName;

  @override
  Widget build(BuildContext context) {
    Widget userHeader = DrawerHeader(
      child: InkWell(
        onTap: () => _itemClick(null),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 18.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo.png'),
                radius: 38.0,
              ),
            ),
            Text(
              _userName ?? "请先登录",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(color: Colors.blue),
    );
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        userHeader,
      ],
    );
  }

  void _itemClick(Widget page) {
    var dstPage = _userName == null ? LoginPage() : page;
    if (dstPage != null) {
      Navigator.push(context, new MaterialPageRoute(builder: (context) {
        return dstPage;
      }));
    }
  }
}
