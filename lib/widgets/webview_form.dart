import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final url;

  WebViewContainer(this.url);

  @override
  createState() => _WebViewContainerState(this.url);
}

class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  final _key = UniqueKey();
  bool _isLoadingPage;

  Completer<WebViewController> _controller = Completer<WebViewController>();

  _WebViewContainerState(this._url);

  @override
  void initState() {
    super.initState();
    _isLoadingPage = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          new WebView(
            key: _key,
            initialUrl: _url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (webViewCreate) {
              _controller.complete(webViewCreate);
            },
            onPageFinished: (finish) {
              setState(() {
                _isLoadingPage = false;
              });
            },
          ),
          _isLoadingPage
              ? Container(
                  alignment: FractionalOffset.center,
                  child: CircularProgressIndicator(),
                )
              : Container(
                  color: Colors.transparent,
                ),
        ],
      ),
    );
  }
}
