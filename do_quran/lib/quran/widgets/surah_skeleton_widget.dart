import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SurahSkeletonWidget extends StatefulWidget {
  @override
  _SurahSkeletonWidgetState createState() => _SurahSkeletonWidgetState();
}

class _SurahSkeletonWidgetState extends State<SurahSkeletonWidget> {
  final Random random = Random();
  final int itemCount = 9;
  final double heightLeading = 40.0;
  final double widthLeading = 90.0;
  final double heightTitle = 22.0;
  final double heightSubtitle = 22.0;
  final EdgeInsets marginTitle = const EdgeInsets.only(bottom: 7.0);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primaryVariant,
      highlightColor: Theme.of(context).colorScheme.secondaryVariant,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: itemCount,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          double widthTitle =
              double.parse('${(random.nextInt(10) * 10) + 200}');
          double widthSubtitle =
              double.parse('${(random.nextInt(10) * 10) + 200}');
          return Container(
            margin: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: widthTitle,
                      height: heightTitle,
                      color: Colors.white,
                      margin: marginTitle,
                    ),
                    Container(
                      width: widthSubtitle,
                      height: heightSubtitle,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
