import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonRound extends StatefulWidget {
  const SkeletonRound(
      {Key key,
      this.height = 100,
      this.width = 100,
      this.margin = const EdgeInsets.only(top: 4)})
      : super(key: key);

  final double height;
  final double width;
  final EdgeInsets margin;

  @override
  createState() => SkeletonRoundState();
}

class SkeletonRoundState extends State<SkeletonRound>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.primaryVariant,
        highlightColor: Theme.of(context).colorScheme.secondaryVariant,
        child: Container(
          height: widget.height,
          width: widget.width,
          margin: widget.margin,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
        ));
  }
}
