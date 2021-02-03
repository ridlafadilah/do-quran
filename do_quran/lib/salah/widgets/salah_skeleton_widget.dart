import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:do_quran/helper/remove_glow.dart';
import 'package:do_quran/qibla/qibla_page.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class SalahSkeletonWidget extends StatefulWidget {
  SalahSkeletonWidget(
      {Key key, this.scrollController, this.animationController})
      : super(key: key);

  final ScrollController scrollController;
  final AnimationController animationController;

  @override
  _SalahSkeletonWidgetState createState() => _SalahSkeletonWidgetState();
}

class _SalahSkeletonWidgetState extends State<SalahSkeletonWidget> {
  double _statusBarHeight = 0.0;
  double _appBarHeight = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _statusBarHeight = MediaQuery.of(context).padding.top;
    _appBarHeight = AppBar().preferredSize.height;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, scrolling) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                pinned: true,
                expandedHeight: 240,
                forceElevated: scrolling,
                collapsedHeight: 60,
                title: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            DatetimeUtils.getTime('dd MMM yyyy'),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/location.svg',
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/eva_icons/outline/svg/compass-outline.svg',
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => QiblaPage(
                                  animationController:
                                      widget.animationController),
                            ),
                          );
                        }),
                  ),
                ],
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF21A7FF),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Color(0xFF21A7FF),
                          offset: Offset(0.1, 0.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: FlexibleSpaceBar(
                    background: Container(
                      padding: EdgeInsets.only(
                          top: _statusBarHeight + _appBarHeight + 16.0,
                          left: 16.0,
                          right: 16.0),
                      child: Column(
                        children: [
                          _salahToday(TimesPrayBase.fajr, '--:--', false),
                          _salahToday(TimesPrayBase.dhuhr, '--:--', false),
                          _salahToday(TimesPrayBase.asr, '--:--', false),
                          _salahToday(TimesPrayBase.maghrib, '--:--', false),
                          _salahToday(TimesPrayBase.isha, '--:--', false),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ];
        },
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: _appBarHeight - 5),
              child: ScrollConfiguration(
                behavior: RemoveGlow(),
                child: mainView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainView() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: 15,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(40.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color:
                      Theme.of(context).cardTheme.shadowColor.withOpacity(0.2),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.calendar_today,
                                  color: AppTheme.darkBlueGrey.withOpacity(0.5),
                                  size: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, left: 4.0),
                                  child: Shimmer.fromColors(
                                    baseColor: Theme.of(context)
                                        .colorScheme
                                        .primaryVariant,
                                    highlightColor: Theme.of(context)
                                        .colorScheme
                                        .secondaryVariant,
                                    child: Container(
                                      color: Colors.white,
                                      width: 100.0,
                                      height: 15.0,
                                      child: const Text(''),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 8),
                child: Container(
                  height: 2,
                  decoration: const BoxDecoration(
                    color: AppTheme.lightBlueGrey,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 16),
                child: Row(
                  children: <Widget>[
                    _salahPerDate(),
                    _salahPerDate(),
                    _salahPerDate(),
                    _salahPerDate(),
                    _salahPerDate(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _salahPerDate() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.primaryVariant,
              highlightColor: Theme.of(context).colorScheme.secondaryVariant,
              child: Container(
                color: Colors.white,
                width: 50.0,
                height: 15.0,
                child: const Text(''),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.primaryVariant,
              highlightColor: Theme.of(context).colorScheme.secondaryVariant,
              child: Container(
                color: Colors.white,
                width: 50.0,
                height: 15.0,
                child: const Text(''),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _salahToday(String shalat, String time, bool status) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.access_time,
              color: (status) ? Colors.white : Colors.white70,
              size: 16.0,
            ),
          ),
          Text(shalat,
              style: TextStyle(
                  color: (status) ? Colors.white : Colors.white70,
                  fontSize: 16.0)),
          const Spacer(),
          Text(time,
              style: TextStyle(
                  color: (status) ? Colors.white : Colors.white70,
                  fontSize: 16.0)),
        ],
      ),
    );
  }
}
