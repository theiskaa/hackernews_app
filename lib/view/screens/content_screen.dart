import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContentScreen extends StatefulWidget {
  final String url;
  ContentScreen({@required this.url});
  @override
  ContentScreenState createState() => ContentScreenState();
}

class ContentScreenState extends State<ContentScreen> {
  Completer<WebViewController> _controller;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    _controller =
    Completer<WebViewController>();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.url}".replaceAll("https://", "").replaceAll("http://", ""),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFF6600),
        elevation: 0,
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        gestureNavigationEnabled: true,
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith( widget.url)) {
            print('navigate');
            return NavigationDecision.navigate;
          }
          print('prevent');
          return NavigationDecision.prevent;
        },
      ),
    );
  }
}
