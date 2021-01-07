import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/injection_container.dart';
import '../../../core/utils/open_external.dart';
import '../../../presentation/widgets/app_scaffold.dart';
import '../../../presentation/widgets/flushbar_helpers.dart';
import '../../localizations/action_localizations.dart';
import '../../localizations/error_localizations.dart';
import '../bloc/gyms_cubit.dart';
import 'gym_header.dart';

class GymDetailsPage extends StatelessWidget {
  final String gymId;

  GymDetailsPage(this.gymId);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GymsCubit>(
      create: (_) => sl<GymsCubit>(),
      child: GymDetailsView(gymId: gymId),
    );
  }
}

class GymDetailsView extends StatelessWidget {
  final String gymId;
  final iconColor = Colors.grey[700];
  GymDetailsView({Key key, @required this.gymId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GymsCubit, GymsState>(builder: (context, state) {
      final gym = state.gyms.singleWhere((g) => g.id == gymId);
      assert(gym != null);
      return AppScaffold(
        appBar: AppBar(title: Text(gym.title)),
        body: ListView(
          shrinkWrap: true,
          children: [
            GymHeader(
              imgList: gym.photos.map((e) => e.url).toList(),
              title: gym.title,
              subtitle: gym.address,
              description: gym.description,
              gym: gym,
            ),
            _buildInfoRow(
              icon: Icons.timelapse,
              title: 'Режим работы',
              content: gym.workingTime,
            ),
            _buildInfoRow(
              icon: Icons.navigation,
              content: ActionLocalizations.buildARoute(),
              onTap: () => OpenExternal.openMap(gym.address),
            ),
            _buildInfoRow(
              icon: Icons.phone,
              content: gym.phoneNumber,
              onTap: () async {
                final url = 'tel:${gym.phoneNumber}';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            _buildInfoRow(
              icon: Icons.mood,
              content:
                  gym.vkLink == null || gym.vkLink.isEmpty ? '' : 'Мы в ВК',
              onTap: () async {
                final url = gym.vkLink;
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  sl<Logger>().e(ErrorLocalizations.unsupportedUrl(url));
                  await FlushbarHelpers.createError(
                    message: ErrorLocalizations.unsupportedUrl(url),
                  ).show(context);
                }
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildInfoRow({
    @required IconData icon,
    String title,
    @required String content,
    VoidCallback onTap,
  }) {
    if (content == null || content.isEmpty) return Container();
    final row = Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            child: Icon(icon, color: iconColor),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              title != null
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        title,
                        textAlign: TextAlign.justify,
                      ),
                    )
                  : Container(),
              LimitedBox(
                maxWidth: 230,
                child: Text(
                  content,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return onTap != null
        ? InkWell(
            onTap: onTap,
            child: row,
          )
        : row;
  }
}
