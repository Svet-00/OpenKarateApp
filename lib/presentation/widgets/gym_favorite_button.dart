import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openkarateapp/domain/entities/gym.dart';
import 'package:openkarateapp/features/gyms/bloc/gyms_cubit.dart';
import 'package:openkarateapp/presentation/widgets/authorization_builder.dart';

class GymFavoriteButton extends StatelessWidget {
  final Gym gym;
  const GymFavoriteButton({Key key, @required this.gym})
      : assert(gym != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AuthorizationBuilder(
        authorized: (context, _) {
          return RaisedButton(
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
            clipBehavior: Clip.antiAlias,
            color: Colors.grey[700],
            child: Icon(Icons.star,
                color: gym.isFavorite ? Colors.amber : Colors.white),
            onPressed: () async {
              final cubit = context.read<GymsCubit>();
              await cubit.toggleFavorite(gym);
            },
          );
        },
        guest: (context) {
          return RaisedButton(
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
            clipBehavior: Clip.antiAlias,
            color: Colors.grey[700],
            child: Icon(Icons.star, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: Text(
                      'Пожалуйста, войдите в свой аккаунт чтобы иметь возможность добавлять зал в избранное.',
                      style: TextStyle(fontSize: 14),
                    ),
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: SimpleDialogOption(
                          child: Text('Ок'),
                          onPressed: ExtendedNavigator.root.pop,
                        ),
                      )
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
