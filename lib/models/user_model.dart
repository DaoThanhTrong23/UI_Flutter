import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';
import 'dart:typed_data';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String mssv,
    required String name,
    String? avatar,
    @JsonKey(name: 'avatar_base64') String? avatarBase64,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

@freezed
class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    required AcademicInfo academic,
    required PersonalInfo personal,
    String? avatar,
    @JsonKey(name: 'avatar_base64') String? avatarBase64,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => _$UserProfileModelFromJson(json);
}

@freezed
class AcademicInfo with _$AcademicInfo {
  const factory AcademicInfo({
    required String status,
    required String className,
    required String educationType,
    required String course,
    required String major,
    required String specialization,
  }) = _AcademicInfo;

  factory AcademicInfo.fromJson(Map<String, dynamic> json) => _$AcademicInfoFromJson(json);
}

@freezed
class PersonalInfo with _$PersonalInfo {
  const factory PersonalInfo({
    required String fullName,
    required String mssv,
    required String dob,
    required String gender,
    required String pob,
    required String phone,
    required String email,
  }) = _PersonalInfo;

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => _$PersonalInfoFromJson(json);
}

Uint8List? safeDecodeBase64(String? b64) {
  if (b64 == null || b64.isEmpty) return null;
  try {
    String clean = b64.replaceAll(RegExp(r'\s+'), '');
    if (clean.contains(',')) clean = clean.split(',').last;
    return base64Decode(base64.normalize(clean));
  } catch (e) {
    return null;
  }
}
