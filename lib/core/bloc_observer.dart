import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';

import 'injection_container.dart';

/// {@template counter_observer}
/// [BlocObserver] for the counter application which
/// observes all [Cubit] state changes.
/// {@endtemplate}
class AppBlocObserver extends BlocObserver {
  final logger = sl<Logger>();

  @override
  void onChange(Cubit cubit, Change change) {
    logger.i('${cubit.runtimeType} $change');
    super.onChange(cubit, change);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
    logger.e('${cubit.runtimeType} $error $stackTrace');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.i('${bloc.runtimeType} $transition');
  }
}
