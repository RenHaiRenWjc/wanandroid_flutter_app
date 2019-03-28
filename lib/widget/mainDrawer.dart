import 'package:flutter/material.dart';
import 'package:wanandroid_flutter_app/event/LoginEvent.dart';
import 'package:wanandroid_flutter_app/page/loginPage.dart';
import 'package:wanandroid_flutter_app/page/collectPage.dart';
import 'package:wanandroid_flutter_app/Utils/appManager.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  var _userName;

  @override
  void initState() {
    super.initState();
    AppManager.eventBus.on<LoginEvent>().listen((event) {
      setState(() {
        _userName = event.userName;
        AppManager.prefs.setString(AppManager.ACCOUNT, _userName);
      });
    });
    _userName = AppManager.prefs.getString(AppManager.ACCOUNT);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        getUserInfo(),
        InkWell(
          onTap: () => _itemClick(CollectPage()),
          child: ListTile(
            leading: Icon(Icons.favorite),
            title: Text(
              '收藏列表',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
          child: Divider(
            color: Colors.grey,
          ),
        ),
        Offstage(
          offstage: _userName == null, //是否隐藏 widget
          child: InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                '退出登录',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        )
      ],
    );
  }

  //
  void _itemClick(Widget page) {
    var dstPage = _userName == null ? LoginPage() : page;
    if (dstPage != null) {
      Navigator.push(context, new MaterialPageRoute(builder: (context) {
        return dstPage;
      }));
    }
  }

  Widget getUserInfo() {
    return DrawerHeader(
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
  }
}
