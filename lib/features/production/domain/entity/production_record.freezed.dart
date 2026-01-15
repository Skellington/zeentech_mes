// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'production_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductionRecord {
  String get id; // UUID
  String get barcode;
  int get stationId;
  int get packerId;
  ProductionType get type;
  int get volumeCount;
  int get itemCount;
  DateTime get timestamp;
  int get shiftId;
  int? get partTypeId;

  /// Create a copy of ProductionRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductionRecordCopyWith<ProductionRecord> get copyWith =>
      _$ProductionRecordCopyWithImpl<ProductionRecord>(
          this as ProductionRecord, _$identity);

  /// Serializes this ProductionRecord to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProductionRecord &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.stationId, stationId) ||
                other.stationId == stationId) &&
            (identical(other.packerId, packerId) ||
                other.packerId == packerId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.volumeCount, volumeCount) ||
                other.volumeCount == volumeCount) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.partTypeId, partTypeId) ||
                other.partTypeId == partTypeId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, barcode, stationId, packerId,
      type, volumeCount, itemCount, timestamp, shiftId, partTypeId);

  @override
  String toString() {
    return 'ProductionRecord(id: $id, barcode: $barcode, stationId: $stationId, packerId: $packerId, type: $type, volumeCount: $volumeCount, itemCount: $itemCount, timestamp: $timestamp, shiftId: $shiftId, partTypeId: $partTypeId)';
  }
}

/// @nodoc
abstract mixin class $ProductionRecordCopyWith<$Res> {
  factory $ProductionRecordCopyWith(
          ProductionRecord value, $Res Function(ProductionRecord) _then) =
      _$ProductionRecordCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String barcode,
      int stationId,
      int packerId,
      ProductionType type,
      int volumeCount,
      int itemCount,
      DateTime timestamp,
      int shiftId,
      int? partTypeId});
}

/// @nodoc
class _$ProductionRecordCopyWithImpl<$Res>
    implements $ProductionRecordCopyWith<$Res> {
  _$ProductionRecordCopyWithImpl(this._self, this._then);

  final ProductionRecord _self;
  final $Res Function(ProductionRecord) _then;

  /// Create a copy of ProductionRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? barcode = null,
    Object? stationId = null,
    Object? packerId = null,
    Object? type = null,
    Object? volumeCount = null,
    Object? itemCount = null,
    Object? timestamp = null,
    Object? shiftId = null,
    Object? partTypeId = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      barcode: null == barcode
          ? _self.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String,
      stationId: null == stationId
          ? _self.stationId
          : stationId // ignore: cast_nullable_to_non_nullable
              as int,
      packerId: null == packerId
          ? _self.packerId
          : packerId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ProductionType,
      volumeCount: null == volumeCount
          ? _self.volumeCount
          : volumeCount // ignore: cast_nullable_to_non_nullable
              as int,
      itemCount: null == itemCount
          ? _self.itemCount
          : itemCount // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shiftId: null == shiftId
          ? _self.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as int,
      partTypeId: freezed == partTypeId
          ? _self.partTypeId
          : partTypeId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ProductionRecord].
extension ProductionRecordPatterns on ProductionRecord {
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
    TResult Function(_ProductionRecord value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductionRecord() when $default != null:
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
    TResult Function(_ProductionRecord value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductionRecord():
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
    TResult? Function(_ProductionRecord value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductionRecord() when $default != null:
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
            String barcode,
            int stationId,
            int packerId,
            ProductionType type,
            int volumeCount,
            int itemCount,
            DateTime timestamp,
            int shiftId,
            int? partTypeId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductionRecord() when $default != null:
        return $default(
            _that.id,
            _that.barcode,
            _that.stationId,
            _that.packerId,
            _that.type,
            _that.volumeCount,
            _that.itemCount,
            _that.timestamp,
            _that.shiftId,
            _that.partTypeId);
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
            String barcode,
            int stationId,
            int packerId,
            ProductionType type,
            int volumeCount,
            int itemCount,
            DateTime timestamp,
            int shiftId,
            int? partTypeId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductionRecord():
        return $default(
            _that.id,
            _that.barcode,
            _that.stationId,
            _that.packerId,
            _that.type,
            _that.volumeCount,
            _that.itemCount,
            _that.timestamp,
            _that.shiftId,
            _that.partTypeId);
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
            String barcode,
            int stationId,
            int packerId,
            ProductionType type,
            int volumeCount,
            int itemCount,
            DateTime timestamp,
            int shiftId,
            int? partTypeId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductionRecord() when $default != null:
        return $default(
            _that.id,
            _that.barcode,
            _that.stationId,
            _that.packerId,
            _that.type,
            _that.volumeCount,
            _that.itemCount,
            _that.timestamp,
            _that.shiftId,
            _that.partTypeId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ProductionRecord implements ProductionRecord {
  const _ProductionRecord(
      {required this.id,
      required this.barcode,
      required this.stationId,
      required this.packerId,
      required this.type,
      required this.volumeCount,
      required this.itemCount,
      required this.timestamp,
      required this.shiftId,
      this.partTypeId});
  factory _ProductionRecord.fromJson(Map<String, dynamic> json) =>
      _$ProductionRecordFromJson(json);

  @override
  final String id;
// UUID
  @override
  final String barcode;
  @override
  final int stationId;
  @override
  final int packerId;
  @override
  final ProductionType type;
  @override
  final int volumeCount;
  @override
  final int itemCount;
  @override
  final DateTime timestamp;
  @override
  final int shiftId;
  @override
  final int? partTypeId;

  /// Create a copy of ProductionRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductionRecordCopyWith<_ProductionRecord> get copyWith =>
      __$ProductionRecordCopyWithImpl<_ProductionRecord>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProductionRecordToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProductionRecord &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.stationId, stationId) ||
                other.stationId == stationId) &&
            (identical(other.packerId, packerId) ||
                other.packerId == packerId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.volumeCount, volumeCount) ||
                other.volumeCount == volumeCount) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.partTypeId, partTypeId) ||
                other.partTypeId == partTypeId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, barcode, stationId, packerId,
      type, volumeCount, itemCount, timestamp, shiftId, partTypeId);

  @override
  String toString() {
    return 'ProductionRecord(id: $id, barcode: $barcode, stationId: $stationId, packerId: $packerId, type: $type, volumeCount: $volumeCount, itemCount: $itemCount, timestamp: $timestamp, shiftId: $shiftId, partTypeId: $partTypeId)';
  }
}

/// @nodoc
abstract mixin class _$ProductionRecordCopyWith<$Res>
    implements $ProductionRecordCopyWith<$Res> {
  factory _$ProductionRecordCopyWith(
          _ProductionRecord value, $Res Function(_ProductionRecord) _then) =
      __$ProductionRecordCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String barcode,
      int stationId,
      int packerId,
      ProductionType type,
      int volumeCount,
      int itemCount,
      DateTime timestamp,
      int shiftId,
      int? partTypeId});
}

/// @nodoc
class __$ProductionRecordCopyWithImpl<$Res>
    implements _$ProductionRecordCopyWith<$Res> {
  __$ProductionRecordCopyWithImpl(this._self, this._then);

  final _ProductionRecord _self;
  final $Res Function(_ProductionRecord) _then;

  /// Create a copy of ProductionRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? barcode = null,
    Object? stationId = null,
    Object? packerId = null,
    Object? type = null,
    Object? volumeCount = null,
    Object? itemCount = null,
    Object? timestamp = null,
    Object? shiftId = null,
    Object? partTypeId = freezed,
  }) {
    return _then(_ProductionRecord(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      barcode: null == barcode
          ? _self.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String,
      stationId: null == stationId
          ? _self.stationId
          : stationId // ignore: cast_nullable_to_non_nullable
              as int,
      packerId: null == packerId
          ? _self.packerId
          : packerId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ProductionType,
      volumeCount: null == volumeCount
          ? _self.volumeCount
          : volumeCount // ignore: cast_nullable_to_non_nullable
              as int,
      itemCount: null == itemCount
          ? _self.itemCount
          : itemCount // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shiftId: null == shiftId
          ? _self.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as int,
      partTypeId: freezed == partTypeId
          ? _self.partTypeId
          : partTypeId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
