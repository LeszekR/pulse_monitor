abstract interface class HeartRateService {
  Future<String> connectHeartRateSensor();

  Future<Stream<int>?> getHeartRateStream();

  void stopHeartRateStream();
}
