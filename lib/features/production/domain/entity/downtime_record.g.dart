// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downtime_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DowntimeRecord _$DowntimeRecordFromJson(Map<String, dynamic> json) =>
    _DowntimeRecord(
      id: json['id'] as String,
      stationId: (json['stationId'] as num).toInt(),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      reasonStart: json['reasonStart'] as String?,
      reasonEnd: json['reasonEnd'] as String?,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$DowntimeRecordToJson(_DowntimeRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stationId': instance.stationId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'reasonStart': instance.reasonStart,
      'reasonEnd': instance.reasonEnd,
      'durationMinutes': instance.durationMinutes,
    };
