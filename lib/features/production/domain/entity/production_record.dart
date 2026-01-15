import 'package:freezed_annotation/freezed_annotation.dart';

part 'production_record.freezed.dart';
part 'production_record.g.dart';

enum ProductionType { national, export }

@freezed
abstract class ProductionRecord with _$ProductionRecord {
  const factory ProductionRecord({
    required String id, // UUID
    required String barcode,
    required int stationId,
    required int packerId,
    required ProductionType type,
    required int volumeCount,
    required int itemCount,
    required DateTime timestamp,
    required int shiftId,
    int? partTypeId, // Nullable for compatibility
  }) = _ProductionRecord;

  factory ProductionRecord.fromJson(Map<String, dynamic> json) =>
      _$ProductionRecordFromJson(json);
}
