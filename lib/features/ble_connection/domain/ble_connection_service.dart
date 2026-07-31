abstract interface class BleConnectionService {
  Stream<String>? discoveredSensors;

  Future<void> startDiscoveringHeartRateSensors();

  Future<String> stopDiscoveringHeartRateSensors();

  bool connect();

  bool disconnect();
}
