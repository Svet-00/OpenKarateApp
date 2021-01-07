import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/injection_container.dart';
import '../../../presentation/widgets/app_scaffold.dart';
import '../bloc/newsfeed_cubit.dart';
import 'newsfeed_view.dart';

class NewsfeedPage extends StatelessWidget {
  NewsfeedPage();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) => sl<NewsfeedCubit>(),
        child: AppScaffold(
          appBar: AppBar(
            title: Text('Новости'),
          ),
          body: NewsfeedView(),
        ),
      ),
    );
  }
}
