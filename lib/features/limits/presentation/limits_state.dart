import 'package:equatable/equatable.dart';
import 'package:pulse_monitor/core/navigation/navigation_command.dart';

enum HeartRateStatus { none, tooLow, ok, tooHigh }

class LimitsState extends Equatable {
  final String? batteryLevel;
  final String? connectedBleSensor;
  final List<String>? savedLimits;
  final int? lowerLimit;
  final int? upperLimit;
  final HeartRateStatus heartRateStatus;
  final NavigationCommand? navCommand;

  const LimitsState({
    this.batteryLevel,
    this.connectedBleSensor,
    this.savedLimits,
    this.lowerLimit,
    this.upperLimit,
    this.heartRateStatus = HeartRateStatus.none,
    this.navCommand,
  });

  LimitsState copyWith({
    String? batteryLevel,
    String? connectedBleSensor,
    List<String>? savedLimits,
    int? lowerLimit,
    int? upperLimit,
    HeartRateStatus? heartRateStatus,
    NavigationCommand? navCommand,
  }) {
    return LimitsState(
      batteryLevel: batteryLevel ?? this.batteryLevel,
      connectedBleSensor: connectedBleSensor ?? this.connectedBleSensor,
      savedLimits: savedLimits ?? this.savedLimits,
      lowerLimit: lowerLimit ?? this.lowerLimit,
      upperLimit: upperLimit ?? this.upperLimit,
      heartRateStatus: heartRateStatus ?? this.heartRateStatus,
      navCommand: navCommand ?? this.navCommand,
    );
  }

  @override
  List<Object?> get props => [
    batteryLevel,
    connectedBleSensor,
    savedLimits,
    lowerLimit,
    upperLimit,
    heartRateStatus,
    navCommand,
  ];
}