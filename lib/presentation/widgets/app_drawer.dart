import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../core/router/router.gr.dart';
import 'authorization_builder.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dense = size.width <= 320;
    final width = dense ? 272 : 300;
    return SafeArea(
      top: false,
      child: Material(
        child: Container(
          width: width.toDouble(),
          height: size.height,
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            children: [
              ListTile(
                title: Text('LOGO'),
                onTap: () {
                  ExtendedNavigator.root.pop();
                  ExtendedNavigator.root.popUntil((route) => route.isFirst);
                },
              ).padding(top: 26),
              Divider(
                thickness: 1,
              ),
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                children: [
                  AuthorizationBuilder(
                    authorized: (context, user) => _DrawerEntryTile(
                      icon: Icons.account_circle_outlined,
                      title: 'Профиль',
                      route: Routes.profilePage,
                      dense: dense,
                    ),
                    guest: (context) => _DrawerEntryTile(
                      icon: Icons.account_circle_outlined,
                      title: 'Войти',
                      route: Routes.profilePage,
                      dense: dense,
                    ),
                  ),
                  _DrawerEntryTile(
                    icon: Icons.article_outlined,
                    title: 'Новости',
                    route: Routes.newsfeedPage,
                    dense: dense,
                  ),
                  _DrawerEntryTile(
                    icon: Icons.access_time_outlined,
                    title: 'Расписание',
                    route: Routes.schedulePage,
                    dense: dense,
                  ),
                  _DrawerEntryTile(
                    icon: Icons.place_outlined,
                    title: 'Залы',
                    route: Routes.gymListPage,
                    dense: dense,
                  ),
                  _DrawerEntryTile(
                    icon: Icons.people_alt_outlined,
                    title: 'Тренеры',
                    route: Routes.trainerListPage,
                    dense: dense,
                  ),
                  _DrawerEntryTile(
                    icon: Icons.event_outlined,
                    title: 'События',
                    route: Routes.eventsPage,
                    dense: dense,
                  ),
                ],
              ).expanded(),
              Divider(),
              kDebugMode
                  ? _DrawerEntryTile(
                      icon: Icons.developer_board_outlined,
                      title: 'Dev Page',
                      route: Routes.devOptionsPage,
                      dense: dense,
                    )
                  : Container(),
              _DrawerEntryTile(
                icon: Icons.info_outlined,
                title: 'О приложении',
                route: Routes.aboutPage,
                dense: dense,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerEntryTile extends StatelessWidget {
  final Widget leading;
  final IconData icon;
  final String title;
  final String route;
  final Object arguments;
  final bool dense;

  _DrawerEntryTile({
    this.leading,
    this.icon,
    @required this.title,
    @required this.route,
    @required this.dense,
    this.arguments,
  })  : assert(icon != null || leading != null),
        assert(icon == null || leading == null);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: dense,
      leading: leading ?? Icon(icon),
      title: Text(title),
      onTap: () async {
        ExtendedNavigator.root.pop();
        if (route == '/') {
          ExtendedNavigator.root.popUntil((route) => route.isFirst);
        } else {
          if (ModalRoute.of(context)?.settings?.name != route) {
            unawaited(
              ExtendedNavigator.root.pushAndRemoveUntil(
                route,
                // remove all but the very first route from the navigator stack
                (route) => route.isFirst,
                arguments: arguments,
              ),
            );
          }
        }
      },
    );
  }
}
