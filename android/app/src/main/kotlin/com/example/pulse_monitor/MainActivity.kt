package com.example.pulse_monitor

import android.Manifest
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.os.BatteryManager
import android.os.Build
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.stream.Stream


class MainActivity : FlutterActivity() {
    private val BLE_CONNECTION_CHANNEL = "ble_connection_channel"  // For method calls (start/stop scan)
    private val BLE_EVENT_CHANNEL = "ble_event_channel"  // For real-time device updates
    private val BATTERY_CHANNEL = "battery_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            BATTERY_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getBatteryLevel" -> getBattery(result)
                "discoverDevices" -> discoverDevices()
                else -> result.notImplemented()
            }
        }
    }

    private fun getBattery(result: MethodChannel.Result) {
        val batteryLevel = getBatteryLevel()

        if (batteryLevel != -1) {
            result.success(batteryLevel)
        } else {
            result.error("UNAVAILABLE", "Battery level not available.", null)
        }
    }


    private fun getBatteryLevel(): Int {
        val intent = ContextWrapper(applicationContext).registerReceiver(
            null,
            IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        )
        val batteryLevel: Int =
            intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(
                BatteryManager.EXTRA_SCALE,
                -1
            )

        return batteryLevel
    }

    private fun discoverDevices(): Stream<String>? {
        if (!checkPermissions()) {
            return null
        }
        throw NotImplementedError("implement: discoverDevices()")
    }


//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        MethodChannel(
//            flutterEngine.dartExecutor.binaryMessenger,
//            CHANNEL
//        ).setMethodCallHandler { call, result ->
//            when (call.method) {
//                "startScan" -> handleStartScan(result)
//                "stopScan" -> handleStopScan(result)
//                "getPairedDevices" -> handleGetPairedDevices(result)
//                else -> result.notImplemented()
//            }
//        }
//
//        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL).setStreamHandler(
//            object : EventChannel.StreamHandler {
//                override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
//                    eventSink = events  // Save the "stream pipe" to send data
//                }
//                override fun onCancel(arguments: Any?) {
//                    eventSink = null  // Close the pipe when done
//                }
//            }
//        )
//    }

    private fun checkPermissions(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // Android 12+ needs these
            hasPermission(Manifest.permission.BLUETOOTH_SCAN) &&
                    hasPermission(Manifest.permission.BLUETOOTH_CONNECT)
        } else {
            // Older Androids need these
            hasPermission(Manifest.permission.ACCESS_FINE_LOCATION) &&
                    hasPermission(Manifest.permission.BLUETOOTH) &&
                    hasPermission(Manifest.permission.BLUETOOTH_ADMIN)
        }
    }
//
//    private fun handleStartScan(result: MethodChannel.Result) {
//        if (checkPermissions()) {
//            executor.execute {  // Run in background thread
//                startBluetoothScan()
//                runOnUiThread { result.success(true) } // Tell Flutter "OK!"
//            }
//        } else {
//            result.error("PERMISSION_DENIED", "Oops, no permissions!", null)
//        }
//    }
//
//    private fun startBluetoothScan() {
//        if (!isScanning) {
//            isScanning = true
//            runOnUiThread {
//                // Show already paired devices first
//                bluetoothAdapter?.bondedDevices?.forEach { device ->
//                    eventSink?.success("DEVICE_FOUND|PAIRED|${device.name}|${device.address}")
//                }
//                // Listen for new devices
//                registerReceiver(receiver, IntentFilter().apply {
//                    addAction(BluetoothDevice.ACTION_FOUND)
//                    addAction(BluetoothAdapter.ACTION_DISCOVERY_FINISHED)
//                })
//            }
//            bluetoothAdapter?.startDiscovery() // Start scanning!
//        }
//    }
//    private val receiver = object : BroadcastReceiver() {
//        override fun onReceive(context: Context, intent: Intent) {
//            when(intent.action) {
//                BluetoothDevice.ACTION_FOUND -> handleDeviceFound(intent)
//                BluetoothAdapter.ACTION_DISCOVERY_FINISHED -> handleScanFinished()
//            }
//        }
//    }
//
//    private fun handleDeviceFound(intent: Intent) {
//        val device: BluetoothDevice? = intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE)
//        device?.let {
//            runOnUiThread {
//                val name = getDeviceName(it)  // Get readable name
//                val address = it.address      // Unique MAC address
//                eventSink?.success("DEVICE_FOUND|DISCOVERED|$name|$address")
//            }
//        }
//    }
//
//    private fun handleStopScan(result: MethodChannel.Result) {
//        stopBluetoothScan()
//        runOnUiThread { result.success(true) }
//    }
//
//    private fun stopBluetoothScan() {
//        if (isScanning) {
//            bluetoothAdapter?.cancelDiscovery()  // Stop scanning
//            runOnUiThread {
//                try {
//                    unregisterReceiver(receiver) // Stop listening
//                } catch (e: IllegalArgumentException) {}
//                eventSink?.success("SCAN_STOPPED")
//                isScanning = false
//            }
//        }
//    }
//
//    private fun handleGetPairedDevices(result: MethodChannel.Result) {
//        val pairedDevices = getPairedDevices()
//        result.success(pairedDevices)
//    }
//
//    private fun getPairedDevices(): List<String> {
//        return bluetoothAdapter?.bondedDevices?.map { it.name ?: "Unnamed Device" } ?: emptyList()
//    }

    public fun hasPermission(permission: String): Boolean {
        return checkSelfPermission(permission) == PackageManager.PERMISSION_GRANTED
    }
}
