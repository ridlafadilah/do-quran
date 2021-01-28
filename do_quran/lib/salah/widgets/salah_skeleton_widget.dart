import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:do_quran/helper/remove_glow.dart';
import 'package:do_quran/qibla/qibla_page.dart';
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        DatetimeUtils.getTime('dd MMM yyyy'),
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.location_searching,
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                  IconButton(
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
                ],
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF21A7FF),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Color(0xFF21A7FF),
                          offset: const Offset(0.1, 0.1),
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
              margin: EdgeInsets.only(top: _appBarHeight),
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
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primaryVariant,
      highlightColor: Theme.of(context).colorScheme.secondaryVariant,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 15,
        itemBuilder: (context, index) => InkWell(
          onTap: () {},
          child: Container(
            margin: (index == 0)
                ? EdgeInsets.all(4.0)
                : EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
            child: Card(
              elevation: 4,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        children: [
                          Text(
                            '',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      child: Divider(
                        height: 1,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _salahToday(String shalat, String time, bool status) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 16.0),
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
          Spacer(),
          Text(time,
              style: TextStyle(
                  color: (status) ? Colors.white : Colors.white70,
                  fontSize: 16.0)),
        ],
      ),
    );
  }
}
