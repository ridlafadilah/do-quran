import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookmarksListViewWidget extends StatefulWidget {
  BookmarksListViewWidget({Key key}) : super(key: key);

  @override
  _BookmarksListViewWidgetState createState() =>
      _BookmarksListViewWidgetState();
}

class _BookmarksListViewWidgetState extends State<BookmarksListViewWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          bottom: 15 + MediaQuery.of(context).padding.bottom,
        ),
        itemCount: 6,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return getListBookmarks('Al-Baqarah', index + 1);
        });
  }

  Widget getListBookmarks(String surah, int ayah) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Theme.of(context).cardTheme.shadowColor.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).cardTheme.color,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/eva_icons/outline/svg/book-outline.svg',
                        color:
                            Theme.of(context).iconTheme.color.withOpacity(0.7),
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          '$surah : $ayah',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.0,
                            color: Theme.of(context).textTheme.headline1.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                    child: Text(
                      'Dengan nama Allah Yang Maha Pengasih, Maha Penyayang.',
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerTheme.color,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              '''
Dengan nama Allah Yang Maha Pengasih, Maha Penyayang.''',
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    Theme.of(context).textTheme.headline4.color,
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
  }
}
