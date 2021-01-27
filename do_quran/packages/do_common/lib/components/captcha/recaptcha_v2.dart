import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecaptchaV2 extends StatefulWidget {
  RecaptchaV2({
    @required this.siteKey,
    this.pluginURL = 'https://ridlafadilah.github.io/recaptcha/',
    this.dark = false,
    this.onChanged,
  }) : assert(siteKey != null, 'Google ReCaptcha API KEY is missing.');

  final String siteKey;
  final String pluginURL;
  final bool dark;
  final ValueChanged<String> onChanged;

  @override
  State<StatefulWidget> createState() => _RecaptchaV2State();
}

class _RecaptchaV2State extends State<RecaptchaV2> {
  WebViewController webViewController;
  bool resize = false;
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
    var pluginURL = widget.pluginURL;
    return Container(
      height: resize ? 590.0 : 255.0,
      width: resize ? 330.0 : 330.0,
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
            height: resize ? 520.0 : 105.0,
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
                    height: resize ? 500.0 : 85.0,
                    width: resize ? 330.0 : 330.0,
                    color: Colors.transparent,
                    child: WebView(
                      initialUrl:
                          '$pluginURL?site_key=${widget.siteKey}&theme=$theme',
                      javascriptMode: JavascriptMode.unrestricted,
                      javascriptChannels: <JavascriptChannel>[
                        JavascriptChannel(
                          name: 'RecaptchaDongkapChannel',
                          onMessageReceived: (JavascriptMessage receiver) {
                            widget.onChanged(receiver.message);
                            Navigator.of(context).pop(true);
                            webViewController.clearCache();
                          },
                        ),
                        JavascriptChannel(
                          name: 'ResizeDongkapChannel',
                          onMessageReceived: (JavascriptMessage receiver) {
                            setState(() {
                              if (receiver.message == 'true') {
                                resize = true;
                              } else {
                                resize = false;
                              }
                            });
                          },
                        ),
                      ].toSet(),
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
