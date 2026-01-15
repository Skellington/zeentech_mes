import 'package:freezed_annotation/freezed_annotation.dart';

part 'downtime_record.freezed.dart';
part 'downtime_record.g.dart';

@freezed
abstract class DowntimeRecord with _$DowntimeRecord {
  const factory DowntimeRecord({
    required String id, // UUID
    required int stationId,
    required DateTime startTime,
    DateTime? endTime,
    String? reasonStart,
    String? reasonEnd,
    @Default(0) int durationMinutes,
  }) = _DowntimeRecord;

  factory DowntimeRecord.fromJson(Map<String, dynamic> json) =>
      _$DowntimeRecordFromJson(json);
}
