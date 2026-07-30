abstract interface class HeartRateService {
  Future<String> startDiscoveringHeartRateSensors();

  Future<String> stopDiscoveringHeartRateSensors();

  Future<Stream<int>?> startHeartRateStream();

  void stopHeartRateStream();
}
