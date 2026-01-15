// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'downtime_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DowntimeRecord {
  String get id; // UUID
  int get stationId;
  DateTime get startTime;
  DateTime? get endTime;
  String? get reasonStart;
  String? get reasonEnd;
  int get durationMinutes;

  /// Create a copy of DowntimeRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DowntimeRecordCopyWith<DowntimeRecord> get copyWith =>
      _$DowntimeRecordCopyWithImpl<DowntimeRecord>(
          this as DowntimeRecord, _$identity);

  /// Serializes this DowntimeRecord to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DowntimeRecord &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.stationId, stationId) ||
                other.stationId == stationId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.reasonStart, reasonStart) ||
                other.reasonStart == reasonStart) &&
            (identical(other.reasonEnd, reasonEnd) ||
                other.reasonEnd == reasonEnd) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, stationId, startTime,
      endTime, reasonStart, reasonEnd, durationMinutes);

  @override
  String toString() {
    return 'DowntimeRecord(id: $id, stationId: $stationId, startTime: $startTime, endTime: $endTime, reasonStart: $reasonStart, reasonEnd: $reasonEnd, durationMinutes: $durationMinutes)';
  }
}

/// @nodoc
abstract mixin class $DowntimeRecordCopyWith<$Res> {
  factory $DowntimeRecordCopyWith(
          DowntimeRecord value, $Res Function(DowntimeRecord) _then) =
      _$DowntimeRecordCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      int stationId,
      DateTime startTime,
      DateTime? endTime,
      String? reasonStart,
      String? reasonEnd,
      int durationMinutes});
}

/// @nodoc
class _$DowntimeRecordCopyWithImpl<$Res>
    implements $DowntimeRecordCopyWith<$Res> {
  _$DowntimeRecordCopyWithImpl(this._self, this._then);

  final DowntimeRecord _self;
  final $Res Function(DowntimeRecord) _then;

  /// Create a copy of DowntimeRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? stationId = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? reasonStart = freezed,
    Object? reasonEnd = freezed,
    Object? durationMinutes = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      stationId: null == stationId
          ? _self.stationId
          : stationId // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reasonStart: freezed == reasonStart
          ? _self.reasonStart
          : reasonStart // ignore: cast_nullable_to_non_nullable
              as String?,
      reasonEnd: freezed == reasonEnd
          ? _self.reasonEnd
          : reasonEnd // ignore: cast_nullable_to_non_nullable
              as String?,
      durationMinutes: null == durationMinutes
          ? _self.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [DowntimeRecord].
extension DowntimeRecordPatterns on DowntimeRecord {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DowntimeRecord value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DowntimeRecord() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DowntimeRecord value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DowntimeRecord():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DowntimeRecord value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DowntimeRecord() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            int stationId,
            DateTime startTime,
            DateTime? endTime,
            String? reasonStart,
            String? reasonEnd,
            int durationMinutes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DowntimeRecord() when $default != null:
        return $default(
            _that.id,
            _that.stationId,
            _that.startTime,
            _that.endTime,
            _that.reasonStart,
            _that.reasonEnd,
            _that.durationMinutes);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            int stationId,
            DateTime startTime,
            DateTime? endTime,
            String? reasonStart,
            String? reasonEnd,
            int durationMinutes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DowntimeRecord():
        return $default(
            _that.id,
            _that.stationId,
            _that.startTime,
            _that.endTime,
            _that.reasonStart,
            _that.reasonEnd,
            _that.durationMinutes);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            int stationId,
            DateTime startTime,
            DateTime? endTime,
            String? reasonStart,
            String? reasonEnd,
            int durationMinutes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DowntimeRecord() when $default != null:
        return $default(
            _that.id,
            _that.stationId,
            _that.startTime,
            _that.endTime,
            _that.reasonStart,
            _that.reasonEnd,
            _that.durationMinutes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DowntimeRecord implements DowntimeRecord {
  const _DowntimeRecord(
      {required this.id,
      required this.stationId,
      required this.startTime,
      this.endTime,
      this.reasonStart,
      this.reasonEnd,
      this.durationMinutes = 0});
  factory _DowntimeRecord.fromJson(Map<String, dynamic> json) =>
      _$DowntimeRecordFromJson(json);

  @override
  final String id;
// UUID
  @override
  final int stationId;
  @override
  final DateTime startTime;
  @override
  final DateTime? endTime;
  @override
  final String? reasonStart;
  @override
  final String? reasonEnd;
  @override
  @JsonKey()
  final int durationMinutes;

  /// Create a copy of DowntimeRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DowntimeRecordCopyWith<_DowntimeRecord> get copyWith =>
      __$DowntimeRecordCopyWithImpl<_DowntimeRecord>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DowntimeRecordToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DowntimeRecord &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.stationId, stationId) ||
                other.stationId == stationId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.reasonStart, reasonStart) ||
                other.reasonStart == reasonStart) &&
            (identical(other.reasonEnd, reasonEnd) ||
                other.reasonEnd == reasonEnd) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, stationId, startTime,
      endTime, reasonStart, reasonEnd, durationMinutes);

  @override
  String toString() {
    return 'DowntimeRecord(id: $id, stationId: $stationId, startTime: $startTime, endTime: $endTime, reasonStart: $reasonStart, reasonEnd: $reasonEnd, durationMinutes: $durationMinutes)';
  }
}

/// @nodoc
abstract mixin class _$DowntimeRecordCopyWith<$Res>
    implements $DowntimeRecordCopyWith<$Res> {
  factory _$DowntimeRecordCopyWith(
          _DowntimeRecord value, $Res Function(_DowntimeRecord) _then) =
      __$DowntimeRecordCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      int stationId,
      DateTime startTime,
      DateTime? endTime,
      String? reasonStart,
      String? reasonEnd,
      int durationMinutes});
}

/// @nodoc
class __$DowntimeRecordCopyWithImpl<$Res>
    implements _$DowntimeRecordCopyWith<$Res> {
  __$DowntimeRecordCopyWithImpl(this._self, this._then);

  final _DowntimeRecord _self;
  final $Res Function(_DowntimeRecord) _then;

  /// Create a copy of DowntimeRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? stationId = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? reasonStart = freezed,
    Object? reasonEnd = freezed,
    Object? durationMinutes = null,
  }) {
    return _then(_DowntimeRecord(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      stationId: null == stationId
          ? _self.stationId
          : stationId // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reasonStart: freezed == reasonStart
          ? _self.reasonStart
          : reasonStart // ignore: cast_nullable_to_non_nullable
              as String?,
      reasonEnd: freezed == reasonEnd
          ? _self.reasonEnd
          : reasonEnd // ignore: cast_nullable_to_non_nullable
              as String?,
      durationMinutes: null == durationMinutes
          ? _self.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
