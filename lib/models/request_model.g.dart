// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestModelImpl _$$RequestModelImplFromJson(Map<String, dynamic> json) =>
    _$RequestModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      date: json['date'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$RequestModelImplToJson(_$RequestModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date,
      'status': instance.status,
    };

_$RequestStatsModelImpl _$$RequestStatsModelImplFromJson(
  Map<String, dynamic> json,
) => _$RequestStatsModelImpl(
  total: (json['total'] as num).toInt(),
  processing: (json['processing'] as num).toInt(),
  completed: (json['completed'] as num).toInt(),
  rejected: (json['rejected'] as num).toInt(),
);

Map<String, dynamic> _$$RequestStatsModelImplToJson(
  _$RequestStatsModelImpl instance,
) => <String, dynamic>{
  'total': instance.total,
  'processing': instance.processing,
  'completed': instance.completed,
  'rejected': instance.rejected,
};
