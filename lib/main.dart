import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_monitor/core/get_it/get_it.dart';
import 'package:pulse_monitor/core/ui_localized_texts/app_localizations/app_localizations.dart';
import 'package:pulse_monitor/core/ui_localized_texts/app_localizations/txt.dart';
import 'package:pulse_monitor/features/ble_connection/presentation/ble_connection_bloc.dart';
import 'package:pulse_monitor/features/limits/presentation/limits_bloc.dart';
import 'package:pulse_monitor/features/limits/presentation/limits_view.dart';

void main() {
  initGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LimitsBloc>()),
        BlocProvider(create: (context) => getIt<BleConnectionBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('pl'),
        // theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: Builder(
          builder: (context) {
            getIt<Txt>().setLanguage(context);
            return Scaffold(body: getIt<LimitsView>());
          },
        ),
      ),
    );
  }
}
