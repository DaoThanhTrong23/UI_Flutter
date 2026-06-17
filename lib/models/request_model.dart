import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_model.freezed.dart';
part 'request_model.g.dart';

@freezed
class RequestModel with _$RequestModel {
  const factory RequestModel({
    required String id,
    required String title,
    required String date,
    required String status,
  }) = _RequestModel;

  factory RequestModel.fromJson(Map<String, dynamic> json) => _$RequestModelFromJson(json);
}

@freezed
class RequestStatsModel with _$RequestStatsModel {
  const factory RequestStatsModel({
    required int total,
    required int processing,
    required int completed,
    required int rejected,
  }) = _RequestStatsModel;

  factory RequestStatsModel.fromJson(Map<String, dynamic> json) => _$RequestStatsModelFromJson(json);
}
