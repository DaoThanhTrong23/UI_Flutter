import 'package:freezed_annotation/freezed_annotation.dart';

part 'faculty_model.freezed.dart';
part 'faculty_model.g.dart';

@freezed
class FacultyModel with _$FacultyModel {
  const factory FacultyModel({
    required String id,
    required String name,
    required String faculty,
    required String email,
    required String phone,
  }) = _FacultyModel;

  factory FacultyModel.fromJson(Map<String, dynamic> json) => _$FacultyModelFromJson(json);
}
