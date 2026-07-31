sealed class BleConnectionEvent {
  const BleConnectionEvent();
}

class ShowLimitsViewEvent extends BleConnectionEvent {}

class DiscoverSensorsEvent extends BleConnectionEvent {}

class ConnectSensorEvent extends BleConnectionEvent {
  final String device;

  const ConnectSensorEvent(this.device);
}

class DisconnectSensorEvent extends BleConnectionEvent {
  final String device;

  const DisconnectSensorEvent(this.device);
}
