// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Station {
  int get id;
  String get name;
  String get status;
  int? get assignedPackerId1;
  int? get assignedPackerId2;
  int get targetGoal;

  /// Create a copy of Station
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StationCopyWith<Station> get copyWith =>
      _$StationCopyWithImpl<Station>(this as Station, _$identity);

  /// Serializes this Station to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Station &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.assignedPackerId1, assignedPackerId1) ||
                other.assignedPackerId1 == assignedPackerId1) &&
            (identical(other.assignedPackerId2, assignedPackerId2) ||
                other.assignedPackerId2 == assignedPackerId2) &&
            (identical(other.targetGoal, targetGoal) ||
                other.targetGoal == targetGoal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, status,
      assignedPackerId1, assignedPackerId2, targetGoal);

  @override
  String toString() {
    return 'Station(id: $id, name: $name, status: $status, assignedPackerId1: $assignedPackerId1, assignedPackerId2: $assignedPackerId2, targetGoal: $targetGoal)';
  }
}

/// @nodoc
abstract mixin class $StationCopyWith<$Res> {
  factory $StationCopyWith(Station value, $Res Function(Station) _then) =
      _$StationCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      String status,
      int? assignedPackerId1,
      int? assignedPackerId2,
      int targetGoal});
}

/// @nodoc
class _$StationCopyWithImpl<$Res> implements $StationCopyWith<$Res> {
  _$StationCopyWithImpl(this._self, this._then);

  final Station _self;
  final $Res Function(Station) _then;

  /// Create a copy of Station
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? assignedPackerId1 = freezed,
    Object? assignedPackerId2 = freezed,
    Object? targetGoal = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      assignedPackerId1: freezed == assignedPackerId1
          ? _self.assignedPackerId1
          : assignedPackerId1 // ignore: cast_nullable_to_non_nullable
              as int?,
      assignedPackerId2: freezed == assignedPackerId2
          ? _self.assignedPackerId2
          : assignedPackerId2 // ignore: cast_nullable_to_non_nullable
              as int?,
      targetGoal: null == targetGoal
          ? _self.targetGoal
          : targetGoal // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Station].
extension StationPatterns on Station {
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
    TResult Function(_Station value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Station() when $default != null:
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
    TResult Function(_Station value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Station():
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
    TResult? Function(_Station value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Station() when $default != null:
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
    TResult Function(int id, String name, String status, int? assignedPackerId1,
            int? assignedPackerId2, int targetGoal)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Station() when $default != null:
        return $default(_that.id, _that.name, _that.status,
            _that.assignedPackerId1, _that.assignedPackerId2, _that.targetGoal);
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
    TResult Function(int id, String name, String status, int? assignedPackerId1,
            int? assignedPackerId2, int targetGoal)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Station():
        return $default(_that.id, _that.name, _that.status,
            _that.assignedPackerId1, _that.assignedPackerId2, _that.targetGoal);
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
    TResult? Function(int id, String name, String status,
            int? assignedPackerId1, int? assignedPackerId2, int targetGoal)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Station() when $default != null:
        return $default(_that.id, _that.name, _that.status,
            _that.assignedPackerId1, _that.assignedPackerId2, _that.targetGoal);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Station implements Station {
  const _Station(
      {required this.id,
      required this.name,
      required this.status,
      this.assignedPackerId1,
      this.assignedPackerId2,
      this.targetGoal = 40});
  factory _Station.fromJson(Map<String, dynamic> json) =>
      _$StationFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String status;
  @override
  final int? assignedPackerId1;
  @override
  final int? assignedPackerId2;
  @override
  @JsonKey()
  final int targetGoal;

  /// Create a copy of Station
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StationCopyWith<_Station> get copyWith =>
      __$StationCopyWithImpl<_Station>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Station &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.assignedPackerId1, assignedPackerId1) ||
                other.assignedPackerId1 == assignedPackerId1) &&
            (identical(other.assignedPackerId2, assignedPackerId2) ||
                other.assignedPackerId2 == assignedPackerId2) &&
            (identical(other.targetGoal, targetGoal) ||
                other.targetGoal == targetGoal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, status,
      assignedPackerId1, assignedPackerId2, targetGoal);

  @override
  String toString() {
    return 'Station(id: $id, name: $name, status: $status, assignedPackerId1: $assignedPackerId1, assignedPackerId2: $assignedPackerId2, targetGoal: $targetGoal)';
  }
}

/// @nodoc
abstract mixin class _$StationCopyWith<$Res> implements $StationCopyWith<$Res> {
  factory _$StationCopyWith(_Station value, $Res Function(_Station) _then) =
      __$StationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String status,
      int? assignedPackerId1,
      int? assignedPackerId2,
      int targetGoal});
}

/// @nodoc
class __$StationCopyWithImpl<$Res> implements _$StationCopyWith<$Res> {
  __$StationCopyWithImpl(this._self, this._then);

  final _Station _self;
  final $Res Function(_Station) _then;

  /// Create a copy of Station
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? assignedPackerId1 = freezed,
    Object? assignedPackerId2 = freezed,
    Object? targetGoal = null,
  }) {
    return _then(_Station(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      assignedPackerId1: freezed == assignedPackerId1
          ? _self.assignedPackerId1
          : assignedPackerId1 // ignore: cast_nullable_to_non_nullable
              as int?,
      assignedPackerId2: freezed == assignedPackerId2
          ? _self.assignedPackerId2
          : assignedPackerId2 // ignore: cast_nullable_to_non_nullable
              as int?,
      targetGoal: null == targetGoal
          ? _self.targetGoal
          : targetGoal // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
