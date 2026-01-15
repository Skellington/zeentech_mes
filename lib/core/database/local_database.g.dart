// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $PackersTable extends Packers with TableInfo<$PackersTable, Packer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PackersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _photoLocalPathMeta =
      const VerificationMeta('photoLocalPath');
  @override
  late final GeneratedColumn<String> photoLocalPath = GeneratedColumn<String>(
      'photo_local_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, phone, email, photoLocalPath, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'packers';
  @override
  VerificationContext validateIntegrity(Insertable<Packer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('photo_local_path')) {
      context.handle(
          _photoLocalPathMeta,
          photoLocalPath.isAcceptableOrUnknown(
              data['photo_local_path']!, _photoLocalPathMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Packer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Packer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      photoLocalPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}photo_local_path']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $PackersTable createAlias(String alias) {
    return $PackersTable(attachedDatabase, alias);
  }
}

class Packer extends DataClass implements Insertable<Packer> {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String? photoLocalPath;
  final bool isActive;
  const Packer(
      {required this.id,
      required this.name,
      required this.phone,
      required this.email,
      this.photoLocalPath,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || photoLocalPath != null) {
      map['photo_local_path'] = Variable<String>(photoLocalPath);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  PackersCompanion toCompanion(bool nullToAbsent) {
    return PackersCompanion(
      id: Value(id),
      name: Value(name),
      phone: Value(phone),
      email: Value(email),
      photoLocalPath: photoLocalPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoLocalPath),
      isActive: Value(isActive),
    );
  }

  factory Packer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Packer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      email: serializer.fromJson<String>(json['email']),
      photoLocalPath: serializer.fromJson<String?>(json['photoLocalPath']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'email': serializer.toJson<String>(email),
      'photoLocalPath': serializer.toJson<String?>(photoLocalPath),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Packer copyWith(
          {int? id,
          String? name,
          String? phone,
          String? email,
          Value<String?> photoLocalPath = const Value.absent(),
          bool? isActive}) =>
      Packer(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        photoLocalPath:
            photoLocalPath.present ? photoLocalPath.value : this.photoLocalPath,
        isActive: isActive ?? this.isActive,
      );
  Packer copyWithCompanion(PackersCompanion data) {
    return Packer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      photoLocalPath: data.photoLocalPath.present
          ? data.photoLocalPath.value
          : this.photoLocalPath,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Packer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('photoLocalPath: $photoLocalPath, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, phone, email, photoLocalPath, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Packer &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.photoLocalPath == this.photoLocalPath &&
          other.isActive == this.isActive);
}

class PackersCompanion extends UpdateCompanion<Packer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> phone;
  final Value<String> email;
  final Value<String?> photoLocalPath;
  final Value<bool> isActive;
  const PackersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.photoLocalPath = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  PackersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String phone,
    required String email,
    this.photoLocalPath = const Value.absent(),
    this.isActive = const Value.absent(),
  })  : name = Value(name),
        phone = Value(phone),
        email = Value(email);
  static Insertable<Packer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? photoLocalPath,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (photoLocalPath != null) 'photo_local_path': photoLocalPath,
      if (isActive != null) 'is_active': isActive,
    });
  }

  PackersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? phone,
      Value<String>? email,
      Value<String?>? photoLocalPath,
      Value<bool>? isActive}) {
    return PackersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      photoLocalPath: photoLocalPath ?? this.photoLocalPath,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (photoLocalPath.present) {
      map['photo_local_path'] = Variable<String>(photoLocalPath.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PackersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('photoLocalPath: $photoLocalPath, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $StationsTable extends Stations with TableInfo<$StationsTable, Station> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _assignedPackerId1Meta =
      const VerificationMeta('assignedPackerId1');
  @override
  late final GeneratedColumn<int> assignedPackerId1 = GeneratedColumn<int>(
      'assigned_packer_id1', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES packers (id)'));
  static const VerificationMeta _assignedPackerId2Meta =
      const VerificationMeta('assignedPackerId2');
  @override
  late final GeneratedColumn<int> assignedPackerId2 = GeneratedColumn<int>(
      'assigned_packer_id2', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES packers (id)'));
  static const VerificationMeta _targetGoalMeta =
      const VerificationMeta('targetGoal');
  @override
  late final GeneratedColumn<int> targetGoal = GeneratedColumn<int>(
      'target_goal', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(40));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, status, assignedPackerId1, assignedPackerId2, targetGoal];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stations';
  @override
  VerificationContext validateIntegrity(Insertable<Station> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('assigned_packer_id1')) {
      context.handle(
          _assignedPackerId1Meta,
          assignedPackerId1.isAcceptableOrUnknown(
              data['assigned_packer_id1']!, _assignedPackerId1Meta));
    }
    if (data.containsKey('assigned_packer_id2')) {
      context.handle(
          _assignedPackerId2Meta,
          assignedPackerId2.isAcceptableOrUnknown(
              data['assigned_packer_id2']!, _assignedPackerId2Meta));
    }
    if (data.containsKey('target_goal')) {
      context.handle(
          _targetGoalMeta,
          targetGoal.isAcceptableOrUnknown(
              data['target_goal']!, _targetGoalMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Station map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Station(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      assignedPackerId1: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}assigned_packer_id1']),
      assignedPackerId2: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}assigned_packer_id2']),
      targetGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_goal'])!,
    );
  }

  @override
  $StationsTable createAlias(String alias) {
    return $StationsTable(attachedDatabase, alias);
  }
}

class Station extends DataClass implements Insertable<Station> {
  final int id;
  final String name;
  final String status;
  final int? assignedPackerId1;
  final int? assignedPackerId2;
  final int targetGoal;
  const Station(
      {required this.id,
      required this.name,
      required this.status,
      this.assignedPackerId1,
      this.assignedPackerId2,
      required this.targetGoal});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || assignedPackerId1 != null) {
      map['assigned_packer_id1'] = Variable<int>(assignedPackerId1);
    }
    if (!nullToAbsent || assignedPackerId2 != null) {
      map['assigned_packer_id2'] = Variable<int>(assignedPackerId2);
    }
    map['target_goal'] = Variable<int>(targetGoal);
    return map;
  }

  StationsCompanion toCompanion(bool nullToAbsent) {
    return StationsCompanion(
      id: Value(id),
      name: Value(name),
      status: Value(status),
      assignedPackerId1: assignedPackerId1 == null && nullToAbsent
          ? const Value.absent()
          : Value(assignedPackerId1),
      assignedPackerId2: assignedPackerId2 == null && nullToAbsent
          ? const Value.absent()
          : Value(assignedPackerId2),
      targetGoal: Value(targetGoal),
    );
  }

  factory Station.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Station(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      status: serializer.fromJson<String>(json['status']),
      assignedPackerId1: serializer.fromJson<int?>(json['assignedPackerId1']),
      assignedPackerId2: serializer.fromJson<int?>(json['assignedPackerId2']),
      targetGoal: serializer.fromJson<int>(json['targetGoal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'status': serializer.toJson<String>(status),
      'assignedPackerId1': serializer.toJson<int?>(assignedPackerId1),
      'assignedPackerId2': serializer.toJson<int?>(assignedPackerId2),
      'targetGoal': serializer.toJson<int>(targetGoal),
    };
  }

  Station copyWith(
          {int? id,
          String? name,
          String? status,
          Value<int?> assignedPackerId1 = const Value.absent(),
          Value<int?> assignedPackerId2 = const Value.absent(),
          int? targetGoal}) =>
      Station(
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
        assignedPackerId1: assignedPackerId1.present
            ? assignedPackerId1.value
            : this.assignedPackerId1,
        assignedPackerId2: assignedPackerId2.present
            ? assignedPackerId2.value
            : this.assignedPackerId2,
        targetGoal: targetGoal ?? this.targetGoal,
      );
  Station copyWithCompanion(StationsCompanion data) {
    return Station(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      status: data.status.present ? data.status.value : this.status,
      assignedPackerId1: data.assignedPackerId1.present
          ? data.assignedPackerId1.value
          : this.assignedPackerId1,
      assignedPackerId2: data.assignedPackerId2.present
          ? data.assignedPackerId2.value
          : this.assignedPackerId2,
      targetGoal:
          data.targetGoal.present ? data.targetGoal.value : this.targetGoal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Station(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('assignedPackerId1: $assignedPackerId1, ')
          ..write('assignedPackerId2: $assignedPackerId2, ')
          ..write('targetGoal: $targetGoal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, status, assignedPackerId1, assignedPackerId2, targetGoal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Station &&
          other.id == this.id &&
          other.name == this.name &&
          other.status == this.status &&
          other.assignedPackerId1 == this.assignedPackerId1 &&
          other.assignedPackerId2 == this.assignedPackerId2 &&
          other.targetGoal == this.targetGoal);
}

class StationsCompanion extends UpdateCompanion<Station> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> status;
  final Value<int?> assignedPackerId1;
  final Value<int?> assignedPackerId2;
  final Value<int> targetGoal;
  const StationsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.status = const Value.absent(),
    this.assignedPackerId1 = const Value.absent(),
    this.assignedPackerId2 = const Value.absent(),
    this.targetGoal = const Value.absent(),
  });
  StationsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String status,
    this.assignedPackerId1 = const Value.absent(),
    this.assignedPackerId2 = const Value.absent(),
    this.targetGoal = const Value.absent(),
  })  : name = Value(name),
        status = Value(status);
  static Insertable<Station> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? status,
    Expression<int>? assignedPackerId1,
    Expression<int>? assignedPackerId2,
    Expression<int>? targetGoal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (status != null) 'status': status,
      if (assignedPackerId1 != null) 'assigned_packer_id1': assignedPackerId1,
      if (assignedPackerId2 != null) 'assigned_packer_id2': assignedPackerId2,
      if (targetGoal != null) 'target_goal': targetGoal,
    });
  }

  StationsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? status,
      Value<int?>? assignedPackerId1,
      Value<int?>? assignedPackerId2,
      Value<int>? targetGoal}) {
    return StationsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      assignedPackerId1: assignedPackerId1 ?? this.assignedPackerId1,
      assignedPackerId2: assignedPackerId2 ?? this.assignedPackerId2,
      targetGoal: targetGoal ?? this.targetGoal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (assignedPackerId1.present) {
      map['assigned_packer_id1'] = Variable<int>(assignedPackerId1.value);
    }
    if (assignedPackerId2.present) {
      map['assigned_packer_id2'] = Variable<int>(assignedPackerId2.value);
    }
    if (targetGoal.present) {
      map['target_goal'] = Variable<int>(targetGoal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StationsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('assignedPackerId1: $assignedPackerId1, ')
          ..write('assignedPackerId2: $assignedPackerId2, ')
          ..write('targetGoal: $targetGoal')
          ..write(')'))
        .toString();
  }
}

class $PartTypesTable extends PartTypes
    with TableInfo<$PartTypesTable, PartType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [id, name, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'part_types';
  @override
  VerificationContext validateIntegrity(Insertable<PartType> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PartType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartType(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $PartTypesTable createAlias(String alias) {
    return $PartTypesTable(attachedDatabase, alias);
  }
}

class PartType extends DataClass implements Insertable<PartType> {
  final int id;
  final String name;
  final bool isActive;
  const PartType(
      {required this.id, required this.name, required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  PartTypesCompanion toCompanion(bool nullToAbsent) {
    return PartTypesCompanion(
      id: Value(id),
      name: Value(name),
      isActive: Value(isActive),
    );
  }

  factory PartType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartType(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  PartType copyWith({int? id, String? name, bool? isActive}) => PartType(
        id: id ?? this.id,
        name: name ?? this.name,
        isActive: isActive ?? this.isActive,
      );
  PartType copyWithCompanion(PartTypesCompanion data) {
    return PartType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PartType(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartType &&
          other.id == this.id &&
          other.name == this.name &&
          other.isActive == this.isActive);
}

class PartTypesCompanion extends UpdateCompanion<PartType> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> isActive;
  const PartTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  PartTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.isActive = const Value.absent(),
  }) : name = Value(name);
  static Insertable<PartType> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
    });
  }

  PartTypesCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<bool>? isActive}) {
    return PartTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $ProductionRecordsTable extends ProductionRecords
    with TableInfo<$ProductionRecordsTable, ProductionRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductionRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stationIdMeta =
      const VerificationMeta('stationId');
  @override
  late final GeneratedColumn<int> stationId = GeneratedColumn<int>(
      'station_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES stations (id)'));
  static const VerificationMeta _packerIdMeta =
      const VerificationMeta('packerId');
  @override
  late final GeneratedColumn<int> packerId = GeneratedColumn<int>(
      'packer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES packers (id)'));
  @override
  late final GeneratedColumnWithTypeConverter<ProductionType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<ProductionType>(
              $ProductionRecordsTable.$convertertype);
  static const VerificationMeta _barcodeMeta =
      const VerificationMeta('barcode');
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
      'barcode', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _volumeCountMeta =
      const VerificationMeta('volumeCount');
  @override
  late final GeneratedColumn<int> volumeCount = GeneratedColumn<int>(
      'volume_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _itemCountMeta =
      const VerificationMeta('itemCount');
  @override
  late final GeneratedColumn<int> itemCount = GeneratedColumn<int>(
      'item_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _shiftIdMeta =
      const VerificationMeta('shiftId');
  @override
  late final GeneratedColumn<int> shiftId = GeneratedColumn<int>(
      'shift_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _partTypeIdMeta =
      const VerificationMeta('partTypeId');
  @override
  late final GeneratedColumn<int> partTypeId = GeneratedColumn<int>(
      'part_type_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES part_types (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        stationId,
        packerId,
        type,
        barcode,
        volumeCount,
        itemCount,
        timestamp,
        shiftId,
        partTypeId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'production_records';
  @override
  VerificationContext validateIntegrity(Insertable<ProductionRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('station_id')) {
      context.handle(_stationIdMeta,
          stationId.isAcceptableOrUnknown(data['station_id']!, _stationIdMeta));
    } else if (isInserting) {
      context.missing(_stationIdMeta);
    }
    if (data.containsKey('packer_id')) {
      context.handle(_packerIdMeta,
          packerId.isAcceptableOrUnknown(data['packer_id']!, _packerIdMeta));
    } else if (isInserting) {
      context.missing(_packerIdMeta);
    }
    if (data.containsKey('barcode')) {
      context.handle(_barcodeMeta,
          barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta));
    } else if (isInserting) {
      context.missing(_barcodeMeta);
    }
    if (data.containsKey('volume_count')) {
      context.handle(
          _volumeCountMeta,
          volumeCount.isAcceptableOrUnknown(
              data['volume_count']!, _volumeCountMeta));
    } else if (isInserting) {
      context.missing(_volumeCountMeta);
    }
    if (data.containsKey('item_count')) {
      context.handle(_itemCountMeta,
          itemCount.isAcceptableOrUnknown(data['item_count']!, _itemCountMeta));
    } else if (isInserting) {
      context.missing(_itemCountMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('shift_id')) {
      context.handle(_shiftIdMeta,
          shiftId.isAcceptableOrUnknown(data['shift_id']!, _shiftIdMeta));
    } else if (isInserting) {
      context.missing(_shiftIdMeta);
    }
    if (data.containsKey('part_type_id')) {
      context.handle(
          _partTypeIdMeta,
          partTypeId.isAcceptableOrUnknown(
              data['part_type_id']!, _partTypeIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductionRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductionRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      stationId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}station_id'])!,
      packerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}packer_id'])!,
      type: $ProductionRecordsTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      barcode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}barcode'])!,
      volumeCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}volume_count'])!,
      itemCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}item_count'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      shiftId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}shift_id'])!,
      partTypeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}part_type_id']),
    );
  }

  @override
  $ProductionRecordsTable createAlias(String alias) {
    return $ProductionRecordsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ProductionType, int, int> $convertertype =
      const EnumIndexConverter<ProductionType>(ProductionType.values);
}

class ProductionRecord extends DataClass
    implements Insertable<ProductionRecord> {
  final String id;
  final int stationId;
  final int packerId;
  final ProductionType type;
  final String barcode;
  final int volumeCount;
  final int itemCount;
  final DateTime timestamp;
  final int shiftId;
  final int? partTypeId;
  const ProductionRecord(
      {required this.id,
      required this.stationId,
      required this.packerId,
      required this.type,
      required this.barcode,
      required this.volumeCount,
      required this.itemCount,
      required this.timestamp,
      required this.shiftId,
      this.partTypeId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['station_id'] = Variable<int>(stationId);
    map['packer_id'] = Variable<int>(packerId);
    {
      map['type'] =
          Variable<int>($ProductionRecordsTable.$convertertype.toSql(type));
    }
    map['barcode'] = Variable<String>(barcode);
    map['volume_count'] = Variable<int>(volumeCount);
    map['item_count'] = Variable<int>(itemCount);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['shift_id'] = Variable<int>(shiftId);
    if (!nullToAbsent || partTypeId != null) {
      map['part_type_id'] = Variable<int>(partTypeId);
    }
    return map;
  }

  ProductionRecordsCompanion toCompanion(bool nullToAbsent) {
    return ProductionRecordsCompanion(
      id: Value(id),
      stationId: Value(stationId),
      packerId: Value(packerId),
      type: Value(type),
      barcode: Value(barcode),
      volumeCount: Value(volumeCount),
      itemCount: Value(itemCount),
      timestamp: Value(timestamp),
      shiftId: Value(shiftId),
      partTypeId: partTypeId == null && nullToAbsent
          ? const Value.absent()
          : Value(partTypeId),
    );
  }

  factory ProductionRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductionRecord(
      id: serializer.fromJson<String>(json['id']),
      stationId: serializer.fromJson<int>(json['stationId']),
      packerId: serializer.fromJson<int>(json['packerId']),
      type: $ProductionRecordsTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      barcode: serializer.fromJson<String>(json['barcode']),
      volumeCount: serializer.fromJson<int>(json['volumeCount']),
      itemCount: serializer.fromJson<int>(json['itemCount']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      shiftId: serializer.fromJson<int>(json['shiftId']),
      partTypeId: serializer.fromJson<int?>(json['partTypeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'stationId': serializer.toJson<int>(stationId),
      'packerId': serializer.toJson<int>(packerId),
      'type': serializer
          .toJson<int>($ProductionRecordsTable.$convertertype.toJson(type)),
      'barcode': serializer.toJson<String>(barcode),
      'volumeCount': serializer.toJson<int>(volumeCount),
      'itemCount': serializer.toJson<int>(itemCount),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'shiftId': serializer.toJson<int>(shiftId),
      'partTypeId': serializer.toJson<int?>(partTypeId),
    };
  }

  ProductionRecord copyWith(
          {String? id,
          int? stationId,
          int? packerId,
          ProductionType? type,
          String? barcode,
          int? volumeCount,
          int? itemCount,
          DateTime? timestamp,
          int? shiftId,
          Value<int?> partTypeId = const Value.absent()}) =>
      ProductionRecord(
        id: id ?? this.id,
        stationId: stationId ?? this.stationId,
        packerId: packerId ?? this.packerId,
        type: type ?? this.type,
        barcode: barcode ?? this.barcode,
        volumeCount: volumeCount ?? this.volumeCount,
        itemCount: itemCount ?? this.itemCount,
        timestamp: timestamp ?? this.timestamp,
        shiftId: shiftId ?? this.shiftId,
        partTypeId: partTypeId.present ? partTypeId.value : this.partTypeId,
      );
  ProductionRecord copyWithCompanion(ProductionRecordsCompanion data) {
    return ProductionRecord(
      id: data.id.present ? data.id.value : this.id,
      stationId: data.stationId.present ? data.stationId.value : this.stationId,
      packerId: data.packerId.present ? data.packerId.value : this.packerId,
      type: data.type.present ? data.type.value : this.type,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      volumeCount:
          data.volumeCount.present ? data.volumeCount.value : this.volumeCount,
      itemCount: data.itemCount.present ? data.itemCount.value : this.itemCount,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      shiftId: data.shiftId.present ? data.shiftId.value : this.shiftId,
      partTypeId:
          data.partTypeId.present ? data.partTypeId.value : this.partTypeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductionRecord(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('packerId: $packerId, ')
          ..write('type: $type, ')
          ..write('barcode: $barcode, ')
          ..write('volumeCount: $volumeCount, ')
          ..write('itemCount: $itemCount, ')
          ..write('timestamp: $timestamp, ')
          ..write('shiftId: $shiftId, ')
          ..write('partTypeId: $partTypeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, stationId, packerId, type, barcode,
      volumeCount, itemCount, timestamp, shiftId, partTypeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductionRecord &&
          other.id == this.id &&
          other.stationId == this.stationId &&
          other.packerId == this.packerId &&
          other.type == this.type &&
          other.barcode == this.barcode &&
          other.volumeCount == this.volumeCount &&
          other.itemCount == this.itemCount &&
          other.timestamp == this.timestamp &&
          other.shiftId == this.shiftId &&
          other.partTypeId == this.partTypeId);
}

class ProductionRecordsCompanion extends UpdateCompanion<ProductionRecord> {
  final Value<String> id;
  final Value<int> stationId;
  final Value<int> packerId;
  final Value<ProductionType> type;
  final Value<String> barcode;
  final Value<int> volumeCount;
  final Value<int> itemCount;
  final Value<DateTime> timestamp;
  final Value<int> shiftId;
  final Value<int?> partTypeId;
  final Value<int> rowid;
  const ProductionRecordsCompanion({
    this.id = const Value.absent(),
    this.stationId = const Value.absent(),
    this.packerId = const Value.absent(),
    this.type = const Value.absent(),
    this.barcode = const Value.absent(),
    this.volumeCount = const Value.absent(),
    this.itemCount = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.shiftId = const Value.absent(),
    this.partTypeId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductionRecordsCompanion.insert({
    required String id,
    required int stationId,
    required int packerId,
    required ProductionType type,
    required String barcode,
    required int volumeCount,
    required int itemCount,
    required DateTime timestamp,
    required int shiftId,
    this.partTypeId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        stationId = Value(stationId),
        packerId = Value(packerId),
        type = Value(type),
        barcode = Value(barcode),
        volumeCount = Value(volumeCount),
        itemCount = Value(itemCount),
        timestamp = Value(timestamp),
        shiftId = Value(shiftId);
  static Insertable<ProductionRecord> custom({
    Expression<String>? id,
    Expression<int>? stationId,
    Expression<int>? packerId,
    Expression<int>? type,
    Expression<String>? barcode,
    Expression<int>? volumeCount,
    Expression<int>? itemCount,
    Expression<DateTime>? timestamp,
    Expression<int>? shiftId,
    Expression<int>? partTypeId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stationId != null) 'station_id': stationId,
      if (packerId != null) 'packer_id': packerId,
      if (type != null) 'type': type,
      if (barcode != null) 'barcode': barcode,
      if (volumeCount != null) 'volume_count': volumeCount,
      if (itemCount != null) 'item_count': itemCount,
      if (timestamp != null) 'timestamp': timestamp,
      if (shiftId != null) 'shift_id': shiftId,
      if (partTypeId != null) 'part_type_id': partTypeId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductionRecordsCompanion copyWith(
      {Value<String>? id,
      Value<int>? stationId,
      Value<int>? packerId,
      Value<ProductionType>? type,
      Value<String>? barcode,
      Value<int>? volumeCount,
      Value<int>? itemCount,
      Value<DateTime>? timestamp,
      Value<int>? shiftId,
      Value<int?>? partTypeId,
      Value<int>? rowid}) {
    return ProductionRecordsCompanion(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      packerId: packerId ?? this.packerId,
      type: type ?? this.type,
      barcode: barcode ?? this.barcode,
      volumeCount: volumeCount ?? this.volumeCount,
      itemCount: itemCount ?? this.itemCount,
      timestamp: timestamp ?? this.timestamp,
      shiftId: shiftId ?? this.shiftId,
      partTypeId: partTypeId ?? this.partTypeId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (stationId.present) {
      map['station_id'] = Variable<int>(stationId.value);
    }
    if (packerId.present) {
      map['packer_id'] = Variable<int>(packerId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
          $ProductionRecordsTable.$convertertype.toSql(type.value));
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (volumeCount.present) {
      map['volume_count'] = Variable<int>(volumeCount.value);
    }
    if (itemCount.present) {
      map['item_count'] = Variable<int>(itemCount.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (shiftId.present) {
      map['shift_id'] = Variable<int>(shiftId.value);
    }
    if (partTypeId.present) {
      map['part_type_id'] = Variable<int>(partTypeId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductionRecordsCompanion(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('packerId: $packerId, ')
          ..write('type: $type, ')
          ..write('barcode: $barcode, ')
          ..write('volumeCount: $volumeCount, ')
          ..write('itemCount: $itemCount, ')
          ..write('timestamp: $timestamp, ')
          ..write('shiftId: $shiftId, ')
          ..write('partTypeId: $partTypeId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DowntimeRecordsTable extends DowntimeRecords
    with TableInfo<$DowntimeRecordsTable, DowntimeRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DowntimeRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stationIdMeta =
      const VerificationMeta('stationId');
  @override
  late final GeneratedColumn<int> stationId = GeneratedColumn<int>(
      'station_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES stations (id)'));
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _reasonStartMeta =
      const VerificationMeta('reasonStart');
  @override
  late final GeneratedColumn<String> reasonStart = GeneratedColumn<String>(
      'reason_start', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reasonEndMeta =
      const VerificationMeta('reasonEnd');
  @override
  late final GeneratedColumn<String> reasonEnd = GeneratedColumn<String>(
      'reason_end', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
      'duration_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        stationId,
        startTime,
        endTime,
        reasonStart,
        reasonEnd,
        durationMinutes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'downtime_records';
  @override
  VerificationContext validateIntegrity(Insertable<DowntimeRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('station_id')) {
      context.handle(_stationIdMeta,
          stationId.isAcceptableOrUnknown(data['station_id']!, _stationIdMeta));
    } else if (isInserting) {
      context.missing(_stationIdMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    if (data.containsKey('reason_start')) {
      context.handle(
          _reasonStartMeta,
          reasonStart.isAcceptableOrUnknown(
              data['reason_start']!, _reasonStartMeta));
    }
    if (data.containsKey('reason_end')) {
      context.handle(_reasonEndMeta,
          reasonEnd.isAcceptableOrUnknown(data['reason_end']!, _reasonEndMeta));
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
          _durationMinutesMeta,
          durationMinutes.isAcceptableOrUnknown(
              data['duration_minutes']!, _durationMinutesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DowntimeRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DowntimeRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      stationId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}station_id'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time']),
      reasonStart: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reason_start']),
      reasonEnd: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reason_end']),
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes'])!,
    );
  }

  @override
  $DowntimeRecordsTable createAlias(String alias) {
    return $DowntimeRecordsTable(attachedDatabase, alias);
  }
}

class DowntimeRecord extends DataClass implements Insertable<DowntimeRecord> {
  final String id;
  final int stationId;
  final DateTime startTime;
  final DateTime? endTime;
  final String? reasonStart;
  final String? reasonEnd;
  final int durationMinutes;
  const DowntimeRecord(
      {required this.id,
      required this.stationId,
      required this.startTime,
      this.endTime,
      this.reasonStart,
      this.reasonEnd,
      required this.durationMinutes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['station_id'] = Variable<int>(stationId);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || reasonStart != null) {
      map['reason_start'] = Variable<String>(reasonStart);
    }
    if (!nullToAbsent || reasonEnd != null) {
      map['reason_end'] = Variable<String>(reasonEnd);
    }
    map['duration_minutes'] = Variable<int>(durationMinutes);
    return map;
  }

  DowntimeRecordsCompanion toCompanion(bool nullToAbsent) {
    return DowntimeRecordsCompanion(
      id: Value(id),
      stationId: Value(stationId),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      reasonStart: reasonStart == null && nullToAbsent
          ? const Value.absent()
          : Value(reasonStart),
      reasonEnd: reasonEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(reasonEnd),
      durationMinutes: Value(durationMinutes),
    );
  }

  factory DowntimeRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DowntimeRecord(
      id: serializer.fromJson<String>(json['id']),
      stationId: serializer.fromJson<int>(json['stationId']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      reasonStart: serializer.fromJson<String?>(json['reasonStart']),
      reasonEnd: serializer.fromJson<String?>(json['reasonEnd']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'stationId': serializer.toJson<int>(stationId),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'reasonStart': serializer.toJson<String?>(reasonStart),
      'reasonEnd': serializer.toJson<String?>(reasonEnd),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
    };
  }

  DowntimeRecord copyWith(
          {String? id,
          int? stationId,
          DateTime? startTime,
          Value<DateTime?> endTime = const Value.absent(),
          Value<String?> reasonStart = const Value.absent(),
          Value<String?> reasonEnd = const Value.absent(),
          int? durationMinutes}) =>
      DowntimeRecord(
        id: id ?? this.id,
        stationId: stationId ?? this.stationId,
        startTime: startTime ?? this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
        reasonStart: reasonStart.present ? reasonStart.value : this.reasonStart,
        reasonEnd: reasonEnd.present ? reasonEnd.value : this.reasonEnd,
        durationMinutes: durationMinutes ?? this.durationMinutes,
      );
  DowntimeRecord copyWithCompanion(DowntimeRecordsCompanion data) {
    return DowntimeRecord(
      id: data.id.present ? data.id.value : this.id,
      stationId: data.stationId.present ? data.stationId.value : this.stationId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      reasonStart:
          data.reasonStart.present ? data.reasonStart.value : this.reasonStart,
      reasonEnd: data.reasonEnd.present ? data.reasonEnd.value : this.reasonEnd,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DowntimeRecord(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('reasonStart: $reasonStart, ')
          ..write('reasonEnd: $reasonEnd, ')
          ..write('durationMinutes: $durationMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, stationId, startTime, endTime,
      reasonStart, reasonEnd, durationMinutes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DowntimeRecord &&
          other.id == this.id &&
          other.stationId == this.stationId &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.reasonStart == this.reasonStart &&
          other.reasonEnd == this.reasonEnd &&
          other.durationMinutes == this.durationMinutes);
}

class DowntimeRecordsCompanion extends UpdateCompanion<DowntimeRecord> {
  final Value<String> id;
  final Value<int> stationId;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<String?> reasonStart;
  final Value<String?> reasonEnd;
  final Value<int> durationMinutes;
  final Value<int> rowid;
  const DowntimeRecordsCompanion({
    this.id = const Value.absent(),
    this.stationId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.reasonStart = const Value.absent(),
    this.reasonEnd = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DowntimeRecordsCompanion.insert({
    required String id,
    required int stationId,
    required DateTime startTime,
    this.endTime = const Value.absent(),
    this.reasonStart = const Value.absent(),
    this.reasonEnd = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        stationId = Value(stationId),
        startTime = Value(startTime);
  static Insertable<DowntimeRecord> custom({
    Expression<String>? id,
    Expression<int>? stationId,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? reasonStart,
    Expression<String>? reasonEnd,
    Expression<int>? durationMinutes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stationId != null) 'station_id': stationId,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (reasonStart != null) 'reason_start': reasonStart,
      if (reasonEnd != null) 'reason_end': reasonEnd,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DowntimeRecordsCompanion copyWith(
      {Value<String>? id,
      Value<int>? stationId,
      Value<DateTime>? startTime,
      Value<DateTime?>? endTime,
      Value<String?>? reasonStart,
      Value<String?>? reasonEnd,
      Value<int>? durationMinutes,
      Value<int>? rowid}) {
    return DowntimeRecordsCompanion(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      reasonStart: reasonStart ?? this.reasonStart,
      reasonEnd: reasonEnd ?? this.reasonEnd,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (stationId.present) {
      map['station_id'] = Variable<int>(stationId.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (reasonStart.present) {
      map['reason_start'] = Variable<String>(reasonStart.value);
    }
    if (reasonEnd.present) {
      map['reason_end'] = Variable<String>(reasonEnd.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DowntimeRecordsCompanion(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('reasonStart: $reasonStart, ')
          ..write('reasonEnd: $reasonEnd, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShiftConfigurationsTable extends ShiftConfigurations
    with TableInfo<$ShiftConfigurationsTable, ShiftConfiguration> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShiftConfigurationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isExtendedModeMeta =
      const VerificationMeta('isExtendedMode');
  @override
  late final GeneratedColumn<bool> isExtendedMode = GeneratedColumn<bool>(
      'is_extended_mode', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_extended_mode" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _shift1ManualProductionMeta =
      const VerificationMeta('shift1ManualProduction');
  @override
  late final GeneratedColumn<int> shift1ManualProduction = GeneratedColumn<int>(
      'shift1_manual_production', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _dailyGoalMeta =
      const VerificationMeta('dailyGoal');
  @override
  late final GeneratedColumn<int> dailyGoal = GeneratedColumn<int>(
      'daily_goal', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(600));
  static const VerificationMeta _minStationGoalMeta =
      const VerificationMeta('minStationGoal');
  @override
  late final GeneratedColumn<int> minStationGoal = GeneratedColumn<int>(
      'min_station_goal', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(40));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        isExtendedMode,
        shift1ManualProduction,
        dailyGoal,
        minStationGoal
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shift_configurations';
  @override
  VerificationContext validateIntegrity(Insertable<ShiftConfiguration> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('is_extended_mode')) {
      context.handle(
          _isExtendedModeMeta,
          isExtendedMode.isAcceptableOrUnknown(
              data['is_extended_mode']!, _isExtendedModeMeta));
    }
    if (data.containsKey('shift1_manual_production')) {
      context.handle(
          _shift1ManualProductionMeta,
          shift1ManualProduction.isAcceptableOrUnknown(
              data['shift1_manual_production']!, _shift1ManualProductionMeta));
    }
    if (data.containsKey('daily_goal')) {
      context.handle(_dailyGoalMeta,
          dailyGoal.isAcceptableOrUnknown(data['daily_goal']!, _dailyGoalMeta));
    }
    if (data.containsKey('min_station_goal')) {
      context.handle(
          _minStationGoalMeta,
          minStationGoal.isAcceptableOrUnknown(
              data['min_station_goal']!, _minStationGoalMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShiftConfiguration map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShiftConfiguration(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      isExtendedMode: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_extended_mode'])!,
      shift1ManualProduction: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}shift1_manual_production'])!,
      dailyGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}daily_goal'])!,
      minStationGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}min_station_goal'])!,
    );
  }

  @override
  $ShiftConfigurationsTable createAlias(String alias) {
    return $ShiftConfigurationsTable(attachedDatabase, alias);
  }
}

class ShiftConfiguration extends DataClass
    implements Insertable<ShiftConfiguration> {
  final String id;
  final DateTime date;
  final bool isExtendedMode;
  final int shift1ManualProduction;
  final int dailyGoal;
  final int minStationGoal;
  const ShiftConfiguration(
      {required this.id,
      required this.date,
      required this.isExtendedMode,
      required this.shift1ManualProduction,
      required this.dailyGoal,
      required this.minStationGoal});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['is_extended_mode'] = Variable<bool>(isExtendedMode);
    map['shift1_manual_production'] = Variable<int>(shift1ManualProduction);
    map['daily_goal'] = Variable<int>(dailyGoal);
    map['min_station_goal'] = Variable<int>(minStationGoal);
    return map;
  }

  ShiftConfigurationsCompanion toCompanion(bool nullToAbsent) {
    return ShiftConfigurationsCompanion(
      id: Value(id),
      date: Value(date),
      isExtendedMode: Value(isExtendedMode),
      shift1ManualProduction: Value(shift1ManualProduction),
      dailyGoal: Value(dailyGoal),
      minStationGoal: Value(minStationGoal),
    );
  }

  factory ShiftConfiguration.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShiftConfiguration(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      isExtendedMode: serializer.fromJson<bool>(json['isExtendedMode']),
      shift1ManualProduction:
          serializer.fromJson<int>(json['shift1ManualProduction']),
      dailyGoal: serializer.fromJson<int>(json['dailyGoal']),
      minStationGoal: serializer.fromJson<int>(json['minStationGoal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'isExtendedMode': serializer.toJson<bool>(isExtendedMode),
      'shift1ManualProduction': serializer.toJson<int>(shift1ManualProduction),
      'dailyGoal': serializer.toJson<int>(dailyGoal),
      'minStationGoal': serializer.toJson<int>(minStationGoal),
    };
  }

  ShiftConfiguration copyWith(
          {String? id,
          DateTime? date,
          bool? isExtendedMode,
          int? shift1ManualProduction,
          int? dailyGoal,
          int? minStationGoal}) =>
      ShiftConfiguration(
        id: id ?? this.id,
        date: date ?? this.date,
        isExtendedMode: isExtendedMode ?? this.isExtendedMode,
        shift1ManualProduction:
            shift1ManualProduction ?? this.shift1ManualProduction,
        dailyGoal: dailyGoal ?? this.dailyGoal,
        minStationGoal: minStationGoal ?? this.minStationGoal,
      );
  ShiftConfiguration copyWithCompanion(ShiftConfigurationsCompanion data) {
    return ShiftConfiguration(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      isExtendedMode: data.isExtendedMode.present
          ? data.isExtendedMode.value
          : this.isExtendedMode,
      shift1ManualProduction: data.shift1ManualProduction.present
          ? data.shift1ManualProduction.value
          : this.shift1ManualProduction,
      dailyGoal: data.dailyGoal.present ? data.dailyGoal.value : this.dailyGoal,
      minStationGoal: data.minStationGoal.present
          ? data.minStationGoal.value
          : this.minStationGoal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShiftConfiguration(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('isExtendedMode: $isExtendedMode, ')
          ..write('shift1ManualProduction: $shift1ManualProduction, ')
          ..write('dailyGoal: $dailyGoal, ')
          ..write('minStationGoal: $minStationGoal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, isExtendedMode,
      shift1ManualProduction, dailyGoal, minStationGoal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShiftConfiguration &&
          other.id == this.id &&
          other.date == this.date &&
          other.isExtendedMode == this.isExtendedMode &&
          other.shift1ManualProduction == this.shift1ManualProduction &&
          other.dailyGoal == this.dailyGoal &&
          other.minStationGoal == this.minStationGoal);
}

class ShiftConfigurationsCompanion extends UpdateCompanion<ShiftConfiguration> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<bool> isExtendedMode;
  final Value<int> shift1ManualProduction;
  final Value<int> dailyGoal;
  final Value<int> minStationGoal;
  final Value<int> rowid;
  const ShiftConfigurationsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.isExtendedMode = const Value.absent(),
    this.shift1ManualProduction = const Value.absent(),
    this.dailyGoal = const Value.absent(),
    this.minStationGoal = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShiftConfigurationsCompanion.insert({
    required String id,
    required DateTime date,
    this.isExtendedMode = const Value.absent(),
    this.shift1ManualProduction = const Value.absent(),
    this.dailyGoal = const Value.absent(),
    this.minStationGoal = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date);
  static Insertable<ShiftConfiguration> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<bool>? isExtendedMode,
    Expression<int>? shift1ManualProduction,
    Expression<int>? dailyGoal,
    Expression<int>? minStationGoal,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (isExtendedMode != null) 'is_extended_mode': isExtendedMode,
      if (shift1ManualProduction != null)
        'shift1_manual_production': shift1ManualProduction,
      if (dailyGoal != null) 'daily_goal': dailyGoal,
      if (minStationGoal != null) 'min_station_goal': minStationGoal,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShiftConfigurationsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? date,
      Value<bool>? isExtendedMode,
      Value<int>? shift1ManualProduction,
      Value<int>? dailyGoal,
      Value<int>? minStationGoal,
      Value<int>? rowid}) {
    return ShiftConfigurationsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      isExtendedMode: isExtendedMode ?? this.isExtendedMode,
      shift1ManualProduction:
          shift1ManualProduction ?? this.shift1ManualProduction,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      minStationGoal: minStationGoal ?? this.minStationGoal,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (isExtendedMode.present) {
      map['is_extended_mode'] = Variable<bool>(isExtendedMode.value);
    }
    if (shift1ManualProduction.present) {
      map['shift1_manual_production'] =
          Variable<int>(shift1ManualProduction.value);
    }
    if (dailyGoal.present) {
      map['daily_goal'] = Variable<int>(dailyGoal.value);
    }
    if (minStationGoal.present) {
      map['min_station_goal'] = Variable<int>(minStationGoal.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShiftConfigurationsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('isExtendedMode: $isExtendedMode, ')
          ..write('shift1ManualProduction: $shift1ManualProduction, ')
          ..write('dailyGoal: $dailyGoal, ')
          ..write('minStationGoal: $minStationGoal, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $Shift1ProductionsTable extends Shift1Productions
    with TableInfo<$Shift1ProductionsTable, Shift1Production> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $Shift1ProductionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _configIdMeta =
      const VerificationMeta('configId');
  @override
  late final GeneratedColumn<String> configId = GeneratedColumn<String>(
      'config_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES shift_configurations (id)'));
  static const VerificationMeta _partTypeIdMeta =
      const VerificationMeta('partTypeId');
  @override
  late final GeneratedColumn<int> partTypeId = GeneratedColumn<int>(
      'part_type_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES part_types (id)'));
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, configId, partTypeId, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shift1_productions';
  @override
  VerificationContext validateIntegrity(Insertable<Shift1Production> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('config_id')) {
      context.handle(_configIdMeta,
          configId.isAcceptableOrUnknown(data['config_id']!, _configIdMeta));
    } else if (isInserting) {
      context.missing(_configIdMeta);
    }
    if (data.containsKey('part_type_id')) {
      context.handle(
          _partTypeIdMeta,
          partTypeId.isAcceptableOrUnknown(
              data['part_type_id']!, _partTypeIdMeta));
    } else if (isInserting) {
      context.missing(_partTypeIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Shift1Production map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Shift1Production(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      configId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}config_id'])!,
      partTypeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}part_type_id'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
    );
  }

  @override
  $Shift1ProductionsTable createAlias(String alias) {
    return $Shift1ProductionsTable(attachedDatabase, alias);
  }
}

class Shift1Production extends DataClass
    implements Insertable<Shift1Production> {
  final int id;
  final String configId;
  final int partTypeId;
  final int quantity;
  const Shift1Production(
      {required this.id,
      required this.configId,
      required this.partTypeId,
      required this.quantity});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['config_id'] = Variable<String>(configId);
    map['part_type_id'] = Variable<int>(partTypeId);
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  Shift1ProductionsCompanion toCompanion(bool nullToAbsent) {
    return Shift1ProductionsCompanion(
      id: Value(id),
      configId: Value(configId),
      partTypeId: Value(partTypeId),
      quantity: Value(quantity),
    );
  }

  factory Shift1Production.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Shift1Production(
      id: serializer.fromJson<int>(json['id']),
      configId: serializer.fromJson<String>(json['configId']),
      partTypeId: serializer.fromJson<int>(json['partTypeId']),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'configId': serializer.toJson<String>(configId),
      'partTypeId': serializer.toJson<int>(partTypeId),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  Shift1Production copyWith(
          {int? id, String? configId, int? partTypeId, int? quantity}) =>
      Shift1Production(
        id: id ?? this.id,
        configId: configId ?? this.configId,
        partTypeId: partTypeId ?? this.partTypeId,
        quantity: quantity ?? this.quantity,
      );
  Shift1Production copyWithCompanion(Shift1ProductionsCompanion data) {
    return Shift1Production(
      id: data.id.present ? data.id.value : this.id,
      configId: data.configId.present ? data.configId.value : this.configId,
      partTypeId:
          data.partTypeId.present ? data.partTypeId.value : this.partTypeId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Shift1Production(')
          ..write('id: $id, ')
          ..write('configId: $configId, ')
          ..write('partTypeId: $partTypeId, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, configId, partTypeId, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Shift1Production &&
          other.id == this.id &&
          other.configId == this.configId &&
          other.partTypeId == this.partTypeId &&
          other.quantity == this.quantity);
}

class Shift1ProductionsCompanion extends UpdateCompanion<Shift1Production> {
  final Value<int> id;
  final Value<String> configId;
  final Value<int> partTypeId;
  final Value<int> quantity;
  const Shift1ProductionsCompanion({
    this.id = const Value.absent(),
    this.configId = const Value.absent(),
    this.partTypeId = const Value.absent(),
    this.quantity = const Value.absent(),
  });
  Shift1ProductionsCompanion.insert({
    this.id = const Value.absent(),
    required String configId,
    required int partTypeId,
    required int quantity,
  })  : configId = Value(configId),
        partTypeId = Value(partTypeId),
        quantity = Value(quantity);
  static Insertable<Shift1Production> custom({
    Expression<int>? id,
    Expression<String>? configId,
    Expression<int>? partTypeId,
    Expression<int>? quantity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (configId != null) 'config_id': configId,
      if (partTypeId != null) 'part_type_id': partTypeId,
      if (quantity != null) 'quantity': quantity,
    });
  }

  Shift1ProductionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? configId,
      Value<int>? partTypeId,
      Value<int>? quantity}) {
    return Shift1ProductionsCompanion(
      id: id ?? this.id,
      configId: configId ?? this.configId,
      partTypeId: partTypeId ?? this.partTypeId,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (configId.present) {
      map['config_id'] = Variable<String>(configId.value);
    }
    if (partTypeId.present) {
      map['part_type_id'] = Variable<int>(partTypeId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('Shift1ProductionsCompanion(')
          ..write('id: $id, ')
          ..write('configId: $configId, ')
          ..write('partTypeId: $partTypeId, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $PackersTable packers = $PackersTable(this);
  late final $StationsTable stations = $StationsTable(this);
  late final $PartTypesTable partTypes = $PartTypesTable(this);
  late final $ProductionRecordsTable productionRecords =
      $ProductionRecordsTable(this);
  late final $DowntimeRecordsTable downtimeRecords =
      $DowntimeRecordsTable(this);
  late final $ShiftConfigurationsTable shiftConfigurations =
      $ShiftConfigurationsTable(this);
  late final $Shift1ProductionsTable shift1Productions =
      $Shift1ProductionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        packers,
        stations,
        partTypes,
        productionRecords,
        downtimeRecords,
        shiftConfigurations,
        shift1Productions
      ];
}

typedef $$PackersTableCreateCompanionBuilder = PackersCompanion Function({
  Value<int> id,
  required String name,
  required String phone,
  required String email,
  Value<String?> photoLocalPath,
  Value<bool> isActive,
});
typedef $$PackersTableUpdateCompanionBuilder = PackersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> phone,
  Value<String> email,
  Value<String?> photoLocalPath,
  Value<bool> isActive,
});

final class $$PackersTableReferences
    extends BaseReferences<_$LocalDatabase, $PackersTable, Packer> {
  $$PackersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductionRecordsTable, List<ProductionRecord>>
      _productionRecordsRefsTable(_$LocalDatabase db) =>
          MultiTypedResultKey.fromTable(db.productionRecords,
              aliasName: $_aliasNameGenerator(
                  db.packers.id, db.productionRecords.packerId));

  $$ProductionRecordsTableProcessedTableManager get productionRecordsRefs {
    final manager =
        $$ProductionRecordsTableTableManager($_db, $_db.productionRecords)
            .filter((f) => f.packerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_productionRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PackersTableFilterComposer
    extends Composer<_$LocalDatabase, $PackersTable> {
  $$PackersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoLocalPath => $composableBuilder(
      column: $table.photoLocalPath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  Expression<bool> productionRecordsRefs(
      Expression<bool> Function($$ProductionRecordsTableFilterComposer f) f) {
    final $$ProductionRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.productionRecords,
        getReferencedColumn: (t) => t.packerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductionRecordsTableFilterComposer(
              $db: $db,
              $table: $db.productionRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PackersTableOrderingComposer
    extends Composer<_$LocalDatabase, $PackersTable> {
  $$PackersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoLocalPath => $composableBuilder(
      column: $table.photoLocalPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$PackersTableAnnotationComposer
    extends Composer<_$LocalDatabase, $PackersTable> {
  $$PackersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get photoLocalPath => $composableBuilder(
      column: $table.photoLocalPath, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> productionRecordsRefs<T extends Object>(
      Expression<T> Function($$ProductionRecordsTableAnnotationComposer a) f) {
    final $$ProductionRecordsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.productionRecords,
            getReferencedColumn: (t) => t.packerId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ProductionRecordsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.productionRecords,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PackersTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $PackersTable,
    Packer,
    $$PackersTableFilterComposer,
    $$PackersTableOrderingComposer,
    $$PackersTableAnnotationComposer,
    $$PackersTableCreateCompanionBuilder,
    $$PackersTableUpdateCompanionBuilder,
    (Packer, $$PackersTableReferences),
    Packer,
    PrefetchHooks Function({bool productionRecordsRefs})> {
  $$PackersTableTableManager(_$LocalDatabase db, $PackersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PackersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PackersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PackersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> phone = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String?> photoLocalPath = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              PackersCompanion(
            id: id,
            name: name,
            phone: phone,
            email: email,
            photoLocalPath: photoLocalPath,
            isActive: isActive,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String phone,
            required String email,
            Value<String?> photoLocalPath = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              PackersCompanion.insert(
            id: id,
            name: name,
            phone: phone,
            email: email,
            photoLocalPath: photoLocalPath,
            isActive: isActive,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PackersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({productionRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productionRecordsRefs) db.productionRecords
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productionRecordsRefs)
                    await $_getPrefetchedData<Packer, $PackersTable,
                            ProductionRecord>(
                        currentTable: table,
                        referencedTable: $$PackersTableReferences
                            ._productionRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PackersTableReferences(db, table, p0)
                                .productionRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.packerId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PackersTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $PackersTable,
    Packer,
    $$PackersTableFilterComposer,
    $$PackersTableOrderingComposer,
    $$PackersTableAnnotationComposer,
    $$PackersTableCreateCompanionBuilder,
    $$PackersTableUpdateCompanionBuilder,
    (Packer, $$PackersTableReferences),
    Packer,
    PrefetchHooks Function({bool productionRecordsRefs})>;
typedef $$StationsTableCreateCompanionBuilder = StationsCompanion Function({
  Value<int> id,
  required String name,
  required String status,
  Value<int?> assignedPackerId1,
  Value<int?> assignedPackerId2,
  Value<int> targetGoal,
});
typedef $$StationsTableUpdateCompanionBuilder = StationsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> status,
  Value<int?> assignedPackerId1,
  Value<int?> assignedPackerId2,
  Value<int> targetGoal,
});

final class $$StationsTableReferences
    extends BaseReferences<_$LocalDatabase, $StationsTable, Station> {
  $$StationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PackersTable _assignedPackerId1Table(_$LocalDatabase db) =>
      db.packers.createAlias(
          $_aliasNameGenerator(db.stations.assignedPackerId1, db.packers.id));

  $$PackersTableProcessedTableManager? get assignedPackerId1 {
    final $_column = $_itemColumn<int>('assigned_packer_id1');
    if ($_column == null) return null;
    final manager = $$PackersTableTableManager($_db, $_db.packers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_assignedPackerId1Table($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PackersTable _assignedPackerId2Table(_$LocalDatabase db) =>
      db.packers.createAlias(
          $_aliasNameGenerator(db.stations.assignedPackerId2, db.packers.id));

  $$PackersTableProcessedTableManager? get assignedPackerId2 {
    final $_column = $_itemColumn<int>('assigned_packer_id2');
    if ($_column == null) return null;
    final manager = $$PackersTableTableManager($_db, $_db.packers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_assignedPackerId2Table($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ProductionRecordsTable, List<ProductionRecord>>
      _productionRecordsRefsTable(_$LocalDatabase db) =>
          MultiTypedResultKey.fromTable(db.productionRecords,
              aliasName: $_aliasNameGenerator(
                  db.stations.id, db.productionRecords.stationId));

  $$ProductionRecordsTableProcessedTableManager get productionRecordsRefs {
    final manager =
        $$ProductionRecordsTableTableManager($_db, $_db.productionRecords)
            .filter((f) => f.stationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_productionRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DowntimeRecordsTable, List<DowntimeRecord>>
      _downtimeRecordsRefsTable(_$LocalDatabase db) =>
          MultiTypedResultKey.fromTable(db.downtimeRecords,
              aliasName: $_aliasNameGenerator(
                  db.stations.id, db.downtimeRecords.stationId));

  $$DowntimeRecordsTableProcessedTableManager get downtimeRecordsRefs {
    final manager =
        $$DowntimeRecordsTableTableManager($_db, $_db.downtimeRecords)
            .filter((f) => f.stationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_downtimeRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$StationsTableFilterComposer
    extends Composer<_$LocalDatabase, $StationsTable> {
  $$StationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetGoal => $composableBuilder(
      column: $table.targetGoal, builder: (column) => ColumnFilters(column));

  $$PackersTableFilterComposer get assignedPackerId1 {
    final $$PackersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assignedPackerId1,
        referencedTable: $db.packers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PackersTableFilterComposer(
              $db: $db,
              $table: $db.packers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PackersTableFilterComposer get assignedPackerId2 {
    final $$PackersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assignedPackerId2,
        referencedTable: $db.packers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PackersTableFilterComposer(
              $db: $db,
              $table: $db.packers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> productionRecordsRefs(
      Expression<bool> Function($$ProductionRecordsTableFilterComposer f) f) {
    final $$ProductionRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.productionRecords,
        getReferencedColumn: (t) => t.stationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductionRecordsTableFilterComposer(
              $db: $db,
              $table: $db.productionRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> downtimeRecordsRefs(
      Expression<bool> Function($$DowntimeRecordsTableFilterComposer f) f) {
    final $$DowntimeRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.downtimeRecords,
        getReferencedColumn: (t) => t.stationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DowntimeRecordsTableFilterComposer(
              $db: $db,
              $table: $db.downtimeRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StationsTableOrderingComposer
    extends Composer<_$LocalDatabase, $StationsTable> {
  $$StationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetGoal => $composableBuilder(
      column: $table.targetGoal, builder: (column) => ColumnOrderings(column));

  $$PackersTableOrderingComposer get assignedPackerId1 {
    final $$PackersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assignedPackerId1,
        referencedTable: $db.packers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PackersTableOrderingComposer(
              $db: $db,
              $table: $db.packers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PackersTableOrderingComposer get assignedPackerId2 {
    final $$PackersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assignedPackerId2,
        referencedTable: $db.packers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PackersTableOrderingComposer(
              $db: $db,
              $table: $db.packers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StationsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $StationsTable> {
  $$StationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get targetGoal => $composableBuilder(
      column: $table.targetGoal, builder: (column) => column);

  $$PackersTableAnnotationComposer get assignedPackerId1 {
    final $$PackersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assignedPackerId1,
        referencedTable: $db.packers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PackersTableAnnotationComposer(
              $db: $db,
              $table: $db.packers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PackersTableAnnotationComposer get assignedPackerId2 {
    final $$PackersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assignedPackerId2,
        referencedTable: $db.packers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PackersTableAnnotationComposer(
              $db: $db,
              $table: $db.packers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> productionRecordsRefs<T extends Object>(
      Expression<T> Function($$ProductionRecordsTableAnnotationComposer a) f) {
    final $$ProductionRecordsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.productionRecords,
            getReferencedColumn: (t) => t.stationId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ProductionRecordsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.productionRecords,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> downtimeRecordsRefs<T extends Object>(
      Expression<T> Function($$DowntimeRecordsTableAnnotationComposer a) f) {
    final $$DowntimeRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.downtimeRecords,
        getReferencedColumn: (t) => t.stationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DowntimeRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.downtimeRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StationsTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $StationsTable,
    Station,
    $$StationsTableFilterComposer,
    $$StationsTableOrderingComposer,
    $$StationsTableAnnotationComposer,
    $$StationsTableCreateCompanionBuilder,
    $$StationsTableUpdateCompanionBuilder,
    (Station, $$StationsTableReferences),
    Station,
    PrefetchHooks Function(
        {bool assignedPackerId1,
        bool assignedPackerId2,
        bool productionRecordsRefs,
        bool downtimeRecordsRefs})> {
  $$StationsTableTableManager(_$LocalDatabase db, $StationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> assignedPackerId1 = const Value.absent(),
            Value<int?> assignedPackerId2 = const Value.absent(),
            Value<int> targetGoal = const Value.absent(),
          }) =>
              StationsCompanion(
            id: id,
            name: name,
            status: status,
            assignedPackerId1: assignedPackerId1,
            assignedPackerId2: assignedPackerId2,
            targetGoal: targetGoal,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String status,
            Value<int?> assignedPackerId1 = const Value.absent(),
            Value<int?> assignedPackerId2 = const Value.absent(),
            Value<int> targetGoal = const Value.absent(),
          }) =>
              StationsCompanion.insert(
            id: id,
            name: name,
            status: status,
            assignedPackerId1: assignedPackerId1,
            assignedPackerId2: assignedPackerId2,
            targetGoal: targetGoal,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$StationsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {assignedPackerId1 = false,
              assignedPackerId2 = false,
              productionRecordsRefs = false,
              downtimeRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productionRecordsRefs) db.productionRecords,
                if (downtimeRecordsRefs) db.downtimeRecords
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (assignedPackerId1) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.assignedPackerId1,
                    referencedTable:
                        $$StationsTableReferences._assignedPackerId1Table(db),
                    referencedColumn: $$StationsTableReferences
                        ._assignedPackerId1Table(db)
                        .id,
                  ) as T;
                }
                if (assignedPackerId2) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.assignedPackerId2,
                    referencedTable:
                        $$StationsTableReferences._assignedPackerId2Table(db),
                    referencedColumn: $$StationsTableReferences
                        ._assignedPackerId2Table(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productionRecordsRefs)
                    await $_getPrefetchedData<Station, $StationsTable,
                            ProductionRecord>(
                        currentTable: table,
                        referencedTable: $$StationsTableReferences
                            ._productionRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StationsTableReferences(db, table, p0)
                                .productionRecordsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.stationId == item.id),
                        typedResults: items),
                  if (downtimeRecordsRefs)
                    await $_getPrefetchedData<Station, $StationsTable,
                            DowntimeRecord>(
                        currentTable: table,
                        referencedTable: $$StationsTableReferences
                            ._downtimeRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StationsTableReferences(db, table, p0)
                                .downtimeRecordsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.stationId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$StationsTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $StationsTable,
    Station,
    $$StationsTableFilterComposer,
    $$StationsTableOrderingComposer,
    $$StationsTableAnnotationComposer,
    $$StationsTableCreateCompanionBuilder,
    $$StationsTableUpdateCompanionBuilder,
    (Station, $$StationsTableReferences),
    Station,
    PrefetchHooks Function(
        {bool assignedPackerId1,
        bool assignedPackerId2,
        bool productionRecordsRefs,
        bool downtimeRecordsRefs})>;
typedef $$PartTypesTableCreateCompanionBuilder = PartTypesCompanion Function({
  Value<int> id,
  required String name,
  Value<bool> isActive,
});
typedef $$PartTypesTableUpdateCompanionBuilder = PartTypesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<bool> isActive,
});

final class $$PartTypesTableReferences
    extends BaseReferences<_$LocalDatabase, $PartTypesTable, PartType> {
  $$PartTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductionRecordsTable, List<ProductionRecord>>
      _productionRecordsRefsTable(_$LocalDatabase db) =>
          MultiTypedResultKey.fromTable(db.productionRecords,
              aliasName: $_aliasNameGenerator(
                  db.partTypes.id, db.productionRecords.partTypeId));

  $$ProductionRecordsTableProcessedTableManager get productionRecordsRefs {
    final manager =
        $$ProductionRecordsTableTableManager($_db, $_db.productionRecords)
            .filter((f) => f.partTypeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_productionRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$Shift1ProductionsTable, List<Shift1Production>>
      _shift1ProductionsRefsTable(_$LocalDatabase db) =>
          MultiTypedResultKey.fromTable(db.shift1Productions,
              aliasName: $_aliasNameGenerator(
                  db.partTypes.id, db.shift1Productions.partTypeId));

  $$Shift1ProductionsTableProcessedTableManager get shift1ProductionsRefs {
    final manager =
        $$Shift1ProductionsTableTableManager($_db, $_db.shift1Productions)
            .filter((f) => f.partTypeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_shift1ProductionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PartTypesTableFilterComposer
    extends Composer<_$LocalDatabase, $PartTypesTable> {
  $$PartTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  Expression<bool> productionRecordsRefs(
      Expression<bool> Function($$ProductionRecordsTableFilterComposer f) f) {
    final $$ProductionRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.productionRecords,
        getReferencedColumn: (t) => t.partTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductionRecordsTableFilterComposer(
              $db: $db,
              $table: $db.productionRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> shift1ProductionsRefs(
      Expression<bool> Function($$Shift1ProductionsTableFilterComposer f) f) {
    final $$Shift1ProductionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.shift1Productions,
        getReferencedColumn: (t) => t.partTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$Shift1ProductionsTableFilterComposer(
              $db: $db,
              $table: $db.shift1Productions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PartTypesTableOrderingComposer
    extends Composer<_$LocalDatabase, $PartTypesTable> {
  $$PartTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$PartTypesTableAnnotationComposer
    extends Composer<_$LocalDatabase, $PartTypesTable> {
  $$PartTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> productionRecordsRefs<T extends Object>(
      Expression<T> Function($$ProductionRecordsTableAnnotationComposer a) f) {
    final $$ProductionRecordsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.productionRecords,
            getReferencedColumn: (t) => t.partTypeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ProductionRecordsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.productionRecords,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> shift1ProductionsRefs<T extends Object>(
      Expression<T> Function($$Shift1ProductionsTableAnnotationComposer a) f) {
    final $$Shift1ProductionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.shift1Productions,
            getReferencedColumn: (t) => t.partTypeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$Shift1ProductionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.shift1Productions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PartTypesTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $PartTypesTable,
    PartType,
    $$PartTypesTableFilterComposer,
    $$PartTypesTableOrderingComposer,
    $$PartTypesTableAnnotationComposer,
    $$PartTypesTableCreateCompanionBuilder,
    $$PartTypesTableUpdateCompanionBuilder,
    (PartType, $$PartTypesTableReferences),
    PartType,
    PrefetchHooks Function(
        {bool productionRecordsRefs, bool shift1ProductionsRefs})> {
  $$PartTypesTableTableManager(_$LocalDatabase db, $PartTypesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PartTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PartTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PartTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              PartTypesCompanion(
            id: id,
            name: name,
            isActive: isActive,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<bool> isActive = const Value.absent(),
          }) =>
              PartTypesCompanion.insert(
            id: id,
            name: name,
            isActive: isActive,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PartTypesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {productionRecordsRefs = false, shift1ProductionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productionRecordsRefs) db.productionRecords,
                if (shift1ProductionsRefs) db.shift1Productions
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productionRecordsRefs)
                    await $_getPrefetchedData<PartType, $PartTypesTable,
                            ProductionRecord>(
                        currentTable: table,
                        referencedTable: $$PartTypesTableReferences
                            ._productionRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PartTypesTableReferences(db, table, p0)
                                .productionRecordsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.partTypeId == item.id),
                        typedResults: items),
                  if (shift1ProductionsRefs)
                    await $_getPrefetchedData<PartType, $PartTypesTable,
                            Shift1Production>(
                        currentTable: table,
                        referencedTable: $$PartTypesTableReferences
                            ._shift1ProductionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PartTypesTableReferences(db, table, p0)
                                .shift1ProductionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.partTypeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PartTypesTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $PartTypesTable,
    PartType,
    $$PartTypesTableFilterComposer,
    $$PartTypesTableOrderingComposer,
    $$PartTypesTableAnnotationComposer,
    $$PartTypesTableCreateCompanionBuilder,
    $$PartTypesTableUpdateCompanionBuilder,
    (PartType, $$PartTypesTableReferences),
    PartType,
    PrefetchHooks Function(
        {bool productionRecordsRefs, bool shift1ProductionsRefs})>;
typedef $$ProductionRecordsTableCreateCompanionBuilder
    = ProductionRecordsCompanion Function({
  required String id,
  required int stationId,
  required int packerId,
  required ProductionType type,
  required String barcode,
  required int volumeCount,
  required int itemCount,
  required DateTime timestamp,
  required int shiftId,
  Value<int?> partTypeId,
  Value<int> rowid,
});
typedef $$ProductionRecordsTableUpdateCompanionBuilder
    = ProductionRecordsCompanion Function({
  Value<String> id,
  Value<int> stationId,
  Value<int> packerId,
  Value<ProductionType> type,
  Value<String> barcode,
  Value<int> volumeCount,
  Value<int> itemCount,
  Value<DateTime> timestamp,
  Value<int> shiftId,
  Value<int?> partTypeId,
  Value<int> rowid,
});

final class $$ProductionRecordsTableReferences extends BaseReferences<
    _$LocalDatabase, $ProductionRecordsTable, ProductionRecord> {
  $$ProductionRecordsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $StationsTable _stationIdTable(_$LocalDatabase db) =>
      db.stations.createAlias(
          $_aliasNameGenerator(db.productionRecords.stationId, db.stations.id));

  $$StationsTableProcessedTableManager get stationId {
    final $_column = $_itemColumn<int>('station_id')!;

    final manager = $$StationsTableTableManager($_db, $_db.stations)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_stationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PackersTable _packerIdTable(_$LocalDatabase db) =>
      db.packers.createAlias(
          $_aliasNameGenerator(db.productionRecords.packerId, db.packers.id));

  $$PackersTableProcessedTableManager get packerId {
    final $_column = $_itemColumn<int>('packer_id')!;

    final manager = $$PackersTableTableManager($_db, $_db.packers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_packerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PartTypesTable _partTypeIdTable(_$LocalDatabase db) =>
      db.partTypes.createAlias($_aliasNameGenerator(
          db.productionRecords.partTypeId, db.partTypes.id));

  $$PartTypesTableProcessedTableManager? get partTypeId {
    final $_column = $_itemColumn<int>('part_type_id');
    if ($_column == null) return null;
    final manager = $$PartTypesTableTableManager($_db, $_db.partTypes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ProductionRecordsTableFilterComposer
    extends Composer<_$LocalDatabase, $ProductionRecordsTable> {
  $$ProductionRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ProductionType, ProductionType, int>
      get type => $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get volumeCount => $composableBuilder(
      column: $table.volumeCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get itemCount => $composableBuilder(
      column: $table.itemCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get shiftId => $composableBuilder(
      column: $table.shiftId, builder: (column) => ColumnFilters(column));

  $$StationsTableFilterComposer get stationId {
    final $$StationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.stationId,
        referencedTable: $db.stations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StationsTableFilterComposer(
              $db: $db,
              $table: $db.stations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PackersTableFilterComposer get packerId {
    final $$PackersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.packerId,
        referencedTable: $db.packers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PackersTableFilterComposer(
              $db: $db,
              $table: $db.packers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PartTypesTableFilterComposer get partTypeId {
    final $$PartTypesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partTypeId,
        referencedTable: $db.partTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTypesTableFilterComposer(
              $db: $db,
              $table: $db.partTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductionRecordsTableOrderingComposer
    extends Composer<_$LocalDatabase, $ProductionRecordsTable> {
  $$ProductionRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get volumeCount => $composableBuilder(
      column: $table.volumeCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get itemCount => $composableBuilder(
      column: $table.itemCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get shiftId => $composableBuilder(
      column: $table.shiftId, builder: (column) => ColumnOrderings(column));

  $$StationsTableOrderingComposer get stationId {
    final $$StationsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.stationId,
        referencedTable: $db.stations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StationsTableOrderingComposer(
              $db: $db,
              $table: $db.stations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PackersTableOrderingComposer get packerId {
    final $$PackersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.packerId,
        referencedTable: $db.packers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PackersTableOrderingComposer(
              $db: $db,
              $table: $db.packers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PartTypesTableOrderingComposer get partTypeId {
    final $$PartTypesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partTypeId,
        referencedTable: $db.partTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTypesTableOrderingComposer(
              $db: $db,
              $table: $db.partTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductionRecordsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $ProductionRecordsTable> {
  $$ProductionRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ProductionType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<int> get volumeCount => $composableBuilder(
      column: $table.volumeCount, builder: (column) => column);

  GeneratedColumn<int> get itemCount =>
      $composableBuilder(column: $table.itemCount, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get shiftId =>
      $composableBuilder(column: $table.shiftId, builder: (column) => column);

  $$StationsTableAnnotationComposer get stationId {
    final $$StationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.stationId,
        referencedTable: $db.stations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StationsTableAnnotationComposer(
              $db: $db,
              $table: $db.stations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PackersTableAnnotationComposer get packerId {
    final $$PackersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.packerId,
        referencedTable: $db.packers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PackersTableAnnotationComposer(
              $db: $db,
              $table: $db.packers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PartTypesTableAnnotationComposer get partTypeId {
    final $$PartTypesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partTypeId,
        referencedTable: $db.partTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTypesTableAnnotationComposer(
              $db: $db,
              $table: $db.partTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductionRecordsTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $ProductionRecordsTable,
    ProductionRecord,
    $$ProductionRecordsTableFilterComposer,
    $$ProductionRecordsTableOrderingComposer,
    $$ProductionRecordsTableAnnotationComposer,
    $$ProductionRecordsTableCreateCompanionBuilder,
    $$ProductionRecordsTableUpdateCompanionBuilder,
    (ProductionRecord, $$ProductionRecordsTableReferences),
    ProductionRecord,
    PrefetchHooks Function({bool stationId, bool packerId, bool partTypeId})> {
  $$ProductionRecordsTableTableManager(
      _$LocalDatabase db, $ProductionRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductionRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductionRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductionRecordsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> stationId = const Value.absent(),
            Value<int> packerId = const Value.absent(),
            Value<ProductionType> type = const Value.absent(),
            Value<String> barcode = const Value.absent(),
            Value<int> volumeCount = const Value.absent(),
            Value<int> itemCount = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<int> shiftId = const Value.absent(),
            Value<int?> partTypeId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductionRecordsCompanion(
            id: id,
            stationId: stationId,
            packerId: packerId,
            type: type,
            barcode: barcode,
            volumeCount: volumeCount,
            itemCount: itemCount,
            timestamp: timestamp,
            shiftId: shiftId,
            partTypeId: partTypeId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int stationId,
            required int packerId,
            required ProductionType type,
            required String barcode,
            required int volumeCount,
            required int itemCount,
            required DateTime timestamp,
            required int shiftId,
            Value<int?> partTypeId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductionRecordsCompanion.insert(
            id: id,
            stationId: stationId,
            packerId: packerId,
            type: type,
            barcode: barcode,
            volumeCount: volumeCount,
            itemCount: itemCount,
            timestamp: timestamp,
            shiftId: shiftId,
            partTypeId: partTypeId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ProductionRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {stationId = false, packerId = false, partTypeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (stationId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.stationId,
                    referencedTable:
                        $$ProductionRecordsTableReferences._stationIdTable(db),
                    referencedColumn: $$ProductionRecordsTableReferences
                        ._stationIdTable(db)
                        .id,
                  ) as T;
                }
                if (packerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.packerId,
                    referencedTable:
                        $$ProductionRecordsTableReferences._packerIdTable(db),
                    referencedColumn: $$ProductionRecordsTableReferences
                        ._packerIdTable(db)
                        .id,
                  ) as T;
                }
                if (partTypeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.partTypeId,
                    referencedTable:
                        $$ProductionRecordsTableReferences._partTypeIdTable(db),
                    referencedColumn: $$ProductionRecordsTableReferences
                        ._partTypeIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ProductionRecordsTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $ProductionRecordsTable,
    ProductionRecord,
    $$ProductionRecordsTableFilterComposer,
    $$ProductionRecordsTableOrderingComposer,
    $$ProductionRecordsTableAnnotationComposer,
    $$ProductionRecordsTableCreateCompanionBuilder,
    $$ProductionRecordsTableUpdateCompanionBuilder,
    (ProductionRecord, $$ProductionRecordsTableReferences),
    ProductionRecord,
    PrefetchHooks Function({bool stationId, bool packerId, bool partTypeId})>;
typedef $$DowntimeRecordsTableCreateCompanionBuilder = DowntimeRecordsCompanion
    Function({
  required String id,
  required int stationId,
  required DateTime startTime,
  Value<DateTime?> endTime,
  Value<String?> reasonStart,
  Value<String?> reasonEnd,
  Value<int> durationMinutes,
  Value<int> rowid,
});
typedef $$DowntimeRecordsTableUpdateCompanionBuilder = DowntimeRecordsCompanion
    Function({
  Value<String> id,
  Value<int> stationId,
  Value<DateTime> startTime,
  Value<DateTime?> endTime,
  Value<String?> reasonStart,
  Value<String?> reasonEnd,
  Value<int> durationMinutes,
  Value<int> rowid,
});

final class $$DowntimeRecordsTableReferences extends BaseReferences<
    _$LocalDatabase, $DowntimeRecordsTable, DowntimeRecord> {
  $$DowntimeRecordsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $StationsTable _stationIdTable(_$LocalDatabase db) =>
      db.stations.createAlias(
          $_aliasNameGenerator(db.downtimeRecords.stationId, db.stations.id));

  $$StationsTableProcessedTableManager get stationId {
    final $_column = $_itemColumn<int>('station_id')!;

    final manager = $$StationsTableTableManager($_db, $_db.stations)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_stationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DowntimeRecordsTableFilterComposer
    extends Composer<_$LocalDatabase, $DowntimeRecordsTable> {
  $$DowntimeRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reasonStart => $composableBuilder(
      column: $table.reasonStart, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reasonEnd => $composableBuilder(
      column: $table.reasonEnd, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  $$StationsTableFilterComposer get stationId {
    final $$StationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.stationId,
        referencedTable: $db.stations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StationsTableFilterComposer(
              $db: $db,
              $table: $db.stations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DowntimeRecordsTableOrderingComposer
    extends Composer<_$LocalDatabase, $DowntimeRecordsTable> {
  $$DowntimeRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reasonStart => $composableBuilder(
      column: $table.reasonStart, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reasonEnd => $composableBuilder(
      column: $table.reasonEnd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  $$StationsTableOrderingComposer get stationId {
    final $$StationsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.stationId,
        referencedTable: $db.stations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StationsTableOrderingComposer(
              $db: $db,
              $table: $db.stations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DowntimeRecordsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $DowntimeRecordsTable> {
  $$DowntimeRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get reasonStart => $composableBuilder(
      column: $table.reasonStart, builder: (column) => column);

  GeneratedColumn<String> get reasonEnd =>
      $composableBuilder(column: $table.reasonEnd, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  $$StationsTableAnnotationComposer get stationId {
    final $$StationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.stationId,
        referencedTable: $db.stations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StationsTableAnnotationComposer(
              $db: $db,
              $table: $db.stations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DowntimeRecordsTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $DowntimeRecordsTable,
    DowntimeRecord,
    $$DowntimeRecordsTableFilterComposer,
    $$DowntimeRecordsTableOrderingComposer,
    $$DowntimeRecordsTableAnnotationComposer,
    $$DowntimeRecordsTableCreateCompanionBuilder,
    $$DowntimeRecordsTableUpdateCompanionBuilder,
    (DowntimeRecord, $$DowntimeRecordsTableReferences),
    DowntimeRecord,
    PrefetchHooks Function({bool stationId})> {
  $$DowntimeRecordsTableTableManager(
      _$LocalDatabase db, $DowntimeRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DowntimeRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DowntimeRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DowntimeRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> stationId = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<String?> reasonStart = const Value.absent(),
            Value<String?> reasonEnd = const Value.absent(),
            Value<int> durationMinutes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DowntimeRecordsCompanion(
            id: id,
            stationId: stationId,
            startTime: startTime,
            endTime: endTime,
            reasonStart: reasonStart,
            reasonEnd: reasonEnd,
            durationMinutes: durationMinutes,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int stationId,
            required DateTime startTime,
            Value<DateTime?> endTime = const Value.absent(),
            Value<String?> reasonStart = const Value.absent(),
            Value<String?> reasonEnd = const Value.absent(),
            Value<int> durationMinutes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DowntimeRecordsCompanion.insert(
            id: id,
            stationId: stationId,
            startTime: startTime,
            endTime: endTime,
            reasonStart: reasonStart,
            reasonEnd: reasonEnd,
            durationMinutes: durationMinutes,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DowntimeRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({stationId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (stationId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.stationId,
                    referencedTable:
                        $$DowntimeRecordsTableReferences._stationIdTable(db),
                    referencedColumn:
                        $$DowntimeRecordsTableReferences._stationIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DowntimeRecordsTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $DowntimeRecordsTable,
    DowntimeRecord,
    $$DowntimeRecordsTableFilterComposer,
    $$DowntimeRecordsTableOrderingComposer,
    $$DowntimeRecordsTableAnnotationComposer,
    $$DowntimeRecordsTableCreateCompanionBuilder,
    $$DowntimeRecordsTableUpdateCompanionBuilder,
    (DowntimeRecord, $$DowntimeRecordsTableReferences),
    DowntimeRecord,
    PrefetchHooks Function({bool stationId})>;
typedef $$ShiftConfigurationsTableCreateCompanionBuilder
    = ShiftConfigurationsCompanion Function({
  required String id,
  required DateTime date,
  Value<bool> isExtendedMode,
  Value<int> shift1ManualProduction,
  Value<int> dailyGoal,
  Value<int> minStationGoal,
  Value<int> rowid,
});
typedef $$ShiftConfigurationsTableUpdateCompanionBuilder
    = ShiftConfigurationsCompanion Function({
  Value<String> id,
  Value<DateTime> date,
  Value<bool> isExtendedMode,
  Value<int> shift1ManualProduction,
  Value<int> dailyGoal,
  Value<int> minStationGoal,
  Value<int> rowid,
});

final class $$ShiftConfigurationsTableReferences extends BaseReferences<
    _$LocalDatabase, $ShiftConfigurationsTable, ShiftConfiguration> {
  $$ShiftConfigurationsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$Shift1ProductionsTable, List<Shift1Production>>
      _shift1ProductionsRefsTable(_$LocalDatabase db) =>
          MultiTypedResultKey.fromTable(db.shift1Productions,
              aliasName: $_aliasNameGenerator(
                  db.shiftConfigurations.id, db.shift1Productions.configId));

  $$Shift1ProductionsTableProcessedTableManager get shift1ProductionsRefs {
    final manager = $$Shift1ProductionsTableTableManager(
            $_db, $_db.shift1Productions)
        .filter((f) => f.configId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_shift1ProductionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ShiftConfigurationsTableFilterComposer
    extends Composer<_$LocalDatabase, $ShiftConfigurationsTable> {
  $$ShiftConfigurationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isExtendedMode => $composableBuilder(
      column: $table.isExtendedMode,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get shift1ManualProduction => $composableBuilder(
      column: $table.shift1ManualProduction,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dailyGoal => $composableBuilder(
      column: $table.dailyGoal, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minStationGoal => $composableBuilder(
      column: $table.minStationGoal,
      builder: (column) => ColumnFilters(column));

  Expression<bool> shift1ProductionsRefs(
      Expression<bool> Function($$Shift1ProductionsTableFilterComposer f) f) {
    final $$Shift1ProductionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.shift1Productions,
        getReferencedColumn: (t) => t.configId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$Shift1ProductionsTableFilterComposer(
              $db: $db,
              $table: $db.shift1Productions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ShiftConfigurationsTableOrderingComposer
    extends Composer<_$LocalDatabase, $ShiftConfigurationsTable> {
  $$ShiftConfigurationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isExtendedMode => $composableBuilder(
      column: $table.isExtendedMode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get shift1ManualProduction => $composableBuilder(
      column: $table.shift1ManualProduction,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dailyGoal => $composableBuilder(
      column: $table.dailyGoal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minStationGoal => $composableBuilder(
      column: $table.minStationGoal,
      builder: (column) => ColumnOrderings(column));
}

class $$ShiftConfigurationsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $ShiftConfigurationsTable> {
  $$ShiftConfigurationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get isExtendedMode => $composableBuilder(
      column: $table.isExtendedMode, builder: (column) => column);

  GeneratedColumn<int> get shift1ManualProduction => $composableBuilder(
      column: $table.shift1ManualProduction, builder: (column) => column);

  GeneratedColumn<int> get dailyGoal =>
      $composableBuilder(column: $table.dailyGoal, builder: (column) => column);

  GeneratedColumn<int> get minStationGoal => $composableBuilder(
      column: $table.minStationGoal, builder: (column) => column);

  Expression<T> shift1ProductionsRefs<T extends Object>(
      Expression<T> Function($$Shift1ProductionsTableAnnotationComposer a) f) {
    final $$Shift1ProductionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.shift1Productions,
            getReferencedColumn: (t) => t.configId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$Shift1ProductionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.shift1Productions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ShiftConfigurationsTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $ShiftConfigurationsTable,
    ShiftConfiguration,
    $$ShiftConfigurationsTableFilterComposer,
    $$ShiftConfigurationsTableOrderingComposer,
    $$ShiftConfigurationsTableAnnotationComposer,
    $$ShiftConfigurationsTableCreateCompanionBuilder,
    $$ShiftConfigurationsTableUpdateCompanionBuilder,
    (ShiftConfiguration, $$ShiftConfigurationsTableReferences),
    ShiftConfiguration,
    PrefetchHooks Function({bool shift1ProductionsRefs})> {
  $$ShiftConfigurationsTableTableManager(
      _$LocalDatabase db, $ShiftConfigurationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShiftConfigurationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShiftConfigurationsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShiftConfigurationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<bool> isExtendedMode = const Value.absent(),
            Value<int> shift1ManualProduction = const Value.absent(),
            Value<int> dailyGoal = const Value.absent(),
            Value<int> minStationGoal = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ShiftConfigurationsCompanion(
            id: id,
            date: date,
            isExtendedMode: isExtendedMode,
            shift1ManualProduction: shift1ManualProduction,
            dailyGoal: dailyGoal,
            minStationGoal: minStationGoal,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime date,
            Value<bool> isExtendedMode = const Value.absent(),
            Value<int> shift1ManualProduction = const Value.absent(),
            Value<int> dailyGoal = const Value.absent(),
            Value<int> minStationGoal = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ShiftConfigurationsCompanion.insert(
            id: id,
            date: date,
            isExtendedMode: isExtendedMode,
            shift1ManualProduction: shift1ManualProduction,
            dailyGoal: dailyGoal,
            minStationGoal: minStationGoal,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ShiftConfigurationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({shift1ProductionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (shift1ProductionsRefs) db.shift1Productions
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (shift1ProductionsRefs)
                    await $_getPrefetchedData<ShiftConfiguration,
                            $ShiftConfigurationsTable, Shift1Production>(
                        currentTable: table,
                        referencedTable: $$ShiftConfigurationsTableReferences
                            ._shift1ProductionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ShiftConfigurationsTableReferences(db, table, p0)
                                .shift1ProductionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.configId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ShiftConfigurationsTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $ShiftConfigurationsTable,
    ShiftConfiguration,
    $$ShiftConfigurationsTableFilterComposer,
    $$ShiftConfigurationsTableOrderingComposer,
    $$ShiftConfigurationsTableAnnotationComposer,
    $$ShiftConfigurationsTableCreateCompanionBuilder,
    $$ShiftConfigurationsTableUpdateCompanionBuilder,
    (ShiftConfiguration, $$ShiftConfigurationsTableReferences),
    ShiftConfiguration,
    PrefetchHooks Function({bool shift1ProductionsRefs})>;
typedef $$Shift1ProductionsTableCreateCompanionBuilder
    = Shift1ProductionsCompanion Function({
  Value<int> id,
  required String configId,
  required int partTypeId,
  required int quantity,
});
typedef $$Shift1ProductionsTableUpdateCompanionBuilder
    = Shift1ProductionsCompanion Function({
  Value<int> id,
  Value<String> configId,
  Value<int> partTypeId,
  Value<int> quantity,
});

final class $$Shift1ProductionsTableReferences extends BaseReferences<
    _$LocalDatabase, $Shift1ProductionsTable, Shift1Production> {
  $$Shift1ProductionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ShiftConfigurationsTable _configIdTable(_$LocalDatabase db) =>
      db.shiftConfigurations.createAlias($_aliasNameGenerator(
          db.shift1Productions.configId, db.shiftConfigurations.id));

  $$ShiftConfigurationsTableProcessedTableManager get configId {
    final $_column = $_itemColumn<String>('config_id')!;

    final manager =
        $$ShiftConfigurationsTableTableManager($_db, $_db.shiftConfigurations)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_configIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PartTypesTable _partTypeIdTable(_$LocalDatabase db) =>
      db.partTypes.createAlias($_aliasNameGenerator(
          db.shift1Productions.partTypeId, db.partTypes.id));

  $$PartTypesTableProcessedTableManager get partTypeId {
    final $_column = $_itemColumn<int>('part_type_id')!;

    final manager = $$PartTypesTableTableManager($_db, $_db.partTypes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$Shift1ProductionsTableFilterComposer
    extends Composer<_$LocalDatabase, $Shift1ProductionsTable> {
  $$Shift1ProductionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  $$ShiftConfigurationsTableFilterComposer get configId {
    final $$ShiftConfigurationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.configId,
        referencedTable: $db.shiftConfigurations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ShiftConfigurationsTableFilterComposer(
              $db: $db,
              $table: $db.shiftConfigurations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PartTypesTableFilterComposer get partTypeId {
    final $$PartTypesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partTypeId,
        referencedTable: $db.partTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTypesTableFilterComposer(
              $db: $db,
              $table: $db.partTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$Shift1ProductionsTableOrderingComposer
    extends Composer<_$LocalDatabase, $Shift1ProductionsTable> {
  $$Shift1ProductionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  $$ShiftConfigurationsTableOrderingComposer get configId {
    final $$ShiftConfigurationsTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.configId,
            referencedTable: $db.shiftConfigurations,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ShiftConfigurationsTableOrderingComposer(
                  $db: $db,
                  $table: $db.shiftConfigurations,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$PartTypesTableOrderingComposer get partTypeId {
    final $$PartTypesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partTypeId,
        referencedTable: $db.partTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTypesTableOrderingComposer(
              $db: $db,
              $table: $db.partTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$Shift1ProductionsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $Shift1ProductionsTable> {
  $$Shift1ProductionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  $$ShiftConfigurationsTableAnnotationComposer get configId {
    final $$ShiftConfigurationsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.configId,
            referencedTable: $db.shiftConfigurations,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ShiftConfigurationsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.shiftConfigurations,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$PartTypesTableAnnotationComposer get partTypeId {
    final $$PartTypesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partTypeId,
        referencedTable: $db.partTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTypesTableAnnotationComposer(
              $db: $db,
              $table: $db.partTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$Shift1ProductionsTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $Shift1ProductionsTable,
    Shift1Production,
    $$Shift1ProductionsTableFilterComposer,
    $$Shift1ProductionsTableOrderingComposer,
    $$Shift1ProductionsTableAnnotationComposer,
    $$Shift1ProductionsTableCreateCompanionBuilder,
    $$Shift1ProductionsTableUpdateCompanionBuilder,
    (Shift1Production, $$Shift1ProductionsTableReferences),
    Shift1Production,
    PrefetchHooks Function({bool configId, bool partTypeId})> {
  $$Shift1ProductionsTableTableManager(
      _$LocalDatabase db, $Shift1ProductionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$Shift1ProductionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$Shift1ProductionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$Shift1ProductionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> configId = const Value.absent(),
            Value<int> partTypeId = const Value.absent(),
            Value<int> quantity = const Value.absent(),
          }) =>
              Shift1ProductionsCompanion(
            id: id,
            configId: configId,
            partTypeId: partTypeId,
            quantity: quantity,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String configId,
            required int partTypeId,
            required int quantity,
          }) =>
              Shift1ProductionsCompanion.insert(
            id: id,
            configId: configId,
            partTypeId: partTypeId,
            quantity: quantity,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$Shift1ProductionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({configId = false, partTypeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (configId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.configId,
                    referencedTable:
                        $$Shift1ProductionsTableReferences._configIdTable(db),
                    referencedColumn: $$Shift1ProductionsTableReferences
                        ._configIdTable(db)
                        .id,
                  ) as T;
                }
                if (partTypeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.partTypeId,
                    referencedTable:
                        $$Shift1ProductionsTableReferences._partTypeIdTable(db),
                    referencedColumn: $$Shift1ProductionsTableReferences
                        ._partTypeIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$Shift1ProductionsTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $Shift1ProductionsTable,
    Shift1Production,
    $$Shift1ProductionsTableFilterComposer,
    $$Shift1ProductionsTableOrderingComposer,
    $$Shift1ProductionsTableAnnotationComposer,
    $$Shift1ProductionsTableCreateCompanionBuilder,
    $$Shift1ProductionsTableUpdateCompanionBuilder,
    (Shift1Production, $$Shift1ProductionsTableReferences),
    Shift1Production,
    PrefetchHooks Function({bool configId, bool partTypeId})>;

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$PackersTableTableManager get packers =>
      $$PackersTableTableManager(_db, _db.packers);
  $$StationsTableTableManager get stations =>
      $$StationsTableTableManager(_db, _db.stations);
  $$PartTypesTableTableManager get partTypes =>
      $$PartTypesTableTableManager(_db, _db.partTypes);
  $$ProductionRecordsTableTableManager get productionRecords =>
      $$ProductionRecordsTableTableManager(_db, _db.productionRecords);
  $$DowntimeRecordsTableTableManager get downtimeRecords =>
      $$DowntimeRecordsTableTableManager(_db, _db.downtimeRecords);
  $$ShiftConfigurationsTableTableManager get shiftConfigurations =>
      $$ShiftConfigurationsTableTableManager(_db, _db.shiftConfigurations);
  $$Shift1ProductionsTableTableManager get shift1Productions =>
      $$Shift1ProductionsTableTableManager(_db, _db.shift1Productions);
}
