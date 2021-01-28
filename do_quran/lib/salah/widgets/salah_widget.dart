import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:do_quran/helper/remove_glow.dart';
import 'package:do_quran/qibla/qibla_page.dart';
import 'package:flutter/material.dart';
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
                collapsedHeight: 60,
                title: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.location,
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
                          widget.pray.results.datetime[index].date.gregorian,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: (widget.pray.results.datetime[index].date
                                          .gregorian ==
                                      _curDate)
                                  ? Color(0xFF21A7FF)
                                  : Colors.black),
                        ),
                        Spacer(),
                        Visibility(
                          visible: (widget.pray.results.datetime[index].date
                                      .gregorian ==
                                  _curDate)
                              ? true
                              : false,
                          child: Text(
                            'Hari ini',
                            style: TextStyle(
                                fontSize: 14.0, color: Color(0xFF21A7FF)),
                          ),
                        ),
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
                  Row(
                    children: [
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _salahPerDate(String dateSalah, String timeSalah) {
    return Flexible(
      flex: 1,
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              dateSalah,
              style: TextStyle(fontSize: 12.0, color: Colors.black),
            ),
            Text(
              timeSalah,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ],
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
