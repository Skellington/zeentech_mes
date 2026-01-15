import 'package:freezed_annotation/freezed_annotation.dart';

part 'packer.freezed.dart';
part 'packer.g.dart';

@freezed
abstract class Packer with _$Packer {
  const factory Packer({
    required int id,
    required String name,
    required String phone,
    required String email,
    String? photoLocalPath,
    @Default(true) bool isActive,
  }) = _Packer;

  factory Packer.fromJson(Map<String, dynamic> json) => _$PackerFromJson(json);
}
