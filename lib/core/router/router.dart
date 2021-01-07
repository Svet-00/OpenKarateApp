import 'package:auto_route/auto_route_annotations.dart';
import '../../features/events/view/filters/date_range_filter.dart';
import '../../features/events/view/filters/level_filter.dart';
import '../../features/events/view/filters/type_filter.dart';

import '../../features/about/view/about_page.dart';
import '../../features/authorization/view/login_page.dart';
import '../../features/authorization/view/registration_page.dart';
import '../../features/bug_report/view/bug_report_page.dart';
import '../../features/dev_options/view/dev_options_page.dart';
import '../../features/events/view/events_page.dart';
import '../../features/gyms/view/gym_details_page.dart';
import '../../features/gyms/view/gym_list_page.dart';
import '../../features/newsfeed/view/newsfeed_page.dart';
import '../../features/profile/view/profile_edit_page.dart';
import '../../features/profile/view/profile_page.dart';
import '../../features/settings/view/settings_page.dart';
import '../../features/schedule/view/schedule_page.dart';
import '../../features/trainers/view/trainer_detail_page.dart';
import '../../features/trainers/view/trainer_list_page.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AdaptiveRoute(page: DevOptionsPage),
    AdaptiveRoute(page: NewsfeedPage, initial: true),
    AdaptiveRoute(page: ProfilePage),
    AdaptiveRoute(page: ProfileEditPage),
    AdaptiveRoute(page: LoginPage),
    CupertinoRoute(page: RegistrationPage),
    AdaptiveRoute(page: SettingsPage),
    AdaptiveRoute(page: AboutPage),
    AdaptiveRoute(page: BugReportPage),
    AdaptiveRoute(page: SchedulePage),
    AdaptiveRoute(page: GymListPage),
    AdaptiveRoute(page: GymDetailsPage),
    AdaptiveRoute(page: TrainerListPage),
    AdaptiveRoute(page: TrainerDetailPage),
    AdaptiveRoute(page: EventsPage),
    CupertinoRoute(page: EventLevelFilterPage),
    CupertinoRoute(page: EventTypeFilterPage),
    CupertinoRoute(page: EventDateRangeFilterPage),
  ],
)
class $Router {}
