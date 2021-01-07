import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'core/injection_container.dart';
import 'core/router/router.gr.dart' as router;
import 'data/api/service/notification_api_service.dart';
import 'domain/repositories/user_repository.dart';
import 'features/authorization/cubit/authorization_cubit.dart';
import 'features/notifications/cubit/notifications_cubit.dart';
import 'features/settings/cubit/settings_cubit.dart';
import 'presentation/app_page_transition_theme.dart';

class Application extends StatelessWidget {
  Application.run() {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      } else {
        Zone.current.handleUncaughtError(
          details.exception,
          details.stack ?? StackTrace.current,
        );
      }
    };

    runZonedGuarded<Future<void>>(() async {
      runApp(this);
    }, (error, stackTrace) {
      _handleError(error, stackTrace);
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsCubit = SettingsCubit();
    final authorizationCubit = AuthorizationCubit(
      settingsCubit,
      sl<UserRepository>(),
      sl<Dio>(),
    );
    final notificationsCubit = NotificationsCubit(
      authorizationCubit: authorizationCubit,
      notificationApiService: sl<NotificationApiService>(),
    );

    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'OpenKarateApp',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        //const Locale('en'),
        const Locale('ru'),
      ],
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: Colors.indigo,
          onPrimary: Colors.white,
          primaryVariant: Colors.indigoAccent,
          secondary: Colors.purple.shade300,
          onSecondary: Colors.black87,
        ),
        textTheme: GoogleFonts.robotoTextTheme().copyWith(
          bodyText1: textTheme.bodyText1?.copyWith(fontSize: 16),
          bodyText2: textTheme.bodyText2?.copyWith(fontSize: 16),
        ),
      ).copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: AppPageTransitionsBuilder(),
          },
        ),
      ),
      builder: ExtendedNavigator.builder<router.Router>(
        router: router.Router(),
        builder: (context, extendedNav) => ResponsiveWrapper(
          // exclude semantics reason:
          // bug: https://github.com/flutter/flutter/issues/30675
          child: ExcludeSemantics(
            // * settings
            child: BlocProvider.value(
              value: settingsCubit,
              // * authorization
              child: BlocProvider.value(
                value: authorizationCubit,
                // * notifications
                child: BlocProvider.value(
                  value: notificationsCubit,
                  child: extendedNav,
                ),
              ),
            ),
          ),
          minWidth: 320,
          mediaQueryData: MediaQuery.of(context),
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(320, name: PHONE),
            ResponsiveBreakpoint.autoScale(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: '4K'),
          ],
          shrinkWrap: true,
        ),
      ),
    );
  }

  void _handleError(dynamic error, dynamic stackTrace) {
    // TODO: check if crash reporting enabled
    // TODO: if reporting disabled show report details and ask to send it
    sl<Logger>().wtf(
      'Uncaught exception (caused app crash)',
      error,
      stackTrace ?? StackTrace.current,
    );
  }
}
