import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/router/router.gr.dart';
import '../colors.dart';

class AppBottomNavigationBar extends StatefulWidget {
  AppBottomNavigationBar({
    Key key,
    @required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  _BarRoutes _mapRoutes(String route) {
    var barRoute;
    switch (route) {
      case Routes.profilePage:
      case Routes.profileEditPage:
      case Routes.loginPage:
      case Routes.registrationPage:
        barRoute = _BarRoutes.profile;
        break;
      case Routes.newsfeedPage:
        barRoute = _BarRoutes.news;
        break;
      case Routes.schedulePage:
        barRoute = _BarRoutes.schedule;
        break;
      case Routes.eventsPage:
        barRoute = _BarRoutes.events;
        break;
      default:
        barRoute = _BarRoutes.menu;
        break;
    }
    return barRoute;
  }

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context).settings.name ??
        '/something-that-does-not-really-make-sense';
    final currentRoute = _mapRoutes(route);

    return BottomNavigationBar(
      currentIndex: currentRoute.index,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: BrandColors.greyText,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Профиль',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time_outlined),
          label: 'Расписание',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article_outlined),
          label: 'Новости',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_outlined),
          label: 'События',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Меню',
        ),
      ],
      onTap: (index) {
        final requestedRoute = _BarRoutes.values[index];
        if (currentRoute == requestedRoute &&
            requestedRoute != _BarRoutes.menu) {
          return;
        }

        switch (requestedRoute) {
          case _BarRoutes.profile:
            ExtendedNavigator.root
                .pushAndRemoveUntilPath(Routes.profilePage, '/');
            break;
          case _BarRoutes.news:
            ExtendedNavigator.root
                .pushAndRemoveUntilPath(Routes.newsfeedPage, '/');
            break;
          case _BarRoutes.schedule:
            ExtendedNavigator.root
                .pushAndRemoveUntilPath(Routes.schedulePage, '/');
            break;
          case _BarRoutes.events:
            ExtendedNavigator.root
                .pushAndRemoveUntilPath(Routes.eventsPage, '/');
            break;
          case _BarRoutes.menu:
            try {
              widget.scaffoldKey.currentState?.openDrawer();
            } catch (_) {}
            break;
        }
      },
    );
  }
}

enum _BarRoutes { profile, schedule, news, events, menu }
