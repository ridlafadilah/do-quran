import 'package:do_quran/patch/bloc/patch_bloc.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String status = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatchBloc, PatchState>(
      listener: (context, state) async {
        if (state is RequestInProgressState) {
          setState(() {
            status = 'Downloading ${state.status}';
          });
        }
      },
      child: Container(
        color: const Color(0xFF21A7FF),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/images/alquran_splash.svg',
                  color: Colors.white,
                  height: 100.0,
                  width: 100.0,
                ),
              ),
              Align(
                alignment: const Alignment(0, 0.85),
                heightFactor: 150,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    status,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, 0.85),
                heightFactor: 150,
                child: JumpingDotsProgressIndicator(
                  fontSize: 32.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
