import 'package:do_core/models.dart';
import 'package:do_quran/models/assets.dart';
import 'package:do_quran/quran/surah_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuranWidget extends StatefulWidget {
  QuranWidget(
      {Key key,
      this.scrollController,
      this.animationController,
      @required this.quranInfo})
      : super(key: key);

  final ScrollController scrollController;
  final AnimationController animationController;
  final List<QuranInfo> quranInfo;

  @override
  _QuranWidgetState createState() => _QuranWidgetState();
}

class _QuranWidgetState extends State<QuranWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.scrollController,
      padding: EdgeInsets.only(
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: widget.quranInfo.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => SurahPage(
                  animationController: widget.animationController,
                  quranInfo: widget.quranInfo[index],
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.quranInfo[index].latin,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      '''
${widget.quranInfo[index].translationIndonesia} | ${widget.quranInfo[index].ayahCount} ayat''',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 2,
                    )
                  ],
                ),
                Spacer(),
                SvgPicture.asset(
                  Assets.imagesSurah[index],
                  height: 32.0,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
