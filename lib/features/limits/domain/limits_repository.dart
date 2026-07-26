abstract interface class LimitsRepository {
  List<String> getSavedLimits();

  void saveLimits();

  void removeLimits();
}