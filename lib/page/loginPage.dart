import 'package:flutter/material.dart';
import 'package:wanandroid_flutter_app/Utils/appManager.dart';
import 'package:wanandroid_flutter_app/event/LoginEvent.dart';
import 'package:wanandroid_flutter_app/http/api.dart';
import 'package:wanandroid_flutter_app/page/registerPage.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _pwdNode = new FocusNode();
  String _userName, _password;
  bool _isShowPwd = true;
  Color _pwdIcomColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'login',
      )),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            children: <Widget>[
              _buildUserName(),
              _buildPwd(),
              _buildLogin(),
              _buildRegister()
            ],
          )),
    );
  }

  Widget _buildUserName() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(labelText: 'name'),
      initialValue: _userName,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(_pwdNode);
      },
      validator: (String value) {
        if (value.trim().isEmpty) {
          return 'please input user name!';
        }
        _userName = value;
      },
    );
  }

  Widget _buildPwd() {
    return TextFormField(
      focusNode: _pwdNode,
      obscureText: _isShowPwd,
      validator: (String value) {
        if (value.trim().isEmpty) {
          return 'please input password! ';
        }
        _password = value;
      },
      textInputAction: TextInputAction.done,
      onEditingComplete: _doLogin,
      decoration: InputDecoration(
          labelText: 'pwd',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _pwdIcomColor,
              ),
              onPressed: () {
                setState(() {
                  _isShowPwd = !_isShowPwd;
                  _pwdIcomColor = _isShowPwd
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  Widget _buildLogin() {
    return Container(
      height: 45.0,
      margin: EdgeInsets.only(top: 18, left: 8.0, right: 8.0),
      child: RaisedButton(
        onPressed: _doLogin,
        child: Text(
          'login',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildRegister() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('没有账号？'),
          GestureDetector(
            child: Text(
              '点击此登录',
              style: TextStyle(color: Colors.green),
            ),
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return RegisterPage();
              }));
            },
          )
        ],
      ),
    );
  }

  void _doLogin() async {
    _pwdNode.unfocus();
    if (_formKey.currentState.validate()) {
      var result = await Api.login(_userName, _password);
      if (result['errorCode'] == -1) {
        Toast.show(result['errorMsg'], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        AppManager.eventBus.fire(LoginEvent(_userName));
        Navigator.pop(context);
      }
    }
  }
}
