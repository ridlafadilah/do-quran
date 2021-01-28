import 'package:do_common/common.dart';
import 'package:do_quran/generated/l10n.dart';
import 'package:do_quran/quran/bloc/quran_bloc.dart';
import 'package:do_quran/quran/widgets/quran_search_widget.dart';
import 'package:do_quran/quran/widgets/quran_skeleton_widget.dart';
import 'package:do_quran/quran/widgets/quran_widget.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> with TickerProviderStateMixin {
  List<Widget> listViews = <Widget>[];
  final ScrollController _scrollController = ScrollController();
  double _topBarOpacity = 0.0;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset >= 24) {
        if (_topBarOpacity != 1.0) {
          setState(() {
            _topBarOpacity = 1.0;
          });
        }
      } else if (_scrollController.offset <= 24 &&
          _scrollController.offset >= 0) {
        if (_topBarOpacity != _scrollController.offset / 24) {
          setState(() {
            _topBarOpacity = _scrollController.offset / 24;
          });
        }
      } else if (_scrollController.offset <= 0) {
        if (_topBarOpacity != 0.0) {
          setState(() {
            _topBarOpacity = 0.0;
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
                    'assets/eva_icons/fill/svg/book-open.svg',
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
        return QuranBloc()..add(RequestedEvent());
      },
      child: BlocBuilder<QuranBloc, QuranState>(
        builder: (BuildContext context, QuranState state) {
          if (state is RequestSuccessState) {
            return RefreshIndicator(
              backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
              color: AppTheme.colorTheme,
              strokeWidth: 3,
              child: QuranWidget(
                  scrollController: _scrollController,
                  animationController: widget.animationController,
                  quranInfo: state.quran),
              onRefresh: () async {
                context.read<QuranBloc>().add(const RequestedEvent());
              },
            );
          } else if (state is RequestFailureState) {
            return ConnectionErrorWidget(
                error: DongkapLocalizations.of(context).ERR_LOAD_FILE,
                retryButton: DongkapLocalizations.of(context).retry,
                onPressed: () async {
                  context.read<QuranBloc>().add(const RequestedEvent());
                });
          } else {
            return QuranSkeletonWidget();
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
              DongkapLocalizations.of(context).alquran,
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
              onTap: () {
                _searchQuran(context);
              },
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

  void _searchQuran(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Center(
          child: QuranSearchWidget(
            title: DongkapLocalizations.of(context).promptSearchQuranTitle,
            descriptions:
                DongkapLocalizations.of(context).promptSearchQuranDescription,
          ),
        );
      },
    );
  }
}
