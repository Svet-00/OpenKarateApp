import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'app_bottom_navigation_bar.dart';
import 'app_drawer.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget appBar;
  final List<Widget> persistentFooterButtons;
  final Widget floatingActionButton;
  final bool isModalPage;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  AppScaffold({
    this.appBar,
    @required this.body,
    this.persistentFooterButtons,
    this.floatingActionButton,
    this.isModalPage = false,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // temporary solution for https://github.com/flutter/flutter/issues/50276
    final needsPersistentDrawer =
        ResponsiveWrapper.of(context).isLargerThan(MOBILE);

    final drawDrawerAndBottomBar = !needsPersistentDrawer && !isModalPage;

    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      drawer: drawDrawerAndBottomBar ? AppDrawer() : null,
      body: needsPersistentDrawer
          ? Row(
              children: [
                AppDrawer(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: body,
                  ),
                ),
              ],
            )
          : body,
      persistentFooterButtons: persistentFooterButtons,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: drawDrawerAndBottomBar
          ? AppBottomNavigationBar(
              scaffoldKey: _scaffoldKey,
            )
          : null,
    );
  }
}
