import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class QuranSkeletonWidget extends StatefulWidget {
  @override
  _QuranSkeletonWidgetState createState() => _QuranSkeletonWidgetState();
}

class _QuranSkeletonWidgetState extends State<QuranSkeletonWidget> {
  final int itemCount = 9;
  final double heightLeading = 40.0;
  final double widthLeading = 90.0;
  final double heightTitle = 14.0;
  final double widthTitle = 100.0;
  final double heightSubtitle = 12.0;
  final double widthSubtitle = 200.0;
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
          return Container(
            margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      height: 14,
                      color: Colors.white,
                    ),
                  ],
                ),
                Container(
                  width: widthLeading,
                  height: heightLeading,
                  decoration: const BoxDecoration(color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
