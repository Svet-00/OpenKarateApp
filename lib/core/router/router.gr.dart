// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/user.dart';
import '../../features/about/view/about_page.dart';
import '../../features/authorization/view/login_page.dart';
import '../../features/authorization/view/registration_page.dart';
import '../../features/bug_report/view/bug_report_page.dart';
import '../../features/dev_options/view/dev_options_page.dart';
import '../../features/events/bloc/events_cubit.dart';
import '../../features/events/view/events_page.dart';
import '../../features/events/view/filters/date_range_filter.dart';
import '../../features/events/view/filters/level_filter.dart';
import '../../features/events/view/filters/type_filter.dart';
import '../../features/gyms/view/gym_details_page.dart';
import '../../features/gyms/view/gym_list_page.dart';
import '../../features/newsfeed/view/newsfeed_page.dart';
import '../../features/profile/view/profile_edit_page.dart';
import '../../features/profile/view/profile_page.dart';
import '../../features/schedule/view/schedule_page.dart';
import '../../features/settings/view/settings_page.dart';
import '../../features/trainers/view/trainer_detail_page.dart';
import '../../features/trainers/view/trainer_list_page.dart';

class Routes {
  static const String devOptionsPage = '/dev-options-page';
  static const String newsfeedPage = '/';
  static const String profilePage = '/profile-page';
  static const String profileEditPage = '/profile-edit-page';
  static const String loginPage = '/login-page';
  static const String registrationPage = '/registration-page';
  static const String settingsPage = '/settings-page';
  static const String aboutPage = '/about-page';
  static const String bugReportPage = '/bug-report-page';
  static const String schedulePage = '/schedule-page';
  static const String gymListPage = '/gym-list-page';
  static const String gymDetailsPage = '/gym-details-page';
  static const String trainerListPage = '/trainer-list-page';
  static const String trainerDetailPage = '/trainer-detail-page';
  static const String eventsPage = '/events-page';
  static const String eventLevelFilterPage = '/event-level-filter-page';
  static const String eventTypeFilterPage = '/event-type-filter-page';
  static const String eventDateRangeFilterPage =
      '/event-date-range-filter-page';
  static const all = <String>{
    devOptionsPage,
    newsfeedPage,
    profilePage,
    profileEditPage,
    loginPage,
    registrationPage,
    settingsPage,
    aboutPage,
    bugReportPage,
    schedulePage,
    gymListPage,
    gymDetailsPage,
    trainerListPage,
    trainerDetailPage,
    eventsPage,
    eventLevelFilterPage,
    eventTypeFilterPage,
    eventDateRangeFilterPage,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.devOptionsPage, page: DevOptionsPage),
    RouteDef(Routes.newsfeedPage, page: NewsfeedPage),
    RouteDef(Routes.profilePage, page: ProfilePage),
    RouteDef(Routes.profileEditPage, page: ProfileEditPage),
    RouteDef(Routes.loginPage, page: LoginPage),
    RouteDef(Routes.registrationPage, page: RegistrationPage),
    RouteDef(Routes.settingsPage, page: SettingsPage),
    RouteDef(Routes.aboutPage, page: AboutPage),
    RouteDef(Routes.bugReportPage, page: BugReportPage),
    RouteDef(Routes.schedulePage, page: SchedulePage),
    RouteDef(Routes.gymListPage, page: GymListPage),
    RouteDef(Routes.gymDetailsPage, page: GymDetailsPage),
    RouteDef(Routes.trainerListPage, page: TrainerListPage),
    RouteDef(Routes.trainerDetailPage, page: TrainerDetailPage),
    RouteDef(Routes.eventsPage, page: EventsPage),
    RouteDef(Routes.eventLevelFilterPage, page: EventLevelFilterPage),
    RouteDef(Routes.eventTypeFilterPage, page: EventTypeFilterPage),
    RouteDef(Routes.eventDateRangeFilterPage, page: EventDateRangeFilterPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    DevOptionsPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const DevOptionsPage(),
        settings: data,
      );
    },
    NewsfeedPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => NewsfeedPage(),
        settings: data,
      );
    },
    ProfilePage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const ProfilePage(),
        settings: data,
      );
    },
    ProfileEditPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const ProfileEditPage(),
        settings: data,
      );
    },
    LoginPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => LoginPage(),
        settings: data,
      );
    },
    RegistrationPage: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => RegistrationPage(),
        settings: data,
      );
    },
    SettingsPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const SettingsPage(),
        settings: data,
      );
    },
    AboutPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const AboutPage(),
        settings: data,
      );
    },
    BugReportPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const BugReportPage(),
        settings: data,
      );
    },
    SchedulePage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SchedulePage(),
        settings: data,
      );
    },
    GymListPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => GymListPage(),
        settings: data,
      );
    },
    GymDetailsPage: (data) {
      final args = data.getArgs<GymDetailsPageArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => GymDetailsPage(args.gymId),
        settings: data,
      );
    },
    TrainerListPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => TrainerListPage(),
        settings: data,
      );
    },
    TrainerDetailPage: (data) {
      final args = data.getArgs<TrainerDetailPageArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => TrainerDetailPage(args.trainer),
        settings: data,
      );
    },
    EventsPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => EventsPage(),
        settings: data,
      );
    },
    EventLevelFilterPage: (data) {
      final args = data.getArgs<EventLevelFilterPageArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => EventLevelFilterPage(
          key: args.key,
          title: args.title,
          eventsCubit: args.eventsCubit,
        ),
        settings: data,
      );
    },
    EventTypeFilterPage: (data) {
      final args = data.getArgs<EventTypeFilterPageArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => EventTypeFilterPage(
          key: args.key,
          title: args.title,
          eventsCubit: args.eventsCubit,
        ),
        settings: data,
      );
    },
    EventDateRangeFilterPage: (data) {
      final args =
          data.getArgs<EventDateRangeFilterPageArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => EventDateRangeFilterPage(
          key: args.key,
          eventsCubit: args.eventsCubit,
          title: args.title,
          dateFormat: args.dateFormat,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// GymDetailsPage arguments holder class
class GymDetailsPageArguments {
  final String gymId;
  GymDetailsPageArguments({@required this.gymId});
}

/// TrainerDetailPage arguments holder class
class TrainerDetailPageArguments {
  final User trainer;
  TrainerDetailPageArguments({@required this.trainer});
}

/// EventLevelFilterPage arguments holder class
class EventLevelFilterPageArguments {
  final Key key;
  final String title;
  final EventsCubit eventsCubit;
  EventLevelFilterPageArguments(
      {this.key, @required this.title, @required this.eventsCubit});
}

/// EventTypeFilterPage arguments holder class
class EventTypeFilterPageArguments {
  final Key key;
  final String title;
  final EventsCubit eventsCubit;
  EventTypeFilterPageArguments(
      {this.key, @required this.title, @required this.eventsCubit});
}

/// EventDateRangeFilterPage arguments holder class
class EventDateRangeFilterPageArguments {
  final Key key;
  final EventsCubit eventsCubit;
  final String title;
  final DateFormat dateFormat;
  EventDateRangeFilterPageArguments(
      {this.key,
      @required this.eventsCubit,
      @required this.title,
      @required this.dateFormat});
}
