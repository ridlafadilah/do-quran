import 'dart:convert';

import 'package:do_core/models.dart';
import 'package:flutter/material.dart';

class SurahWidget extends StatefulWidget {
  SurahWidget(
      {Key key,
      this.scrollController,
      this.animationController,
      @required this.surah})
      : super(key: key);

  final ScrollController scrollController;
  final AnimationController animationController;
  final Surah surah;

  @override
  _SurahWidgetState createState() => _SurahWidgetState();
}

class _SurahWidgetState extends State<SurahWidget> {
  @override
  void initState() {
    super.initState();
  }

  String convertUtf8(String data) {
    var varData = data.codeUnits;
    return utf8.decode(varData);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.scrollController,
      padding: EdgeInsets.only(
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: widget.surah.text.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        String key = widget.surah.text.keys.elementAt(index);
        return InkWell(
          onTap: () {},
          child: Container(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '${widget.surah.text[key]}',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    wordSpacing: 2.0,
                  ),
                ),
                Text(
                  widget.surah.translations.id.text[key],
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    wordSpacing: 2.0,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
