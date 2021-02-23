import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:do_quran/helper/remove_glow.dart';
import 'package:do_quran/qibla/qibla_page.dart';
import 'package:do_quran/salah/bloc/salah_bloc.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  final int _curTime = DatetimeUtils.timeToInt(DatetimeUtils.getTime('HH:mm'));
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
                expandedHeight: 260,
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
                          style: TextStyle(
                              color: Theme.of(context).appBarTheme.color,
                              fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            DatetimeUtils.getTime('dd MMM yyyy'),
                            style: TextStyle(
                                color: Theme.of(context).appBarTheme.color,
                                fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/location.svg',
                        color: Theme.of(context).appBarTheme.color,
                      ),
                      onPressed: () {
                        BlocProvider.of<SalahBloc>(context)
                            .add(const RequestedMonthEvent());
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 10.0, 0.0),
                    child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/eva_icons/outline/svg/compass-outline.svg',
                          color: Theme.of(context).appBarTheme.color,
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
                    color: AppTheme.colorTheme,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.colorTheme,
                          offset: Offset(0.1, 0.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: FlexibleSpaceBar(
                    background: Container(
                      padding: EdgeInsets.only(
                          top: _statusBarHeight + _appBarHeight + 16.0,
                          left: 35.0,
                          right: 35.0),
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
              margin: EdgeInsets.only(top: _appBarHeight + 15, bottom: 15),
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
      itemCount: widget.pray.results.datetime.length,
      itemBuilder: (context, index) => AnimatedBuilder(
        animation: widget.animationController,
        builder: (BuildContext context, Widget child) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
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
                        const EdgeInsets.only(left: 16, right: 16, top: 13),
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/eva_icons/outline/svg/calendar-outline.svg',
                          color: Theme.of(context)
                              .iconTheme
                              .color
                              .withOpacity(0.7),
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            widget.pray.results.datetime[index].date.gregorian,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              letterSpacing: 0.0,
                              color:
                                  Theme.of(context).textTheme.headline1.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 13),
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerTheme.color,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 10, bottom: 10),
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
            padding: const EdgeInsets.only(top: 6, bottom: 5),
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
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.access_time,
              color: (status)
                  ? Theme.of(context).appBarTheme.color
                  : Theme.of(context).appBarTheme.color.withOpacity(0.8),
              size: 16.0,
            ),
          ),
          Text(shalat,
              style: TextStyle(
                  fontWeight: (status) ? FontWeight.w600 : FontWeight.normal,
                  color: (status)
                      ? Theme.of(context).appBarTheme.color
                      : Theme.of(context).appBarTheme.color.withOpacity(0.8),
                  fontSize: 16.0)),
          const Spacer(),
          Text(time,
              style: TextStyle(
                  fontWeight: (status) ? FontWeight.w600 : FontWeight.normal,
                  color: (status)
                      ? Theme.of(context).appBarTheme.color
                      : Theme.of(context).appBarTheme.color.withOpacity(0.8),
                  fontSize: 16.0)),
        ],
      ),
    );
  }
}
