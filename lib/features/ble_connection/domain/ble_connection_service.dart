abstract interface class BleConnectionService {
  Stream<String> startDiscoveringDevices();

  void stopDiscoveringDevices();

  bool connect();

  bool disconnect();
}
