import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_monitor/core/navigation/app_nav_commands.dart';
import 'package:pulse_monitor/features/limits/domain/heart_rate_service.dart';
import 'package:pulse_monitor/features/limits/domain/limits_repository.dart';
import 'package:pulse_monitor/features/limits/presentation/limits_event.dart';
import 'package:pulse_monitor/features/limits/presentation/limits_state.dart';
import 'package:pulse_monitor/ui_components/dialogs/e_dialog_msg.dart';

class LimitsBloc extends Bloc<LimitsEvent, LimitsState> {
  final HeartRateService heartRateService;
  final LimitsRepository limitsRepository;
  StreamSubscription<int>? _subscription;

  LimitsBloc(this.heartRateService, this.limitsRepository) : super(LimitsState()) {
    on<StartMonitoringEvent>(_startMonitoring);
    on<StopMonitoringEvent>(_stopMonitoring);
    on<ShowBleConnectionEvent>(_showBleConnection);
    on<SetLowerLimitEvent>(_setLowerLimit);
    on<SetUpperLimitEvent>(_setUpperLimit);
    on<HeartRateReceivedEvent>(_showHeartRateStatus);
  }

  Future<void> _saveLimits(SaveLimitsEvent event, Emitter<LimitsState> emit) async {
    throw UnimplementedError('implement _saveLimits()');
  }

  Future<void> _startMonitoring(StartMonitoringEvent event, Emitter<LimitsState> emit) async {
    if (state.lowerLimit == null || state.upperLimit == null) {
      emit(state.copyWith(navCommand: NavMessageDialog(EDialogMsg.limitsNotSet)));
      return;
    }

    // timer to quit if no stream provided
    Stream<int>? heartRateStream = await heartRateService.getHeartRateStream().timeout(Duration(seconds: 3));

    // timer to quit if the stream is empty
    Timer timer = Timer(Duration(seconds: 3), () {
      _stop(emit);
    });

    if (heartRateStream == null) {
      emit(state.copyWith(heartRateStatus: HeartRateStatus.none));
      return;
    }

    _stop(emit);
    _subscription = heartRateStream.listen(
      (int heartRate) {
        timer.cancel();
        add(HeartRateReceivedEvent(heartRate));
      },
      onError: (Object e) {
        emit(state.copyWith(navCommand: NavErrorDialog(e as Exception)));
      },
    );
  }

  Future<void> _showHeartRateStatus(HeartRateReceivedEvent event, Emitter<LimitsState> emit) async {
    final HeartRateStatus oldHeartRateStatus = state.heartRateStatus;
    HeartRateStatus newHeartRateStatus;

    if (event.heartRate < state.lowerLimit!) {
      newHeartRateStatus = HeartRateStatus.tooLow;
    } else if (event.heartRate > state.upperLimit!) {
      newHeartRateStatus = HeartRateStatus.tooHigh;
    } else {
      newHeartRateStatus = HeartRateStatus.ok;
    }

    if (oldHeartRateStatus != newHeartRateStatus) {
      emit(state.copyWith(heartRateStatus: newHeartRateStatus));
    }
  }

  void _stopMonitoring(StopMonitoringEvent event, Emitter<LimitsState> emit) {
    _stop(emit);
  }

  void _stop(Emitter<LimitsState> emit) {
    if (_subscription != null) _subscription!.cancel();
    emit(state.copyWith(heartRateStatus: HeartRateStatus.none));
  }

  Future<void> _showBleConnection(ShowBleConnectionEvent event, Emitter<LimitsState> emit) async {
    emit(state.copyWith(navCommand: NavBleConnection()));
  }

  Future<void> _setLowerLimit(SetLowerLimitEvent event, Emitter<LimitsState> emit) async {
    emit(state.copyWith(lowerLimit: int.parse(event.limit)));
  }

  Future<void> _setUpperLimit(SetUpperLimitEvent event, Emitter<LimitsState> emit) async {
    emit(state.copyWith(upperLimit: int.parse(event.limit)));
  }
}
