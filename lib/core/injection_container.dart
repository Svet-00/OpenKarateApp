import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../data/api/service/event_api_service.dart';
import '../data/api/service/gym_api_service.dart';
import '../data/api/service/news_api_service.dart';
import '../data/api/service/notification_api_service.dart';
import '../data/api/service/schedule_api_service.dart';
import '../data/api/service/security_api_service.dart';
import '../data/api/service/user_api_service.dart';
import '../data/repositories/event_repository_impl.dart';
import '../data/repositories/gym_repositrory_impl.dart';
import '../data/repositories/news_repository_impl.dart';
import '../data/repositories/schedule_repository_impl.dart';
import '../data/repositories/user_repository_impl.dart';
import '../domain/repositories/event_repository.dart';
import '../domain/repositories/gym_repository.dart';
import '../domain/repositories/news_repository.dart';
import '../domain/repositories/schedule_repository.dart';
import '../domain/repositories/user_repository.dart';
import '../features/gyms/bloc/gyms_cubit.dart';
import '../features/newsfeed/bloc/newsfeed_cubit.dart';
import '../features/schedule/bloc/schedule_cubit.dart';
import '../features/trainers/bloc/users_cubit.dart';
import 'logger/log_constole_output.dart';
import 'network/network_client.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // most important thing ever
  sl.registerLazySingleton(() {
    if (kDebugMode) {
      return Logger(
        printer: PrettyPrinter(),
        output: ConsoleOutput(),
        filter: ProductionFilter(),
        level: Level.verbose,
      );
    } else {
      return Logger(
        printer: PrettyPrinter(printTime: true),
        output: ConsoleOutput(),
        filter: ProductionFilter(),
        level: Level.info,
      );
    }
  });

  //! Domain
  // Bloc
  sl.registerFactory(
    () => ScheduleCubit(
      gymRepository: sl(),
      scheduleRepository: sl(),
    ),
  );

  sl.registerFactory(() => GymsCubit(gymRepository: sl()));
  sl.registerFactory(() => UsersCubit(userRepository: sl()));
  sl.registerFactory(() => NewsfeedCubit(newsRepository: sl()));

  // Repository
  sl.registerLazySingleton<GymRepository>(
    () => GymRepositoryImpl(
      apiService: sl(),
    ),
  );

  sl.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepositoryImpl(
      apiService: sl(),
    ),
  );

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      apiService: sl(),
      securityApiService: sl(),
    ),
  );

  sl.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(
      apiService: sl(),
    ),
  );

  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      apiService: sl(),
    ),
  );

  // ! Data
  // Api services
  sl.registerLazySingleton(() => GymApiService(sl()));
  sl.registerLazySingleton(() => ScheduleApiService(sl()));
  sl.registerLazySingleton(() => UserApiService(sl()));
  sl.registerLazySingleton(() => EventApiService(sl()));
  sl.registerLazySingleton(() => NewsApiService(sl()));
  sl.registerLazySingleton(() => NotificationApiService(sl()));
  // pass different dio instance to avoid request lock
  sl.registerLazySingleton(
    () => SecurityApiService(sl<Dio>(instanceName: 'alt')),
  );

  sl.registerLazySingleton<NetworkClient>(
    () => NetworkClient(sl<Dio>(instanceName: 'alt')),
  );

  final dioBaseOptions = BaseOptions(
    followRedirects: true,
  );
  final dio = Dio(dioBaseOptions);
  final dioAlt = Dio(dioBaseOptions);

  //! External
  sl.registerLazySingleton<Dio>(() => dio);
  sl.registerLazySingleton<Dio>(() => dioAlt, instanceName: 'alt');
}
