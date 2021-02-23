import 'package:do_quran/generated/l10n.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class BookmarksSkeletonWidget extends StatefulWidget {
  BookmarksSkeletonWidget({Key key}) : super(key: key);

  @override
  _BookmarksSkeletonWidgetState createState() =>
      _BookmarksSkeletonWidgetState();
}

class _BookmarksSkeletonWidgetState extends State<BookmarksSkeletonWidget> {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  DongkapLocalizations.of(context).category,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 0.27,
                  ),
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: <Widget>[
                      Text(
                        DongkapLocalizations.of(context).others,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          letterSpacing: 0.5,
                          color: AppTheme.colorTheme,
                        ),
                      ),
                      SizedBox(
                        height: 38,
                        width: 26,
                        child: Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).iconTheme.color,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          height: 45,
          width: double.infinity,
          child: ListView.builder(
              shrinkWrap: true,
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, right: 16, left: 16),
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return getButtonCategory(index);
              }),
        ),
        const SizedBox(
          height: 16,
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: itemCount,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Theme.of(context)
                              .cardTheme
                              .shadowColor
                              .withOpacity(0.2),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Theme.of(context).cardTheme.color,
                    child: Container(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 18, left: 16, right: 16),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  'assets/eva_icons/outline/svg/book-outline.svg',
                                  color: Theme.of(context)
                                      .iconTheme
                                      .color
                                      .withOpacity(0.7),
                                  height: 16,
                                ),
                                Shimmer.fromColors(
                                  baseColor: Theme.of(context)
                                      .colorScheme
                                      .primaryVariant,
                                  highlightColor: Theme.of(context)
                                      .colorScheme
                                      .secondaryVariant,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Container(
                                      color: Colors.white,
                                      width: 100.0,
                                      height: 15.0,
                                      child: const Text(''),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Shimmer.fromColors(
                              baseColor:
                                  Theme.of(context).colorScheme.primaryVariant,
                              highlightColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryVariant,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, left: 20.0),
                                child: Container(
                                  color: Colors.white,
                                  width: 350.0,
                                  height: 15.0,
                                  child: const Text(''),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 6),
                              child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).dividerTheme.color,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0)),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 12.0),
                              child: Row(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    'assets/eva_icons/outline/svg/file-text-outline.svg',
                                    color: Theme.of(context)
                                        .iconTheme
                                        .color
                                        .withOpacity(0.7),
                                    height: 16,
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Shimmer.fromColors(
                                      baseColor: Theme.of(context)
                                          .colorScheme
                                          .primaryVariant,
                                      highlightColor: Theme.of(context)
                                          .colorScheme
                                          .secondaryVariant,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Container(
                                          color: Colors.white,
                                          width: 250.0,
                                          height: 15.0,
                                          child: const Text(''),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget getButtonCategory(int index) {
    String txt = '';
    bool isSelected = false;
    switch (index) {
      case 0:
        txt = 'All';
        isSelected = true;
        break;
      default:
    }
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primaryVariant,
      highlightColor: Theme.of(context).colorScheme.secondaryVariant,
      child: Container(
        margin: const EdgeInsets.only(right: 5.0),
        width: isSelected ? null : 130,
        decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.colorTheme
                : Theme.of(context).buttonTheme.colorScheme,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: AppTheme.colorTheme)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: AppTheme.colorTheme,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Text(
                txt,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 0.27,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : AppTheme.colorTheme,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
