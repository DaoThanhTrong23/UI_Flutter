// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationModelImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  date: json['date'] as String,
  content: json['content'] as String,
  htmlContent: json['htmlContent'] as String,
  isRead: json['isRead'] as bool,
  type: json['type'] as String,
);

Map<String, dynamic> _$$NotificationModelImplToJson(
  _$NotificationModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'date': instance.date,
  'content': instance.content,
  'htmlContent': instance.htmlContent,
  'isRead': instance.isRead,
  'type': instance.type,
};
