import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum SkeletonListType { all, titleSubtitle, title }

class SkeletonList extends StatefulWidget {
  const SkeletonList(
      {Key key,
      this.index,
      this.itemCount = 2,
      @required this.type,
      this.heightLeading = 40.0,
      this.widthLeading = 40.0,
      this.heightTitle = 14.0,
      this.widthTitle = 200.0,
      this.heightSubtitle = 12.0,
      this.widthSubtitle = 100.0,
      this.horizontalGap = 10.0,
      this.marginItem = const EdgeInsets.only(bottom: 6.0),
      this.marginTitle = const EdgeInsets.only(bottom: 7.0)})
      : super(key: key);

  final int index;
  final int itemCount;
  final SkeletonListType type;
  final double heightLeading;
  final double widthLeading;
  final double heightTitle;
  final double widthTitle;
  final double heightSubtitle;
  final double widthSubtitle;
  final double horizontalGap;
  final EdgeInsets marginItem;
  final EdgeInsets marginTitle;

  @override
  createState() => SkeletonListState();
}

class SkeletonListState extends State<SkeletonList>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primaryVariant,
      highlightColor: Theme.of(context).colorScheme.secondaryVariant,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.itemCount,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            switch (widget.type) {
              case SkeletonListType.all:
                return all();
                break;
              case SkeletonListType.title:
                return title();
                break;
              default:
                return titleSubtitle();
            }
          }),
    );
  }

  Widget all() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: widget.widthLeading,
            height: widget.heightLeading,
            margin: widget.marginItem,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.widthLeading / 2)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: widget.horizontalGap),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: widget.widthTitle,
                height: widget.heightTitle,
                color: Colors.white,
                margin: widget.marginTitle,
              ),
              Container(
                width: widget.widthSubtitle,
                height: widget.heightSubtitle,
                color: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget titleSubtitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: widget.horizontalGap),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Container(
                  width: widget.widthTitle,
                  height: widget.heightTitle,
                  color: Colors.white,
                  margin: widget.marginTitle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                  width: widget.widthSubtitle,
                  height: 14,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: widget.horizontalGap),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 20.0),
                child: Container(
                  width: widget.widthTitle,
                  height: widget.heightTitle,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
