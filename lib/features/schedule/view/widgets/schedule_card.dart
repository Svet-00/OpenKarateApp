import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../../../../presentation/colors.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../domain/entities/gym.dart';
import '../../../../domain/entities/schedule.dart';

final _borderColor = Colors.grey.shade500;

class ScheduleCard extends StatelessWidget {
  final Gym gym;
  final List<Schedule> schedules;
  final double leftPadding = 8;

  ScheduleCard({
    @required this.gym,
    @required this.schedules,
  });

  List<Widget> _buildRows(BuildContext context) {
    final daysOfWeek = [
      'Понедельник',
      'Вторник',
      'Среда',
      'Четверг',
      'Пятница',
      'Суббота',
      'Воскресенье',
    ];
    final rows = <Widget>[];

    for (final dow in daysOfWeek) {
      final filteredSchedules = schedules
          .where(
            (element) => element.dayOfWeek == dow,
          )
          .toList();

      if (filteredSchedules.isEmpty) continue;

      rows.addAll([
        Text(dow)
            .fontSize(15)
            .alignment(Alignment.centerLeft)
            .padding(left: leftPadding, vertical: 10)
      ]);

      final timesAndDescriptions = <Widget>[];

      for (final schedule in filteredSchedules) {
        timesAndDescriptions.add(
          _ScheduleTimeRow(
            time: schedule.time,
            description: schedule.description,
          ),
        );
        timesAndDescriptions.add(
          Divider(
            color: _borderColor,
            height: 1,
          ),
        );
      }

      rows.add(TimesAndDescriptionsContainer(
        timesAndDescriptions.take(timesAndDescriptions.length - 1).toList(),
      ));
    }
    rows.add(
      ExpandableButton(child: Icon(Icons.expand_less)).padding(vertical: 5),
    );
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ExpandableNotifier(
        initialExpanded: false,
        child: ScrollOnExpand(
          child: ExpandablePanel(
            header: Text(
              gym.title,
            ).fontSize(17).padding(left: leftPadding, vertical: 12),
            expanded: Column(
              children: [
                ..._buildRows(context),
              ],
            ),
            theme: ExpandableThemeData(
              hasIcon: true,
              iconPlacement: ExpandablePanelIconPlacement.right,
            ),
          ),
        ),
      ),
    );
  }
}

class _ScheduleTimeRow extends StatelessWidget {
  _ScheduleTimeRow({
    Key key,
    @required this.time,
    @required this.description,
  }) : super(key: key);

  final String time;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Text(time).expanded(flex: 2),
          Text(description).expanded(flex: 3),
        ],
      ),
    );
  }
}

class TimesAndDescriptionsContainer extends StatelessWidget {
  TimesAndDescriptionsContainer(this.children, {Key key}) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: BrandColors.greyBackground,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: _borderColor),
        ),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
