import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_monitor/features/limits/presentation/limits_event.dart';
import 'package:pulse_monitor/features/limits/presentation/limits_state.dart';

class LimitsBloc extends Bloc<LimitsEvent, LimitsState> {
  LimitsBloc(super.initialState);

  void setHeartRateStatus(Stream<int> heartRateStream){}

  void start(){}

  void stop(){}

  void connection(){} // - nav to connection view
}