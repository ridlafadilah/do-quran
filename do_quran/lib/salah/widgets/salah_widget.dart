import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:do_quran/helper/remove_glow.dart';
import 'package:do_quran/qibla/qibla_page.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/salah_bloc.dart';

class SalahWidget extends StatefulWidget {
  SalahWidget(
      {Key key,
      this.scrollController,
      this.animationController,
      @required this.pray,
      @required this.datetime,
      @required this.location})
      : super(key: key);

  final ScrollController scrollController;
  final AnimationController animationController;
  final Pray pray;
  final DatetimePray datetime;
  final String location;

  @override
  _SalahWidgetState createState() => _SalahWidgetState();
}

class _SalahWidgetState extends State<SalahWidget> {
  double _statusBarHeight = 0.0;
  double _appBarHeight = 0.0;
  int _curTime = DatetimeUtils.timeToInt(DatetimeUtils.getTime('HH:mm'));
  String _curDate = DatetimeUtils.getTime('yyyy-MM-dd');
  bool _statusFajr = false,
      _statusDhuhr = false,
      _statusAsr = false,
      _statusMaghrib = false,
      _statusIsha = false;

  @override
  void initState() {
    int _fajr = DatetimeUtils.timeToInt(widget.datetime.times.fajr);
    int _dhuhr = DatetimeUtils.timeToInt(widget.datetime.times.dhuhr);
    int _asr = DatetimeUtils.timeToInt(widget.datetime.times.asr);
    int _maghrib = DatetimeUtils.timeToInt(widget.datetime.times.maghrib);
    int _isha = DatetimeUtils.timeToInt(widget.datetime.times.isha);
    if (_curTime >= _fajr && _curTime < _dhuhr)
      _statusDhuhr = true;
    else if (_curTime >= _dhuhr && _curTime < _asr)
      _statusAsr = true;
    else if (_curTime >= _asr && _curTime < _maghrib)
      _statusMaghrib = true;
    else if (_curTime >= _maghrib && _curTime < _isha)
      _statusIsha = true;
    else
      _statusFajr = true;
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
                collapsedHeight: 65,
                title: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.location,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            DatetimeUtils.getTime('dd MMM yyyy'),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        )
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
                      onPressed: () {
                        BlocProvider.of<SalahBloc>(context)
                            .add(const RequestedMonthEvent());
                      }),
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
                          _salahToday(TimesPrayBase.fajr,
                              widget.datetime.times.fajr, _statusFajr),
                          _salahToday(TimesPrayBase.dhuhr,
                              widget.datetime.times.dhuhr, _statusDhuhr),
                          _salahToday(TimesPrayBase.asr,
                              widget.datetime.times.asr, _statusAsr),
                          _salahToday(TimesPrayBase.maghrib,
                              widget.datetime.times.maghrib, _statusMaghrib),
                          _salahToday(TimesPrayBase.isha,
                              widget.datetime.times.isha, _statusIsha),
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
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: widget.pray.results.datetime.length,
      itemBuilder: (context, index) => AnimatedBuilder(
        animation: widget.animationController,
        builder: (BuildContext context, Widget child) {
          return Padding(
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
                      color: Theme.of(context)
                          .cardTheme
                          .shadowColor
                          .withOpacity(0.2),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 24),
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
                                      color: AppTheme.darkBlueGrey
                                          .withOpacity(0.5),
                                      size: 16,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        widget.pray.results.datetime[index].date
                                            .gregorian,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: 0.0,
                                          color: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .color,
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
                        _salahPerDate(TimesPrayBase.fajr,
                            widget.pray.results.datetime[index].times.fajr),
                        _salahPerDate(TimesPrayBase.dhuhr,
                            widget.pray.results.datetime[index].times.dhuhr),
                        _salahPerDate(TimesPrayBase.asr,
                            widget.pray.results.datetime[index].times.asr),
                        _salahPerDate(TimesPrayBase.maghrib,
                            widget.pray.results.datetime[index].times.maghrib),
                        _salahPerDate(TimesPrayBase.isha,
                            widget.pray.results.datetime[index].times.isha),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _salahPerDate(String salah, String timeSalah) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            salah,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              timeSalah,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.headline4.color,
              ),
            ),
          ),
        ],
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
