import 'package:get_it/get_it.dart';
import 'package:pulse_monitor/core/navigation/app_navigator.dart';
import 'package:pulse_monitor/core/ui_localized_texts/app_localizations/txt.dart';
import 'package:pulse_monitor/features/ble_connection/navigation/ble_connection_navigator.dart';
import 'package:pulse_monitor/features/ble_connection/presentation/ble_connection_bloc.dart';
import 'package:pulse_monitor/features/limits/device/battery_service_impl.dart';
import 'package:pulse_monitor/features/limits/device/heart_rate_service_impl.dart';
import 'package:pulse_monitor/features/limits/device/limits_repository_impl.dart';
import 'package:pulse_monitor/features/limits/domain/battery_service.dart';
import 'package:pulse_monitor/features/limits/domain/heart_rate_service.dart';
import 'package:pulse_monitor/features/limits/domain/limits_repository.dart';
import 'package:pulse_monitor/features/limits/navigation/limits_navigator.dart';
import 'package:pulse_monitor/features/limits/presentation/limits_bloc.dart';
import 'package:pulse_monitor/features/limits/presentation/limits_view.dart';
import 'package:pulse_monitor/ui_components/dialogs/dialog_factory.dart';

GetIt getIt = GetIt.instance;

void initGetIt() {
  getIt.registerSingleton<Txt>(Txt());
  getIt.registerLazySingleton<DialogFactory>(() => DialogFactory(getIt<Txt>()));
  getIt.registerLazySingleton<LimitsNavigator>(() => LimitsNavigator(getIt<Txt>()));
  getIt.registerLazySingleton<BleConnectionNavigator>(() => BleConnectionNavigator(getIt<Txt>()));
  getIt.registerLazySingleton<AppNavigator>(
    () => AppNavigator(getIt<Txt>(), getIt<DialogFactory>(), getIt<BleConnectionNavigator>(), getIt<LimitsNavigator>()),
  );

  getIt.registerLazySingleton<BatteryService>(() => BatteryServiceImpl());
  getIt.registerSingleton<HeartRateService>(HeartRateServiceImpl());
  getIt.registerSingleton<LimitsRepository>(LimitsRepositoryImpl());
  getIt.registerLazySingleton<LimitsBloc>(
    () => LimitsBloc(getIt<BatteryService>(), getIt<HeartRateService>(), getIt<LimitsRepository>()),
  );

  getIt.registerLazySingleton<BleConnectionBloc>(() => BleConnectionBloc());

  getIt.registerFactory<LimitsView>(
    () => LimitsView(txt: getIt<Txt>(), navigator: getIt<LimitsNavigator>(), appNavigator: getIt<AppNavigator>()),
  );
}
