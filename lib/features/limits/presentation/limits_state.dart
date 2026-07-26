import 'package:equatable/equatable.dart';

enum HeartRateStatus { none, tooLow, ok, tooHigh }

class LimitsState extends Equatable {
  final List<String> savedLimits;
  final HeartRateStatus heartRateStatus;

  const LimitsState({
    required this.savedLimits,
    required this.heartRateStatus,
  });

  LimitsState copyWith({
    List<String>? savedLimits,
    HeartRateStatus? heartRateStatus,
  }) {
    return LimitsState(
      savedLimits: savedLimits ?? this.savedLimits,
      heartRateStatus: heartRateStatus ?? this.heartRateStatus,
    );
  }

  @override
  List<Object?> get props => [
    savedLimits,
    heartRateStatus,
  ];
}