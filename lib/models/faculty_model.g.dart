// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faculty_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FacultyModelImpl _$$FacultyModelImplFromJson(Map<String, dynamic> json) =>
    _$FacultyModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      faculty: json['faculty'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$$FacultyModelImplToJson(_$FacultyModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'faculty': instance.faculty,
      'email': instance.email,
      'phone': instance.phone,
    };
