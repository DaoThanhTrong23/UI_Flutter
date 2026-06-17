// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      mssv: json['mssv'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      avatarBase64: json['avatar_base64'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'mssv': instance.mssv,
      'name': instance.name,
      'avatar': instance.avatar,
      'avatar_base64': instance.avatarBase64,
    };

_$UserProfileModelImpl _$$UserProfileModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserProfileModelImpl(
  academic: AcademicInfo.fromJson(json['academic'] as Map<String, dynamic>),
  personal: PersonalInfo.fromJson(json['personal'] as Map<String, dynamic>),
  avatar: json['avatar'] as String?,
  avatarBase64: json['avatar_base64'] as String?,
);

Map<String, dynamic> _$$UserProfileModelImplToJson(
  _$UserProfileModelImpl instance,
) => <String, dynamic>{
  'academic': instance.academic,
  'personal': instance.personal,
  'avatar': instance.avatar,
  'avatar_base64': instance.avatarBase64,
};

_$AcademicInfoImpl _$$AcademicInfoImplFromJson(Map<String, dynamic> json) =>
    _$AcademicInfoImpl(
      status: json['status'] as String,
      className: json['className'] as String,
      educationType: json['educationType'] as String,
      course: json['course'] as String,
      major: json['major'] as String,
      specialization: json['specialization'] as String,
    );

Map<String, dynamic> _$$AcademicInfoImplToJson(_$AcademicInfoImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'className': instance.className,
      'educationType': instance.educationType,
      'course': instance.course,
      'major': instance.major,
      'specialization': instance.specialization,
    };

_$PersonalInfoImpl _$$PersonalInfoImplFromJson(Map<String, dynamic> json) =>
    _$PersonalInfoImpl(
      fullName: json['fullName'] as String,
      mssv: json['mssv'] as String,
      dob: json['dob'] as String,
      gender: json['gender'] as String,
      pob: json['pob'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$PersonalInfoImplToJson(_$PersonalInfoImpl instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'mssv': instance.mssv,
      'dob': instance.dob,
      'gender': instance.gender,
      'pob': instance.pob,
      'phone': instance.phone,
      'email': instance.email,
    };
