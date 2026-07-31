typedef DiscoveryEventHandler = void Function(String);
typedef HeartBeatEventHandler = void Function(int);

abstract interface class HeartRateService {
  Future<Stream<int>?> startHeartRateStream();

  void stopHeartRateStream();
}
