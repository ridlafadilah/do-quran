import 'package:do_quran/bookmarks/bookmarks_page.dart';
import 'package:do_quran/salah/salah_page.dart';
import 'package:do_quran/quran/quran_page.dart';
import 'package:flutter/material.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String quran = '/quran';
  static const String bookmarks = '/bookmarks';
  static const String prayer = '/prayer';
  static const String profile = '/profile';
}

class TabNavigator extends StatefulWidget {
  TabNavigator({this.navigatorKey, this.tab, this.animationController});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tab;
  final AnimationController animationController;

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      TabNavigatorRoutes.root: (context) =>
          QuranPage(animationController: widget.animationController),
      TabNavigatorRoutes.quran: (context) =>
          QuranPage(animationController: widget.animationController),
      TabNavigatorRoutes.bookmarks: (context) =>
          BookmarksPage(animationController: widget.animationController),
      TabNavigatorRoutes.prayer: (context) =>
          SalahPage(animationController: widget.animationController),
      TabNavigatorRoutes.profile: (context) =>
          QuranPage(animationController: widget.animationController),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: widget.navigatorKey,
      initialRoute: widget.tab,
      onGenerateRoute: (routeSettings) {
        if (widget.tab == routeSettings.name) {
          return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) =>
                routeBuilders[routeSettings.name](context),
          );
        }
        return null;
      },
    );
  }

  NavigatorState getNavigatorState() {
    return Navigator.of(context);
  }
}
