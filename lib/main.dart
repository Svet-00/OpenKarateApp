// @dart=2.9
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl_standalone.dart';

import 'application.dart';
import 'core/bloc_observer.dart';
import 'core/injection_container.dart';

void main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  WidgetsFlutterBinding.ensureInitialized();

  await findSystemLocale();
  await initServiceLocator();

  HydratedBloc.storage = await HydratedStorage.build();

  Bloc.observer = AppBlocObserver();

  await Hive.initFlutter();

  Application.run();
}
