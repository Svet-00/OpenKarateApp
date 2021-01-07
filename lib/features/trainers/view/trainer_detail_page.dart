import 'package:flutter/material.dart';

import '../../../domain/entities/user.dart';
import '../../../presentation/widgets/app_scaffold.dart';

class TrainerDetailPage extends StatelessWidget {
  final User trainer;
  TrainerDetailPage(this.trainer);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: Text('Тренер')),
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.network(
                trainer.avatar.wide,
                height: MediaQuery.of(context).size.width * 10 / 16,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: 60,
                width: double.infinity,
                color: Colors.black.withOpacity(0.6),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    child: Text(
                      '${trainer.surname} ${trainer.name} ${trainer.patronymic}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 13,
            ),
            child: Text(trainer.shortDescription ?? ''),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13),
            child: Text(trainer.longDescription ?? ''),
          ),
        ],
      ),
    );
  }
}
