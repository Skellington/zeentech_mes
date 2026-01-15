// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Station _$StationFromJson(Map<String, dynamic> json) => _Station(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      status: json['status'] as String,
      assignedPackerId1: (json['assignedPackerId1'] as num?)?.toInt(),
      assignedPackerId2: (json['assignedPackerId2'] as num?)?.toInt(),
      targetGoal: (json['targetGoal'] as num?)?.toInt() ?? 40,
    );

Map<String, dynamic> _$StationToJson(_Station instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'assignedPackerId1': instance.assignedPackerId1,
      'assignedPackerId2': instance.assignedPackerId2,
      'targetGoal': instance.targetGoal,
    };
