import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/router/router.gr.dart';
import '../../../presentation/widgets/app_scaffold.dart';
import '../../../presentation/widgets/carousel.dart';
import '../../../presentation/widgets/styled_raised_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Carousel(
            imgList: [
              'https://photos.wikimapia.org/p/00/07/00/98/10_big.jpg',
              'https://photos.wikimapia.org/p/00/05/34/83/47_full.jpg',
            ],
            title: 'Спортивный клуб OpenKarateApp',
          ),
          StyledRaisedButton.large(
            title: 'Расписание',
            onPressed: () => _navigateToRootRoute(Routes.schedulePage),
          ),
          StyledRaisedButton.large(
            title: 'Залы',
            onPressed: () => _navigateToRootRoute(Routes.gymListPage),
          ),
          StyledRaisedButton.large(
            title: 'Тренеры',
            onPressed: () => _navigateToRootRoute(Routes.trainerListPage),
          ),
          // hack which make page look pretty
          // it adds space after last button
          Container(),
        ],
      ),
    );
  }

  void _navigateToRootRoute(String name) {
    ExtendedNavigator.root.pushAndRemoveUntil(
      name,
      (route) => route.isFirst,
    );
  }
}
