import 'package:do_common/common.dart';
import 'package:do_quran/generated/l10n.dart';
import 'package:do_quran/salah/bloc/salah_bloc.dart';
import 'package:do_quran/salah/widgets/salah_skeleton_widget.dart';
import 'package:do_quran/salah/widgets/salah_widget.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalahPage extends StatefulWidget {
  const SalahPage({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _SalahPageState createState() => _SalahPageState();
}

class _SalahPageState extends State<SalahPage> with TickerProviderStateMixin {
  List<Widget> listViews = <Widget>[];
  final ScrollController _scrollController = ScrollController();
  double _topBarOpacity = 0.0;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset >= 170) {
        if (_topBarOpacity != 1.0) {
          setState(() {
            _topBarOpacity = 1.0;
          });
        }
      } else if (_scrollController.offset <= 170 &&
          _scrollController.offset >= 0) {
        if (_topBarOpacity != _scrollController.offset / 170) {
          setState(() {
            _topBarOpacity = _scrollController.offset / 170;
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
      child: BlocProvider(
        create: (context) {
          return SalahBloc()..add(RequestedMonthEvent());
        },
        child: BlocBuilder<SalahBloc, SalahState>(
          builder: (BuildContext context, SalahState state) {
            if (state is RequestSuccessMonthState) {
              return RefreshIndicator(
                backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
                color: AppTheme.colorTheme,
                strokeWidth: 3,
                child: SalahWidget(
                  scrollController: _scrollController,
                  animationController: widget.animationController,
                  pray: state.pray,
                  datetime: state.datetime,
                  location: state.location,
                ),
                onRefresh: () async {
                  context.read<SalahBloc>().add(const RequestedMonthEvent());
                },
              );
            } else if (state is RequestFailureMonthState) {
              return ConnectionErrorWidget(
                  error: DongkapLocalizations.of(context).ERR_LOAD_FILE,
                  retryButton: DongkapLocalizations.of(context).retry,
                  onPressed: () async {
                    context.read<SalahBloc>().add(const RequestedMonthEvent());
                  });
            } else {
              return SalahSkeletonWidget();
            }
          },
        ),
      ),
    );
  }
}
