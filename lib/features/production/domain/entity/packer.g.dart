// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Packer _$PackerFromJson(Map<String, dynamic> json) => _Packer(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      photoLocalPath: json['photoLocalPath'] as String?,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$PackerToJson(_Packer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'photoLocalPath': instance.photoLocalPath,
      'isActive': instance.isActive,
    };
