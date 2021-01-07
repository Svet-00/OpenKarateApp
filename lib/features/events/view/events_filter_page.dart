import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/router/router.gr.dart';
import '../../../presentation/colors.dart';
import '../../../presentation/widgets/app_scaffold.dart';
import '../../../presentation/widgets/styled_raised_button.dart';
import '../bloc/events_cubit.dart';

class EventsFilterPage extends StatefulWidget {
  final CloseContainerActionCallback<void> closeCallback;
  EventsFilterPage({Key key, @required this.closeCallback})
      : assert(closeCallback != null),
        super(key: key);

  @override
  _EventsFilterPageState createState() => _EventsFilterPageState();
}

class _EventsFilterPageState extends State<EventsFilterPage> {
  EventsCubit eventsCubit;
  final dateFormat = DateFormat('dd.M.y');

  @override
  void initState() {
    super.initState();
    eventsCubit = context.read<EventsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isModalPage: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: widget.closeCallback,
        ),
        title: Text('Фильтры'),
      ),
      body: BlocBuilder<EventsCubit, EventsState>(
        builder: (context, state) {
          return Column(
            children: [
              ...ListTile.divideTiles(
                context: context,
                tiles: [
                  ListTile(
                    dense: false,
                    title: Row(
                      children: [
                        Text('Тип соревнований'),
                        SizedBox(width: 16),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            state.criteria.type,
                            textAlign: TextAlign.end,
                            style: DefaultTextStyle.of(context).style.apply(
                                  color: BrandColors.greyText,
                                ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () => ExtendedNavigator.root.push(
                      Routes.eventTypeFilterPage,
                      arguments: EventTypeFilterPageArguments(
                        title: 'Тип соревнований',
                        eventsCubit: eventsCubit,
                      ),
                    ),
                  ),
                  ListTile(
                    dense: false,
                    title: Row(
                      children: [
                        Text('Уровень соревнований'),
                        SizedBox(width: 16),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            state.criteria.level,
                            textAlign: TextAlign.end,
                            style: DefaultTextStyle.of(context).style.apply(
                                  color: BrandColors.greyText,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () => ExtendedNavigator.root.push(
                      Routes.eventLevelFilterPage,
                      arguments: EventLevelFilterPageArguments(
                        title: 'Уровень соревнований',
                        eventsCubit: eventsCubit,
                      ),
                    ),
                  ),
                  ListTile(
                    dense: false,
                    title: Text('Даты проведения'),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () => ExtendedNavigator.root.push(
                      Routes.eventDateRangeFilterPage,
                      arguments: EventDateRangeFilterPageArguments(
                        title: 'Даты проведения',
                        eventsCubit: eventsCubit,
                        dateFormat: dateFormat,
                      ),
                    ),
                  ),
                ],
              ),
              Container().expanded(),
              Row(
                children: [
                  FlatButton(
                    onPressed: () {
                      eventsCubit.resetFilter();
                      widget.closeCallback();
                    },
                    child: Text('Сбросить'),
                  ).expanded(),
                  SizedBox(width: 16),
                  StyledRaisedButton(
                    onPressed: () {
                      eventsCubit.filter();
                      widget.closeCallback();
                    },
                    title: 'Применить',
                  ).expanded()
                ],
              ),
            ],
          )
              .padding(
                horizontal: 16,
                top: 8,
                bottom: 8,
              )
              .backgroundColor(
                Theme.of(context).colorScheme.surface,
              );
        },
      ),
    );
  }
}
