import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  final data;

  WebViewPage(this.data);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  FlutterWebviewPlugin _flutterWebViewPlugin;
  bool isLoad = true;

  @override
  void initState() {
    super.initState();
    _flutterWebViewPlugin = new FlutterWebviewPlugin();
    _flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoad = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoad = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(widget.data['title']),
        bottom: PreferredSize(
            child: const LinearProgressIndicator(),
            preferredSize: const Size.fromHeight(1.0)),
        bottomOpacity: isLoad ? 1.0 : 0.0,
      ),
      withLocalStorage: true,
      url: widget.data['url'],
      withJavascript: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _flutterWebViewPlugin.dispose();
  }
}
