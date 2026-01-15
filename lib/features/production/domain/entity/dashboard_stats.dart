import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_stats.freezed.dart';

@freezed
abstract class DashboardStats with _$DashboardStats {
  const factory DashboardStats({
    required int totalVolume,
    required int totalItems,
    required double itemsPerHour,
  }) = _DashboardStats;
}
