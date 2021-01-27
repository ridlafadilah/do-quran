import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TermsWeb extends StatefulWidget {
  TermsWeb({
    @required this.url,
    this.dark = false,
  });

  final String url;
  final bool dark;

  @override
  State<StatefulWidget> createState() => _TermsWebState();
}

class _TermsWebState extends State<TermsWeb> {
  WebViewController webViewController;
  String theme = 'light';

  @override
  void initState() {
    if (widget.dark) {
      theme = 'dark';
    } else {
      theme = 'light';
    }
    if (webViewController != null) {
      webViewController.clearCache();
      webViewController.reload();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 590.0,
      width: 330.0,
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70,
              width: 70,
              padding: const EdgeInsets.only(bottom: 15),
              child: FloatingActionButton(
                backgroundColor: widget.dark
                    ? const Color(0xFF222222)
                    : const Color(0xFFF9F9F9),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                elevation: 0.0,
                highlightElevation: 0.0,
                child: SvgPicture.asset(
                    'assets/eva_icons/outline/svg/close-outline.svg',
                    height: 35.0,
                    width: 35.0,
                    color: Theme.of(context).iconTheme.color),
              ),
            ),
          ),
          Container(
            height: 520.0,
            color: Colors.transparent,
            child: Card(
              color: widget.dark
                  ? const Color(0xFF222222)
                  : const Color(0xFFF9F9F9),
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              borderOnForeground: true,
              elevation: 0,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  Container(
                    height: 500.0,
                    width: 330.0,
                    color: Colors.transparent,
                    child: WebView(
                      initialUrl: '${widget.url}?theme=$theme',
                      onWebViewCreated: (_controller) {
                        webViewController = _controller;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
