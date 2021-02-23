import 'package:do_quran/bookmarks/widgets/bookmarks_list_view_widget.dart';
import 'package:do_quran/generated/l10n.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';

class BookmarksWidget extends StatefulWidget {
  BookmarksWidget({Key key}) : super(key: key);

  @override
  _BookmarksWidgetState createState() => _BookmarksWidgetState();
}

class _BookmarksWidgetState extends State<BookmarksWidget> {
  @override
  void initState() {
    super.initState();
  }

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
                onTap: () {},
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
              )
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
          child: BookmarksListViewWidget(),
        ),
      ],
    );
  }

  Widget getButtonCategory(int index) {
    String txt;
    bool isSelected = false;
    switch (index) {
      case 0:
        txt = 'All';
        isSelected = true;
        break;
      case 1:
        txt = 'Allah Menciptakan Manusia';
        break;
      case 2:
        txt = 'Perintah Menundukan Dari Duniawi';
        break;
      case 3:
        txt = 'Wujud Allah Meliputi Segalanya';
        break;
      case 4:
        txt = 'Wujud Kebesaran Ilmu Allah Pada Manusia';
        break;
      case 5:
        txt = 'Allah Meliputi Segala Sesuatu';
        break;
      default:
    }
    return Container(
      margin: const EdgeInsets.only(right: 5.0),
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
            padding:
                const EdgeInsets.only(top: 12, bottom: 12, left: 18, right: 18),
            child: Center(
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
