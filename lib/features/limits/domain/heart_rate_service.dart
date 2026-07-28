abstract interface class HeartRateService {
  void stopHeartRateStream();

  //receiving impulses from the BLE he
  Future<Stream<int>?> getHeartRateStream();
}
