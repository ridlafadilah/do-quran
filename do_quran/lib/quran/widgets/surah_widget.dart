import 'dart:convert';

import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final String openingAyah = 'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ';
  final bool isOpeningAyah = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.itemScrollController.isAttached) {
        if (widget.ayat > 5) {
          widget.itemScrollController.scrollTo(
              index: widget.ayat - 1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic);
        }
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
    int numberSurah = int.parse(widget.surah.number);
    return ScrollablePositionedList.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        bottom: 15 + MediaQuery.of(context).padding.bottom,
      ),
      scrollDirection: Axis.vertical,
      itemCount: widget.surah.text.length,
      itemScrollController: widget.itemScrollController,
      itemPositionsListener: widget.itemPositionsListener,
      itemBuilder: (BuildContext context, int index) {
        String key = widget.surah.text.keys.elementAt(index);
        if (numberSurah > 1 && index < 1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Text(
                  openingAyah,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).textTheme.headline1.color,
                    fontWeight: FontWeight.normal,
                    wordSpacing: 2.0,
                  ),
                ),
              ),
              surahWidget(key: key),
            ],
          );
        } else {
          return surahWidget(key: key);
        }
      },
    );
  }

  Widget surahWidget({String key}) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RichText(
              softWrap: true,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${widget.surah.text[key]}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Theme.of(context).textTheme.headline1.color,
                      fontWeight: FontWeight.normal,
                      wordSpacing: 2.0,
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: SvgPicture.asset(
                              'assets/icons/separator.svg',
                              color:
                                  Theme.of(context).appBarTheme.iconTheme.color,
                              height: 40,
                            ),
                          ),
                          Container(
                            width: 30,
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                            child: Text(
                              StringUtils.toFarsi(key),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                                color:
                                    Theme.of(context).textTheme.headline1.color,
                                fontWeight: FontWeight.normal,
                                wordSpacing: 2.0,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${widget.surah.translations.id.text[key]} ($key)',
              style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).textTheme.bodyText1.color,
                fontWeight: FontWeight.normal,
                wordSpacing: 2.0,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
