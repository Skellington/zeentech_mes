// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductionRecord _$ProductionRecordFromJson(Map<String, dynamic> json) =>
    _ProductionRecord(
      id: json['id'] as String,
      barcode: json['barcode'] as String,
      stationId: (json['stationId'] as num).toInt(),
      packerId: (json['packerId'] as num).toInt(),
      type: $enumDecode(_$ProductionTypeEnumMap, json['type']),
      volumeCount: (json['volumeCount'] as num).toInt(),
      itemCount: (json['itemCount'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      shiftId: (json['shiftId'] as num).toInt(),
      partTypeId: (json['partTypeId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductionRecordToJson(_ProductionRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'barcode': instance.barcode,
      'stationId': instance.stationId,
      'packerId': instance.packerId,
      'type': _$ProductionTypeEnumMap[instance.type]!,
      'volumeCount': instance.volumeCount,
      'itemCount': instance.itemCount,
      'timestamp': instance.timestamp.toIso8601String(),
      'shiftId': instance.shiftId,
      'partTypeId': instance.partTypeId,
    };

const _$ProductionTypeEnumMap = {
  ProductionType.national: 'national',
  ProductionType.export: 'export',
};
