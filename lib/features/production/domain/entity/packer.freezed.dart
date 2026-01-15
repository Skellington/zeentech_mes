// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'packer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Packer {
  int get id;
  String get name;
  String get phone;
  String get email;
  String? get photoLocalPath;
  bool get isActive;

  /// Create a copy of Packer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PackerCopyWith<Packer> get copyWith =>
      _$PackerCopyWithImpl<Packer>(this as Packer, _$identity);

  /// Serializes this Packer to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Packer &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.photoLocalPath, photoLocalPath) ||
                other.photoLocalPath == photoLocalPath) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, phone, email, photoLocalPath, isActive);

  @override
  String toString() {
    return 'Packer(id: $id, name: $name, phone: $phone, email: $email, photoLocalPath: $photoLocalPath, isActive: $isActive)';
  }
}

/// @nodoc
abstract mixin class $PackerCopyWith<$Res> {
  factory $PackerCopyWith(Packer value, $Res Function(Packer) _then) =
      _$PackerCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      String phone,
      String email,
      String? photoLocalPath,
      bool isActive});
}

/// @nodoc
class _$PackerCopyWithImpl<$Res> implements $PackerCopyWith<$Res> {
  _$PackerCopyWithImpl(this._self, this._then);

  final Packer _self;
  final $Res Function(Packer) _then;

  /// Create a copy of Packer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? email = null,
    Object? photoLocalPath = freezed,
    Object? isActive = null,
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
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      photoLocalPath: freezed == photoLocalPath
          ? _self.photoLocalPath
          : photoLocalPath // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [Packer].
extension PackerPatterns on Packer {
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
    TResult Function(_Packer value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Packer() when $default != null:
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
    TResult Function(_Packer value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Packer():
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
    TResult? Function(_Packer value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Packer() when $default != null:
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
    TResult Function(int id, String name, String phone, String email,
            String? photoLocalPath, bool isActive)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Packer() when $default != null:
        return $default(_that.id, _that.name, _that.phone, _that.email,
            _that.photoLocalPath, _that.isActive);
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
    TResult Function(int id, String name, String phone, String email,
            String? photoLocalPath, bool isActive)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Packer():
        return $default(_that.id, _that.name, _that.phone, _that.email,
            _that.photoLocalPath, _that.isActive);
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
    TResult? Function(int id, String name, String phone, String email,
            String? photoLocalPath, bool isActive)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Packer() when $default != null:
        return $default(_that.id, _that.name, _that.phone, _that.email,
            _that.photoLocalPath, _that.isActive);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Packer implements Packer {
  const _Packer(
      {required this.id,
      required this.name,
      required this.phone,
      required this.email,
      this.photoLocalPath,
      this.isActive = true});
  factory _Packer.fromJson(Map<String, dynamic> json) => _$PackerFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String phone;
  @override
  final String email;
  @override
  final String? photoLocalPath;
  @override
  @JsonKey()
  final bool isActive;

  /// Create a copy of Packer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PackerCopyWith<_Packer> get copyWith =>
      __$PackerCopyWithImpl<_Packer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PackerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Packer &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.photoLocalPath, photoLocalPath) ||
                other.photoLocalPath == photoLocalPath) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, phone, email, photoLocalPath, isActive);

  @override
  String toString() {
    return 'Packer(id: $id, name: $name, phone: $phone, email: $email, photoLocalPath: $photoLocalPath, isActive: $isActive)';
  }
}

/// @nodoc
abstract mixin class _$PackerCopyWith<$Res> implements $PackerCopyWith<$Res> {
  factory _$PackerCopyWith(_Packer value, $Res Function(_Packer) _then) =
      __$PackerCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String phone,
      String email,
      String? photoLocalPath,
      bool isActive});
}

/// @nodoc
class __$PackerCopyWithImpl<$Res> implements _$PackerCopyWith<$Res> {
  __$PackerCopyWithImpl(this._self, this._then);

  final _Packer _self;
  final $Res Function(_Packer) _then;

  /// Create a copy of Packer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? email = null,
    Object? photoLocalPath = freezed,
    Object? isActive = null,
  }) {
    return _then(_Packer(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      photoLocalPath: freezed == photoLocalPath
          ? _self.photoLocalPath
          : photoLocalPath // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
