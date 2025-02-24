// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.8.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `fmt`

class BatteryInfo {
  final int currentCapacity;
  final int appleRawCurrentCapacity;
  final int designCapacity;
  final int appleRawMaxCapacity;

  const BatteryInfo({
    required this.currentCapacity,
    required this.appleRawCurrentCapacity,
    required this.designCapacity,
    required this.appleRawMaxCapacity,
  });

  static Future<BatteryInfo> default_() =>
      RustLib.instance.api.crateApiEntityBatteryInfoDefault();

  @override
  int get hashCode =>
      currentCapacity.hashCode ^
      appleRawCurrentCapacity.hashCode ^
      designCapacity.hashCode ^
      appleRawMaxCapacity.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BatteryInfo &&
          runtimeType == other.runtimeType &&
          currentCapacity == other.currentCapacity &&
          appleRawCurrentCapacity == other.appleRawCurrentCapacity &&
          designCapacity == other.designCapacity &&
          appleRawMaxCapacity == other.appleRawMaxCapacity;
}

class DiskInfo {
  final String name;
  final String fileSystem;
  final String diskType;
  final String mountPoint;
  final bool removable;
  final BigInt totalSpace;
  final BigInt availableSpace;

  const DiskInfo({
    required this.name,
    required this.fileSystem,
    required this.diskType,
    required this.mountPoint,
    required this.removable,
    required this.totalSpace,
    required this.availableSpace,
  });

  @override
  int get hashCode =>
      name.hashCode ^
      fileSystem.hashCode ^
      diskType.hashCode ^
      mountPoint.hashCode ^
      removable.hashCode ^
      totalSpace.hashCode ^
      availableSpace.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiskInfo &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          fileSystem == other.fileSystem &&
          diskType == other.diskType &&
          mountPoint == other.mountPoint &&
          removable == other.removable &&
          totalSpace == other.totalSpace &&
          availableSpace == other.availableSpace;
}

class SystemInfo {
  final String? hostName;
  final String? userName;
  final String cpuModel;
  final int numberOfCpus;
  final String? systemName;
  final String? kernelVersion;
  final String? osVersion;
  final BigInt totalMemory;
  final BigInt totalSwap;
  final String? sipStatus;
  final String? timeSinceBoot;
  final List<DiskInfo> diskInfos;
  final BatteryInfo batteryInfo;

  const SystemInfo({
    this.hostName,
    this.userName,
    required this.cpuModel,
    required this.numberOfCpus,
    this.systemName,
    this.kernelVersion,
    this.osVersion,
    required this.totalMemory,
    required this.totalSwap,
    this.sipStatus,
    this.timeSinceBoot,
    required this.diskInfos,
    required this.batteryInfo,
  });

  @override
  int get hashCode =>
      hostName.hashCode ^
      userName.hashCode ^
      cpuModel.hashCode ^
      numberOfCpus.hashCode ^
      systemName.hashCode ^
      kernelVersion.hashCode ^
      osVersion.hashCode ^
      totalMemory.hashCode ^
      totalSwap.hashCode ^
      sipStatus.hashCode ^
      timeSinceBoot.hashCode ^
      diskInfos.hashCode ^
      batteryInfo.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SystemInfo &&
          runtimeType == other.runtimeType &&
          hostName == other.hostName &&
          userName == other.userName &&
          cpuModel == other.cpuModel &&
          numberOfCpus == other.numberOfCpus &&
          systemName == other.systemName &&
          kernelVersion == other.kernelVersion &&
          osVersion == other.osVersion &&
          totalMemory == other.totalMemory &&
          totalSwap == other.totalSwap &&
          sipStatus == other.sipStatus &&
          timeSinceBoot == other.timeSinceBoot &&
          diskInfos == other.diskInfos &&
          batteryInfo == other.batteryInfo;
}
