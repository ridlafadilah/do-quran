import 'package:do_common/common.dart';
import 'package:do_quran/bookmarks/bloc/bookmarks_bloc.dart';
import 'package:do_quran/bookmarks/widgets/bookmarks_skeleton_widget.dart';
import 'package:do_quran/bookmarks/widgets/bookmarks_widget.dart';
import 'package:do_quran/generated/l10n.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage>
    with TickerProviderStateMixin {
  List<Widget> listViews = <Widget>[];

  @override
  void initState() {
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
      ),
    );
  }

  Widget mainView() {
    return BlocProvider(
      create: (context) {
        return BookmarksBloc()..add(const RequestedMonthEvent());
      },
      child: BlocBuilder<BookmarksBloc, BookmarksState>(
        builder: (BuildContext context, BookmarksState state) {
          return BookmarksWidget();
        },
      ),
    );
  }

  Widget appBar() {
    return DongkapAppBar(
      animationController: widget.animationController,
      topBarOpacity: 0.0,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
            child: Text(
              DongkapLocalizations.of(context).bookmarks,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15 + 6 - 2 * 0.0,
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
      ],
    );
  }
}
