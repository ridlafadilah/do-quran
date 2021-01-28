import 'dart:io';
import 'package:do_core/core.dart';
import 'package:do_quran/auth/auth.dart';
import 'package:do_quran/configs/security_config.dart';
import 'package:do_quran/environments/environment.dart';
import 'package:do_quran/l10n/bloc/translation_bloc.dart';
import 'package:do_quran/main/main_layout.dart';
import 'package:do_quran/theme/bloc/thememode_bloc.dart';
import 'package:do_quran/splash/splash_page.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:do_quran/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_configuration/global_configuration.dart';

class DongkapApp extends StatelessWidget {
  const DongkapApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(
              authService: RepositoryProvider.of<AuthService>(_)),
        ),
        BlocProvider<TranslationBloc>(
          create: (_) => TranslationBloc()..add(const TranslationEvent()),
        ),
        BlocProvider<ThemeModeBloc>(
          create: (_) => ThemeModeBloc()..add(const ThemeModeEvent()),
        ),
      ], child: DongkapAppView()),
    );
  }
}

class DongkapAppView extends StatefulWidget {
  @override
  _DongkapAppViewState createState() => _DongkapAppViewState();
}

class _DongkapAppViewState extends State<DongkapAppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  static const List<Locale> supportedLocales = <Locale>[
    Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
    Locale.fromSubtags(languageCode: 'id', countryCode: 'ID'),
  ];
  Locale localeDefault =
      const Locale.fromSubtags(languageCode: 'en', countryCode: 'US');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationBloc, TranslationState>(
      builder: (BuildContext context, TranslationState state) {
        return BlocBuilder<ThemeModeBloc, ThemeModeState>(
          builder: (BuildContext context, ThemeModeState themeState) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness:
                  themeState.darkMode ? Brightness.light : Brightness.dark,
              statusBarBrightness:
                  Platform.isAndroid ? Brightness.dark : Brightness.light,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarDividerColor: Colors.grey,
              systemNavigationBarIconBrightness: Brightness.dark,
            ));
            return MaterialApp(
              navigatorKey: _navigatorKey,
              title: 'Dongkap',
              debugShowCheckedModeBanner:
                  GlobalConfiguration().getValue<bool>('debug'),
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeState.themeMode,
              localizationsDelegates: [
                DongkapLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: supportedLocales,
              locale: state.locale,
              builder: (context, child) {
                return BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) async {
                    await Future<dynamic>.delayed(
                        const Duration(milliseconds: 5000));
                    _navigator.pushAndRemoveUntil<void>(
                      MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => MainLayout()),
                      (route) => false,
                    );
                  },
                  child: child,
                );
              },
              onGenerateRoute: (_) => MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => SplashPage()),
            );
          },
        );
      },
    );
  }
}

void setupConfiguration(Environment env, SecurityConfig sec) {
  GlobalConfiguration()
      .loadFromMap(env.config)
      .loadFromMap(env.hosts)
      .loadFromMap(sec.config);
}

Future<void> setupLocator() async {
  await setupCoreLocator();
}
