// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faculty_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FacultyModel _$FacultyModelFromJson(Map<String, dynamic> json) {
  return _FacultyModel.fromJson(json);
}

/// @nodoc
mixin _$FacultyModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get faculty => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;

  /// Serializes this FacultyModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FacultyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FacultyModelCopyWith<FacultyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FacultyModelCopyWith<$Res> {
  factory $FacultyModelCopyWith(
    FacultyModel value,
    $Res Function(FacultyModel) then,
  ) = _$FacultyModelCopyWithImpl<$Res, FacultyModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String faculty,
    String email,
    String phone,
  });
}

/// @nodoc
class _$FacultyModelCopyWithImpl<$Res, $Val extends FacultyModel>
    implements $FacultyModelCopyWith<$Res> {
  _$FacultyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FacultyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? faculty = null,
    Object? email = null,
    Object? phone = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            faculty: null == faculty
                ? _value.faculty
                : faculty // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FacultyModelImplCopyWith<$Res>
    implements $FacultyModelCopyWith<$Res> {
  factory _$$FacultyModelImplCopyWith(
    _$FacultyModelImpl value,
    $Res Function(_$FacultyModelImpl) then,
  ) = __$$FacultyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String faculty,
    String email,
    String phone,
  });
}

/// @nodoc
class __$$FacultyModelImplCopyWithImpl<$Res>
    extends _$FacultyModelCopyWithImpl<$Res, _$FacultyModelImpl>
    implements _$$FacultyModelImplCopyWith<$Res> {
  __$$FacultyModelImplCopyWithImpl(
    _$FacultyModelImpl _value,
    $Res Function(_$FacultyModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FacultyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? faculty = null,
    Object? email = null,
    Object? phone = null,
  }) {
    return _then(
      _$FacultyModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        faculty: null == faculty
            ? _value.faculty
            : faculty // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FacultyModelImpl implements _FacultyModel {
  const _$FacultyModelImpl({
    required this.id,
    required this.name,
    required this.faculty,
    required this.email,
    required this.phone,
  });

  factory _$FacultyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FacultyModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String faculty;
  @override
  final String email;
  @override
  final String phone;

  @override
  String toString() {
    return 'FacultyModel(id: $id, name: $name, faculty: $faculty, email: $email, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FacultyModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.faculty, faculty) || other.faculty == faculty) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, faculty, email, phone);

  /// Create a copy of FacultyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FacultyModelImplCopyWith<_$FacultyModelImpl> get copyWith =>
      __$$FacultyModelImplCopyWithImpl<_$FacultyModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FacultyModelImplToJson(this);
  }
}

abstract class _FacultyModel implements FacultyModel {
  const factory _FacultyModel({
    required final String id,
    required final String name,
    required final String faculty,
    required final String email,
    required final String phone,
  }) = _$FacultyModelImpl;

  factory _FacultyModel.fromJson(Map<String, dynamic> json) =
      _$FacultyModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get faculty;
  @override
  String get email;
  @override
  String get phone;

  /// Create a copy of FacultyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FacultyModelImplCopyWith<_$FacultyModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
