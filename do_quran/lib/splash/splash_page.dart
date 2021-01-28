import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF21A7FF),
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
              alignment: Alignment(0, 0.85),
              child: JumpingDotsProgressIndicator(
                fontSize: 32.0,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
