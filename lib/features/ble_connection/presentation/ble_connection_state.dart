import 'package:equatable/equatable.dart';
import 'package:pulse_monitor/core/navigation/navigation_command.dart';

class BleConnectionState extends Equatable {
  final bool isConnected;
  final Map<String, String> discoveredSensors;
  final String? connectedDevice;
  final NavigationCommand? navCommand;

  const BleConnectionState({
    this.isConnected = false,
    this.connectedDevice,
    this.discoveredSensors = const {},
    this.navCommand,
  });

  BleConnectionState copyWith({
    bool? isConnected,
    Map<String, String>? discoveredSensors,
    String? connectedDevice,
    NavigationCommand? navCommand,
  }) {
    return BleConnectionState(
      isConnected: isConnected ?? this.isConnected,
      discoveredSensors: discoveredSensors ?? this.discoveredSensors,
      connectedDevice: connectedDevice ?? this.connectedDevice,
      navCommand: navCommand ?? this.navCommand,
    );
  }

  @override
  List<Object?> get props => [
    isConnected,
    discoveredSensors,
    connectedDevice,
    navCommand,
  ];
}