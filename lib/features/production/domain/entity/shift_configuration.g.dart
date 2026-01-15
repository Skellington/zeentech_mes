// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShiftConfiguration _$ShiftConfigurationFromJson(Map<String, dynamic> json) =>
    _ShiftConfiguration(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      isExtendedMode: json['isExtendedMode'] as bool? ?? false,
      shift1ManualProduction:
          (json['shift1ManualProduction'] as num?)?.toInt() ?? 0,
      dailyGoal: (json['dailyGoal'] as num?)?.toInt() ?? 600,
      minStationGoal: (json['minStationGoal'] as num?)?.toInt() ?? 40,
    );

Map<String, dynamic> _$ShiftConfigurationToJson(_ShiftConfiguration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'isExtendedMode': instance.isExtendedMode,
      'shift1ManualProduction': instance.shift1ManualProduction,
      'dailyGoal': instance.dailyGoal,
      'minStationGoal': instance.minStationGoal,
    };
