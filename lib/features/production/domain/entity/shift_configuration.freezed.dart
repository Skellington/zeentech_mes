// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShiftConfiguration {
  String get id; // UUID or DateString
  DateTime get date;
  bool get isExtendedMode;
  int get shift1ManualProduction;
  int get dailyGoal;
  int get minStationGoal;

  /// Create a copy of ShiftConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShiftConfigurationCopyWith<ShiftConfiguration> get copyWith =>
      _$ShiftConfigurationCopyWithImpl<ShiftConfiguration>(
          this as ShiftConfiguration, _$identity);

  /// Serializes this ShiftConfiguration to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShiftConfiguration &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isExtendedMode, isExtendedMode) ||
                other.isExtendedMode == isExtendedMode) &&
            (identical(other.shift1ManualProduction, shift1ManualProduction) ||
                other.shift1ManualProduction == shift1ManualProduction) &&
            (identical(other.dailyGoal, dailyGoal) ||
                other.dailyGoal == dailyGoal) &&
            (identical(other.minStationGoal, minStationGoal) ||
                other.minStationGoal == minStationGoal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, isExtendedMode,
      shift1ManualProduction, dailyGoal, minStationGoal);

  @override
  String toString() {
    return 'ShiftConfiguration(id: $id, date: $date, isExtendedMode: $isExtendedMode, shift1ManualProduction: $shift1ManualProduction, dailyGoal: $dailyGoal, minStationGoal: $minStationGoal)';
  }
}

/// @nodoc
abstract mixin class $ShiftConfigurationCopyWith<$Res> {
  factory $ShiftConfigurationCopyWith(
          ShiftConfiguration value, $Res Function(ShiftConfiguration) _then) =
      _$ShiftConfigurationCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      DateTime date,
      bool isExtendedMode,
      int shift1ManualProduction,
      int dailyGoal,
      int minStationGoal});
}

/// @nodoc
class _$ShiftConfigurationCopyWithImpl<$Res>
    implements $ShiftConfigurationCopyWith<$Res> {
  _$ShiftConfigurationCopyWithImpl(this._self, this._then);

  final ShiftConfiguration _self;
  final $Res Function(ShiftConfiguration) _then;

  /// Create a copy of ShiftConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? isExtendedMode = null,
    Object? shift1ManualProduction = null,
    Object? dailyGoal = null,
    Object? minStationGoal = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isExtendedMode: null == isExtendedMode
          ? _self.isExtendedMode
          : isExtendedMode // ignore: cast_nullable_to_non_nullable
              as bool,
      shift1ManualProduction: null == shift1ManualProduction
          ? _self.shift1ManualProduction
          : shift1ManualProduction // ignore: cast_nullable_to_non_nullable
              as int,
      dailyGoal: null == dailyGoal
          ? _self.dailyGoal
          : dailyGoal // ignore: cast_nullable_to_non_nullable
              as int,
      minStationGoal: null == minStationGoal
          ? _self.minStationGoal
          : minStationGoal // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [ShiftConfiguration].
extension ShiftConfigurationPatterns on ShiftConfiguration {
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
    TResult Function(_ShiftConfiguration value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShiftConfiguration() when $default != null:
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
    TResult Function(_ShiftConfiguration value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftConfiguration():
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
    TResult? Function(_ShiftConfiguration value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftConfiguration() when $default != null:
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
    TResult Function(String id, DateTime date, bool isExtendedMode,
            int shift1ManualProduction, int dailyGoal, int minStationGoal)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShiftConfiguration() when $default != null:
        return $default(
            _that.id,
            _that.date,
            _that.isExtendedMode,
            _that.shift1ManualProduction,
            _that.dailyGoal,
            _that.minStationGoal);
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
    TResult Function(String id, DateTime date, bool isExtendedMode,
            int shift1ManualProduction, int dailyGoal, int minStationGoal)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftConfiguration():
        return $default(
            _that.id,
            _that.date,
            _that.isExtendedMode,
            _that.shift1ManualProduction,
            _that.dailyGoal,
            _that.minStationGoal);
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
    TResult? Function(String id, DateTime date, bool isExtendedMode,
            int shift1ManualProduction, int dailyGoal, int minStationGoal)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftConfiguration() when $default != null:
        return $default(
            _that.id,
            _that.date,
            _that.isExtendedMode,
            _that.shift1ManualProduction,
            _that.dailyGoal,
            _that.minStationGoal);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ShiftConfiguration implements ShiftConfiguration {
  const _ShiftConfiguration(
      {required this.id,
      required this.date,
      this.isExtendedMode = false,
      this.shift1ManualProduction = 0,
      this.dailyGoal = 600,
      this.minStationGoal = 40});
  factory _ShiftConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ShiftConfigurationFromJson(json);

  @override
  final String id;
// UUID or DateString
  @override
  final DateTime date;
  @override
  @JsonKey()
  final bool isExtendedMode;
  @override
  @JsonKey()
  final int shift1ManualProduction;
  @override
  @JsonKey()
  final int dailyGoal;
  @override
  @JsonKey()
  final int minStationGoal;

  /// Create a copy of ShiftConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShiftConfigurationCopyWith<_ShiftConfiguration> get copyWith =>
      __$ShiftConfigurationCopyWithImpl<_ShiftConfiguration>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ShiftConfigurationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShiftConfiguration &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isExtendedMode, isExtendedMode) ||
                other.isExtendedMode == isExtendedMode) &&
            (identical(other.shift1ManualProduction, shift1ManualProduction) ||
                other.shift1ManualProduction == shift1ManualProduction) &&
            (identical(other.dailyGoal, dailyGoal) ||
                other.dailyGoal == dailyGoal) &&
            (identical(other.minStationGoal, minStationGoal) ||
                other.minStationGoal == minStationGoal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, isExtendedMode,
      shift1ManualProduction, dailyGoal, minStationGoal);

  @override
  String toString() {
    return 'ShiftConfiguration(id: $id, date: $date, isExtendedMode: $isExtendedMode, shift1ManualProduction: $shift1ManualProduction, dailyGoal: $dailyGoal, minStationGoal: $minStationGoal)';
  }
}

/// @nodoc
abstract mixin class _$ShiftConfigurationCopyWith<$Res>
    implements $ShiftConfigurationCopyWith<$Res> {
  factory _$ShiftConfigurationCopyWith(
          _ShiftConfiguration value, $Res Function(_ShiftConfiguration) _then) =
      __$ShiftConfigurationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime date,
      bool isExtendedMode,
      int shift1ManualProduction,
      int dailyGoal,
      int minStationGoal});
}

/// @nodoc
class __$ShiftConfigurationCopyWithImpl<$Res>
    implements _$ShiftConfigurationCopyWith<$Res> {
  __$ShiftConfigurationCopyWithImpl(this._self, this._then);

  final _ShiftConfiguration _self;
  final $Res Function(_ShiftConfiguration) _then;

  /// Create a copy of ShiftConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? isExtendedMode = null,
    Object? shift1ManualProduction = null,
    Object? dailyGoal = null,
    Object? minStationGoal = null,
  }) {
    return _then(_ShiftConfiguration(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isExtendedMode: null == isExtendedMode
          ? _self.isExtendedMode
          : isExtendedMode // ignore: cast_nullable_to_non_nullable
              as bool,
      shift1ManualProduction: null == shift1ManualProduction
          ? _self.shift1ManualProduction
          : shift1ManualProduction // ignore: cast_nullable_to_non_nullable
              as int,
      dailyGoal: null == dailyGoal
          ? _self.dailyGoal
          : dailyGoal // ignore: cast_nullable_to_non_nullable
              as int,
      minStationGoal: null == minStationGoal
          ? _self.minStationGoal
          : minStationGoal // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
