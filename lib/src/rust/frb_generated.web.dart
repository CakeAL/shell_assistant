// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.8.0.

// ignore_for_file: unused_import, unused_element, unnecessary_import, duplicate_ignore, invalid_use_of_internal_member, annotate_overrides, non_constant_identifier_names, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, unused_field

// Static analysis wrongly picks the IO variant, thus ignore this
// ignore_for_file: argument_type_not_assignable

import 'api/command.dart';
import 'api/entity.dart';
import 'api/read_value.dart';
import 'api/updater.dart';
import 'dart:async';
import 'dart:convert';
import 'frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated_web.dart';

abstract class RustLibApiImplPlatform extends BaseApiImpl<RustLibWire> {
  RustLibApiImplPlatform({
    required super.handler,
    required super.wire,
    required super.generalizedFrbRustBinding,
    required super.portManager,
  });

  @protected
  AnyhowException dco_decode_AnyhowException(dynamic raw);

  @protected
  FutureOr<void> Function(ReleaseInfo?)
      dco_decode_DartFn_Inputs_opt_box_autoadd_release_info_Output_unit_AnyhowException(
          dynamic raw);

  @protected
  Object dco_decode_DartOpaque(dynamic raw);

  @protected
  Map<int, String> dco_decode_Map_i_32_String(dynamic raw);

  @protected
  String dco_decode_String(dynamic raw);

  @protected
  BatteryInfo dco_decode_battery_info(dynamic raw);

  @protected
  bool dco_decode_bool(dynamic raw);

  @protected
  double dco_decode_box_autoadd_f_64(dynamic raw);

  @protected
  ReleaseInfo dco_decode_box_autoadd_release_info(dynamic raw);

  @protected
  int dco_decode_box_autoadd_u_8(dynamic raw);

  @protected
  DiskInfo dco_decode_disk_info(dynamic raw);

  @protected
  double dco_decode_f_64(dynamic raw);

  @protected
  int dco_decode_i_32(dynamic raw);

  @protected
  PlatformInt64 dco_decode_isize(dynamic raw);

  @protected
  List<bool> dco_decode_list_bool(dynamic raw);

  @protected
  List<DiskInfo> dco_decode_list_disk_info(dynamic raw);

  @protected
  Uint8List dco_decode_list_prim_u_8_strict(dynamic raw);

  @protected
  List<(int, String)> dco_decode_list_record_i_32_string(dynamic raw);

  @protected
  String? dco_decode_opt_String(dynamic raw);

  @protected
  double? dco_decode_opt_box_autoadd_f_64(dynamic raw);

  @protected
  ReleaseInfo? dco_decode_opt_box_autoadd_release_info(dynamic raw);

  @protected
  int? dco_decode_opt_box_autoadd_u_8(dynamic raw);

  @protected
  (int, String) dco_decode_record_i_32_string(dynamic raw);

  @protected
  ReleaseInfo dco_decode_release_info(dynamic raw);

  @protected
  SystemInfo dco_decode_system_info(dynamic raw);

  @protected
  BigInt dco_decode_u_64(dynamic raw);

  @protected
  int dco_decode_u_8(dynamic raw);

  @protected
  void dco_decode_unit(dynamic raw);

  @protected
  BigInt dco_decode_usize(dynamic raw);

  @protected
  AnyhowException sse_decode_AnyhowException(SseDeserializer deserializer);

  @protected
  Object sse_decode_DartOpaque(SseDeserializer deserializer);

  @protected
  Map<int, String> sse_decode_Map_i_32_String(SseDeserializer deserializer);

  @protected
  String sse_decode_String(SseDeserializer deserializer);

  @protected
  BatteryInfo sse_decode_battery_info(SseDeserializer deserializer);

  @protected
  bool sse_decode_bool(SseDeserializer deserializer);

  @protected
  double sse_decode_box_autoadd_f_64(SseDeserializer deserializer);

  @protected
  ReleaseInfo sse_decode_box_autoadd_release_info(SseDeserializer deserializer);

  @protected
  int sse_decode_box_autoadd_u_8(SseDeserializer deserializer);

  @protected
  DiskInfo sse_decode_disk_info(SseDeserializer deserializer);

  @protected
  double sse_decode_f_64(SseDeserializer deserializer);

  @protected
  int sse_decode_i_32(SseDeserializer deserializer);

  @protected
  PlatformInt64 sse_decode_isize(SseDeserializer deserializer);

  @protected
  List<bool> sse_decode_list_bool(SseDeserializer deserializer);

  @protected
  List<DiskInfo> sse_decode_list_disk_info(SseDeserializer deserializer);

  @protected
  Uint8List sse_decode_list_prim_u_8_strict(SseDeserializer deserializer);

  @protected
  List<(int, String)> sse_decode_list_record_i_32_string(
      SseDeserializer deserializer);

  @protected
  String? sse_decode_opt_String(SseDeserializer deserializer);

  @protected
  double? sse_decode_opt_box_autoadd_f_64(SseDeserializer deserializer);

  @protected
  ReleaseInfo? sse_decode_opt_box_autoadd_release_info(
      SseDeserializer deserializer);

  @protected
  int? sse_decode_opt_box_autoadd_u_8(SseDeserializer deserializer);

  @protected
  (int, String) sse_decode_record_i_32_string(SseDeserializer deserializer);

  @protected
  ReleaseInfo sse_decode_release_info(SseDeserializer deserializer);

  @protected
  SystemInfo sse_decode_system_info(SseDeserializer deserializer);

  @protected
  BigInt sse_decode_u_64(SseDeserializer deserializer);

  @protected
  int sse_decode_u_8(SseDeserializer deserializer);

  @protected
  void sse_decode_unit(SseDeserializer deserializer);

  @protected
  BigInt sse_decode_usize(SseDeserializer deserializer);

  @protected
  void sse_encode_AnyhowException(
      AnyhowException self, SseSerializer serializer);

  @protected
  void
      sse_encode_DartFn_Inputs_opt_box_autoadd_release_info_Output_unit_AnyhowException(
          FutureOr<void> Function(ReleaseInfo?) self, SseSerializer serializer);

  @protected
  void sse_encode_DartOpaque(Object self, SseSerializer serializer);

  @protected
  void sse_encode_Map_i_32_String(
      Map<int, String> self, SseSerializer serializer);

  @protected
  void sse_encode_String(String self, SseSerializer serializer);

  @protected
  void sse_encode_battery_info(BatteryInfo self, SseSerializer serializer);

  @protected
  void sse_encode_bool(bool self, SseSerializer serializer);

  @protected
  void sse_encode_box_autoadd_f_64(double self, SseSerializer serializer);

  @protected
  void sse_encode_box_autoadd_release_info(
      ReleaseInfo self, SseSerializer serializer);

  @protected
  void sse_encode_box_autoadd_u_8(int self, SseSerializer serializer);

  @protected
  void sse_encode_disk_info(DiskInfo self, SseSerializer serializer);

  @protected
  void sse_encode_f_64(double self, SseSerializer serializer);

  @protected
  void sse_encode_i_32(int self, SseSerializer serializer);

  @protected
  void sse_encode_isize(PlatformInt64 self, SseSerializer serializer);

  @protected
  void sse_encode_list_bool(List<bool> self, SseSerializer serializer);

  @protected
  void sse_encode_list_disk_info(List<DiskInfo> self, SseSerializer serializer);

  @protected
  void sse_encode_list_prim_u_8_strict(
      Uint8List self, SseSerializer serializer);

  @protected
  void sse_encode_list_record_i_32_string(
      List<(int, String)> self, SseSerializer serializer);

  @protected
  void sse_encode_opt_String(String? self, SseSerializer serializer);

  @protected
  void sse_encode_opt_box_autoadd_f_64(double? self, SseSerializer serializer);

  @protected
  void sse_encode_opt_box_autoadd_release_info(
      ReleaseInfo? self, SseSerializer serializer);

  @protected
  void sse_encode_opt_box_autoadd_u_8(int? self, SseSerializer serializer);

  @protected
  void sse_encode_record_i_32_string(
      (int, String) self, SseSerializer serializer);

  @protected
  void sse_encode_release_info(ReleaseInfo self, SseSerializer serializer);

  @protected
  void sse_encode_system_info(SystemInfo self, SseSerializer serializer);

  @protected
  void sse_encode_u_64(BigInt self, SseSerializer serializer);

  @protected
  void sse_encode_u_8(int self, SseSerializer serializer);

  @protected
  void sse_encode_unit(void self, SseSerializer serializer);

  @protected
  void sse_encode_usize(BigInt self, SseSerializer serializer);
}

// Section: wire_class

class RustLibWire implements BaseWire {
  RustLibWire.fromExternalLibrary(ExternalLibrary lib);
}

@JS('wasm_bindgen')
external RustLibWasmModule get wasmModule;

@JS()
@anonymous
extension type RustLibWasmModule._(JSObject _) implements JSObject {}
