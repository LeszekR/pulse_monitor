sealed class LimitsEvent {
  const LimitsEvent();
}

class CheckBatteryLevelEvent extends LimitsEvent {}

class ConnectSensorEvent extends LimitsEvent {}

class SaveLimitsEvent extends LimitsEvent {}

class StartMonitoringEvent extends LimitsEvent {}

class StopMonitoringEvent extends LimitsEvent {}

class ShowBleConnectionEvent extends LimitsEvent {}

class SetLowerLimitEvent extends LimitsEvent {
  final String limit;

  const SetLowerLimitEvent(this.limit);
}

class SetUpperLimitEvent extends LimitsEvent {
  final String limit;

  const SetUpperLimitEvent(this.limit);
}

class HeartRateReceivedEvent extends LimitsEvent {
  final int heartRate;

  const HeartRateReceivedEvent(this.heartRate);
}
