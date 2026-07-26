import 'package:equatable/equatable.dart';

class BleConnectionState extends Equatable {
  final bool isConnected;
  final String connectedDevice;
  final List<String> discoveredDevices;

  const BleConnectionState({
    required this.isConnected,
    required this.connectedDevice,
    required this.discoveredDevices,
  });

  BleConnectionState copyWith({
    bool? isConnected,
    String? connectedDevice,
    List<String>? discoveredDevices,
  }) {
    return BleConnectionState(
      isConnected: isConnected ?? this.isConnected,
      connectedDevice: connectedDevice ?? this.connectedDevice,
      discoveredDevices: discoveredDevices ?? this.discoveredDevices,
    );
  }

  @override
  List<Object?> get props => [
    isConnected,
    connectedDevice,
    discoveredDevices,
  ];
}