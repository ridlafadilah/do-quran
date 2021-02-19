import 'package:do_common/common.dart';
import 'package:do_core/models.dart';
import 'package:do_quran/generated/l10n.dart';
import 'package:do_quran/quran/bloc/surah_bloc.dart';
import 'package:do_quran/quran/widgets/surah_skeleton_widget.dart';
import 'package:do_quran/quran/widgets/surah_widget.dart';
import 'package:do_quran/theme/bloc/thememode_bloc.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SurahPage extends StatefulWidget {
  const SurahPage(
      {Key key, this.animationController, this.quranInfo, this.ayat = 1})
      : super(key: key);

  final AnimationController animationController;
  final QuranInfo quranInfo;
  final int ayat;

  @override
  _SurahPageState createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> with TickerProviderStateMixin {
  double _topBarOpacity = 0.0;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  String surahName;
  int surahIndex = 0;
  int totalAyah = 0;
  bool isPinnedAyah = false;
  bool isLastAyah = false;
  bool clearAll = false;

  @override
  void initState() {
    surahName = widget.quranInfo.latin;
    surahIndex = widget.quranInfo.index;
    totalAyah = widget.quranInfo.ayahCount;
    itemPositionsListener.itemPositions.addListener(() {
      ItemPosition position = itemPositionsListener.itemPositions.value
          .firstWhere((element) => element.index == 0, orElse: () => null);
      if (position != null) {
        double val = position.itemLeadingEdge == 0.0
            ? position.itemLeadingEdge
            : -position.itemLeadingEdge * 1000;
        if (val >= 24) {
          if (_topBarOpacity != 1.0) {
            setState(() {
              _topBarOpacity = 1.0;
            });
          }
        } else if (val <= 24 && val >= 0) {
          if (_topBarOpacity != val / 24) {
            setState(() {
              _topBarOpacity = val / 24;
            });
          }
        } else if (val <= 0) {
          if (_topBarOpacity != 0.0) {
            setState(() {
              _topBarOpacity = 0.0;
            });
          }
        }
      } else {
        if (_topBarOpacity != 1.0) {
          setState(() {
            _topBarOpacity = 1.0;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar: appBar(),
        body: Stack(
          children: <Widget>[
            mainView(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget mainView() {
    return BlocProvider(
      create: (context) {
        return SurahBloc()..add(RequestedEvent(numberOfSurah: surahIndex));
      },
      child: BlocBuilder<SurahBloc, SurahState>(
        builder: (BuildContext context, SurahState state) {
          if (state is RequestSuccessState) {
            surahName = state.surah.nameLatin;
            surahIndex = int.parse(state.surah.number);
            totalAyah = int.parse(state.surah.numberOfAyah);
            int posAyah = widget.ayat;
            return SurahWidget(
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              animationController: widget.animationController,
              surah: state.surah,
              ayat: posAyah,
              clearAll: clearAll,
              onTapAyah: (marks) {
                if (marks.isNotEmpty) {
                  if (marks.length == 1) {
                    setState(() {
                      isLastAyah = true;
                      isPinnedAyah = true;
                    });
                  } else {
                    setState(() {
                      isLastAyah = false;
                      isPinnedAyah = true;
                    });
                  }
                } else {
                  setState(() {
                    isLastAyah = false;
                    isPinnedAyah = false;
                  });
                }
              },
            );
          } else if (state is RequestFailureState) {
            return ConnectionErrorWidget(
                error: DongkapLocalizations.of(context).ERR_LOAD_FILE,
                retryButton: DongkapLocalizations.of(context).retry,
                onPressed: () async {
                  context.read<SurahBloc>().add(const RequestedEvent());
                });
          } else {
            return SurahSkeletonWidget();
          }
        },
      ),
    );
  }

  Widget appBar() {
    return DongkapAppBar(
      animationController: widget.animationController,
      topBarOpacity: _topBarOpacity,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 0.0),
          child: SizedBox(
            height: 40,
            width: 40,
            child: InkWell(
              highlightColor: AppTheme.darkBlueGrey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              onTap: () {
                Navigator.of(context).pop(true);
              },
              child: Center(
                child: SvgPicture.asset(
                  'assets/eva_icons/outline/svg/arrow-back-outline.svg',
                  color: Theme.of(context).appBarTheme.iconTheme.color,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
            child: Text(
              surahName,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15 + 6 - 2 * _topBarOpacity,
                color: Theme.of(context).appBarTheme.titleTextStyle.color,
                fontFamily:
                    Theme.of(context).appBarTheme.titleTextStyle.fontFamily,
                fontWeight:
                    Theme.of(context).appBarTheme.titleTextStyle.fontWeight,
                letterSpacing:
                    Theme.of(context).appBarTheme.titleTextStyle.letterSpacing,
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: isLastAyah ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: Visibility(
            visible: isLastAyah,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 0.0),
              child: SizedBox(
                height: 40,
                width: 40,
                child: InkWell(
                  highlightColor: AppTheme.darkGrey.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  onTap: () {},
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/eva_icons/outline/svg/book-open-outline.svg',
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: isPinnedAyah ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: Visibility(
            visible: isPinnedAyah,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 0.0),
              child: SizedBox(
                height: 40,
                width: 40,
                child: InkWell(
                  highlightColor: AppTheme.darkGrey.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  onTap: () {},
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/eva_icons/outline/svg/bookmark-outline.svg',
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: isPinnedAyah ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: Visibility(
            visible: isPinnedAyah,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
              child: SizedBox(
                height: 40,
                width: 40,
                child: InkWell(
                  highlightColor: AppTheme.darkGrey.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  onTap: () {
                    setState(() {
                      isPinnedAyah = false;
                      isLastAyah = false;
                      clearAll = true;
                    });
                  },
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/eva_icons/outline/svg/close-outline.svg',
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
