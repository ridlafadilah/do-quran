import 'dart:convert';

import 'package:do_core/models.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SurahWidget extends StatefulWidget {
  SurahWidget(
      {Key key,
      this.itemScrollController,
      this.itemPositionsListener,
      this.animationController,
      @required this.surah,
      this.ayat = 1})
      : super(key: key);

  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;
  final AnimationController animationController;
  final Surah surah;
  final int ayat;

  @override
  _SurahWidgetState createState() => _SurahWidgetState();
}

class _SurahWidgetState extends State<SurahWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.ayat > 1) {
        widget.itemScrollController.scrollTo(
            index: widget.ayat - 1,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic);
      }
    });
    super.initState();
  }

  String convertUtf8(String data) {
    var varData = data.codeUnits;
    return utf8.decode(varData);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemCount: widget.surah.text.length,
      itemScrollController: widget.itemScrollController,
      itemPositionsListener: widget.itemPositionsListener,
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
                  '${widget.surah.translations.id.text[key]} ($key)',
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
