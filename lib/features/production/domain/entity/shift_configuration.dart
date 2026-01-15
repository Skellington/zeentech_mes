import 'package:freezed_annotation/freezed_annotation.dart';

part 'shift_configuration.freezed.dart';
part 'shift_configuration.g.dart';

@freezed
abstract class ShiftConfiguration with _$ShiftConfiguration {
  const factory ShiftConfiguration({
    required String id, // UUID or DateString
    required DateTime date,
    @Default(false) bool isExtendedMode,
    @Default(0) int shift1ManualProduction,
    @Default(600) int dailyGoal,
    @Default(40) int minStationGoal,
  }) = _ShiftConfiguration;

  factory ShiftConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ShiftConfigurationFromJson(json);
}
