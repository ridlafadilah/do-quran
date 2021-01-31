import 'package:do_common/common.dart';
import 'package:do_core/models.dart';
import 'package:do_quran/generated/l10n.dart';
import 'package:do_quran/quran/bloc/surah_bloc.dart';
import 'package:do_quran/quran/widgets/surah_skeleton_widget.dart';
import 'package:do_quran/quran/widgets/surah_widget.dart';
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

  @override
  void initState() {
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
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 70.0, right: 25.0),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  heroTag: 'btnQuran',
                  backgroundColor: Theme.of(context)
                      .floatingActionButtonTheme
                      .foregroundColor,
                  child: SvgPicture.asset(
                    'assets/eva_icons/fill/svg/book.svg',
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget mainView() {
    return BlocProvider(
      create: (context) {
        return SurahBloc()
          ..add(RequestedEvent(numberOfSurah: widget.quranInfo.index));
      },
      child: BlocBuilder<SurahBloc, SurahState>(
        builder: (BuildContext context, SurahState state) {
          if (state is RequestSuccessState) {
            return SurahWidget(
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              animationController: widget.animationController,
              surah: state.surah,
              ayat: widget.ayat,
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.quranInfo.latin,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 22 + 6 - 6 * _topBarOpacity,
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
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            height: 40,
            child: RollingSwitch(
              value: true,
              colorIconOn: Colors.transparent,
              colorIconOff: Colors.transparent,
              iconOn: SvgPicture.asset('assets/eva_icons/fill/svg/sun.svg',
                  color: AppTheme.darkColor),
              iconOff: SvgPicture.asset(
                'assets/eva_icons/fill/svg/moon.svg',
                color: AppTheme.lightColor,
              ),
              textSize: 16.0,
              onChanged: (bool state) {
                print('$state');
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            height: 40,
            width: 40,
            child: InkWell(
              highlightColor: AppTheme.darkGrey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              onTap: () {},
              child: Center(
                child: SvgPicture.asset(
                  'assets/eva_icons/outline/svg/search-outline.svg',
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
