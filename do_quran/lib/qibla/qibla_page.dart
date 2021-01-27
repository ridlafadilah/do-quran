import 'package:do_quran/generated/l10n.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:do_quran/model/quran/response_surat.dart';
import 'package:do_quran/api/api_service.dart';
import 'package:do_quran/api/api_url.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;
import 'package:permission_handler/permission_handler.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _QiblaPageState createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> with TickerProviderStateMixin {
  List<Widget> listViews = <Widget>[];
  final ScrollController _scrollController = ScrollController();
  double _topBarOpacity = 0.0;
  RefreshController _refreshCon = RefreshController();
  final ApiService _apiService = ApiService();
  List<Hasil> listHasil = [];
  var _pageLoading = true;
  bool _hasPermissions = false;
  CompassEvent _lastRead;
  DateTime _lastReadAt;

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
    checkPermission();
    super.initState();
  }

  void checkPermission() async {
    if (await Permission.locationWhenInUse.isGranted) {
      setState(() {
        _hasPermissions = true;
      });
    }
  }

  Future<bool> getData() async {
    _refreshCon.refreshToIdle();
    await _apiService.get(
        url: ApiUrl.surat,
        headers: {},
        callback: (status, message, response) {
          setState(() {
            _refreshCon.refreshCompleted();
            _pageLoading = false;

            if (listHasil.isNotEmpty) listHasil.clear();
            if (status) {
              ResponseSurat resSurat = ResponseSurat.fromJson(response);
              listHasil = resSurat.hasil;
            }
          });
          return;
        });
    return true;
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
    return Builder(builder: (context) {
      if (_hasPermissions) {
        return Column(
          children: <Widget>[
            _buildManualReader(),
            Expanded(child: _buildCompass()),
          ],
        );
      } else {
        return _buildPermissionSheet();
      }
    });
  }

  Widget _buildManualReader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          OutlineButton(
            child: Text('Lihat koordinat'),
            onPressed: () async {
              final CompassEvent tmp = await FlutterCompass.events.first;
              setState(() {
                _lastRead = tmp;
                _lastReadAt = DateTime.now();
              });
            },
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '$_lastRead',
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  '${_lastReadAt ?? 'No Data'}',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return Center(
            child: Container(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(),
            ),
          );
        }

        double direction = snapshot.data.heading;

        return Container(
          alignment: Alignment.center,
          child: Transform.rotate(
            angle: ((direction ?? 0) * (math.pi / 180) * -1),
            child: Image.asset('assets/images/compass.png'),
          ),
        );
      },
    );
  }

  Widget _buildPermissionSheet() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Spacer(),
          Text('Location Permission Required'),
          Spacer(),
          SizedBox(
            width: double.infinity,
            child: OutlineButton(
              child: Text('Request Permissions'),
              onPressed: () async {
                await Permission.locationWhenInUse
                    .request()
                    .isGranted
                    .then((value) {
                  setState(() {
                    _hasPermissions = value;
                  });
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    return DongkapAppBar(
      animationController: widget.animationController,
      topBarOpacity: _topBarOpacity,
      title: DongkapLocalizations.of(context).qibla,
    );
  }
}
