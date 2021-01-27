import 'package:do_quran/main/tab_navigator.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MainLayout());
  }

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/eva_icons/outline/svg/book-outline.svg',
      selectedImagePath: 'assets/eva_icons/fill/svg/book.svg',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/eva_icons/outline/svg/bookmark-outline.svg',
      selectedImagePath: 'assets/eva_icons/fill/svg/bookmark.svg',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/eva_icons/outline/svg/clock-outline.svg',
      selectedImagePath: 'assets/eva_icons/fill/svg/clock.svg',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/eva_icons/outline/svg/person-outline.svg',
      selectedImagePath: 'assets/eva_icons/fill/svg/person.svg',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];

  Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
    TabNavigatorRoutes.quran: GlobalKey<NavigatorState>(),
    TabNavigatorRoutes.bookmarks: GlobalKey<NavigatorState>(),
    TabNavigatorRoutes.prayer: GlobalKey<NavigatorState>(),
    TabNavigatorRoutes.profile: GlobalKey<NavigatorState>(),
  };

  String currentTab = TabNavigatorRoutes.quran;

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 50), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            TabNavigator(
              navigatorKey: navigatorKeys[currentTab],
              animationController: animationController,
              tab: currentTab,
            )
          ],
        ),
        bottomNavigationBar: bottomNavigation(),
        extendBody: true,
      ),
    );
  }

  Widget bottomNavigation() {
    return DongkapBottomBar(
      tabIconsList: tabIconsList,
      addClick: () {},
      changeIndex: (int index) {
        switch (index) {
          case 0:
            animationController.reverse().then<dynamic>((data) {
              if (!mounted) {
                return;
              }
              setState(() {
                currentTab = TabNavigatorRoutes.quran;
              });
            });
            break;
          case 1:
            animationController.reverse().then<dynamic>((data) {
              if (!mounted) {
                return;
              }
              setState(() {
                currentTab = TabNavigatorRoutes.bookmarks;
              });
            });
            break;
          case 2:
            animationController.reverse().then<dynamic>((data) {
              if (!mounted) {
                return;
              }
              setState(() {
                currentTab = TabNavigatorRoutes.prayer;
              });
            });
            break;
          case 3:
            animationController.reverse().then<dynamic>((data) {
              if (!mounted) {
                return;
              }
              setState(() {
                currentTab = TabNavigatorRoutes.profile;
              });
            });
            break;
          default:
        }
      },
    );
  }
}
