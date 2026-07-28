import 'package:equatable/equatable.dart';
import 'package:pulse_monitor/core/navigation/navigation_command.dart';

class BleConnectionState extends Equatable {
  final bool isConnected;
  final String? connectedDevice;
  final List<String>? discoveredDevices;
  final NavigationCommand? navCommand;

  const BleConnectionState({
    this.isConnected = false,
    this.connectedDevice,
    this.discoveredDevices,
    this.navCommand,
  });

  BleConnectionState copyWith({
    bool? isConnected,
    String? connectedDevice,
    List<String>? discoveredDevices,
    NavigationCommand? navCommand,
  }) {
    return BleConnectionState(
      isConnected: isConnected ?? this.isConnected,
      connectedDevice: connectedDevice ?? this.connectedDevice,
      discoveredDevices: discoveredDevices ?? this.discoveredDevices,
      navCommand: navCommand ?? this.navCommand,
    );
  }

  @override
  List<Object?> get props => [
    isConnected,
    connectedDevice,
    discoveredDevices,
    navCommand,
  ];
}