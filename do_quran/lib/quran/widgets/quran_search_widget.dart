import 'package:do_core/models/quran/quran_info.dart';
import 'package:do_quran/generated/l10n.dart';
import 'package:do_quran/quran/bloc/search_quran_bloc.dart';
import 'package:do_quran/quran/surah_page.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class QuranSearchWidget extends StatefulWidget {
  const QuranSearchWidget(
      {Key key, this.animationController, this.title, this.descriptions})
      : super(key: key);

  final AnimationController animationController;
  final String title, descriptions;

  @override
  _QuranSearchWidgetState createState() => _QuranSearchWidgetState();
}

class _QuranSearchWidgetState extends State<QuranSearchWidget> {
  bool resultSearching = false;
  List<QuranInfo> quran = [];
  int ayat = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SearchQuranBloc()..add(const InitialQuranEvent());
      },
      child: BlocListener<SearchQuranBloc, SearchQuranState>(
        listener: (context, state) {
          if (state.action.isValidated) {
            setState(() {
              quran = state.quran;
              ayat = state.ayat;
              resultSearching = state.quran.isNotEmpty ?? false;
            });
          } else {
            setState(() {
              resultSearching = false;
            });
          }
        },
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: contentBox(context),
        ),
      ),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: 20.0, top: 20.0, right: 20.0, bottom: 30.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).dialogTheme.backgroundColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<SearchQuranBloc, SearchQuranState>(
                buildWhen: (previous, current) =>
                    previous.surah != current.surah,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 10.0),
                    child: Container(
                      height: 45.0,
                      child: TextField(
                        onChanged: (surah) {
                          context
                              .read<SearchQuranBloc>()
                              .add(SurahChanged(surah));
                        },
                        autofocus: true,
                        cursorColor: AppTheme.grey,
                        style: TextStyle(
                            color: Theme.of(context)
                                .dialogTheme
                                .contentTextStyle
                                .color),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: AppTheme.lightGrey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: AppTheme.grey,
                            ),
                          ),
                          hintStyle: const TextStyle(color: AppTheme.lightGrey),
                          hintText:
                              DongkapLocalizations.of(context).hintSearchQuran,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Visibility(
                  child: Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: quran.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    highlightColor: AppTheme.lightGrey,
                                    onTap: () {
                                      Navigator.of(context).pop(false);
                                      Navigator.of(context).push(
                                        MaterialPageRoute<dynamic>(
                                          builder: (BuildContext context) =>
                                              SurahPage(
                                            animationController:
                                                widget.animationController,
                                            quranInfo: quran[index],
                                            ayat: ayat,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                        child: Text(
                                      '${quran[index].latin}:$ayat',
                                      style: const TextStyle(
                                          color: Color(0xFF21A7FF)),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  visible: resultSearching),
            ],
          ),
        ),
      ],
    );
  }
}
