// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get mssv => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_base64')
  String? get avatarBase64 => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call({
    String mssv,
    String name,
    String? avatar,
    @JsonKey(name: 'avatar_base64') String? avatarBase64,
  });
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mssv = null,
    Object? name = null,
    Object? avatar = freezed,
    Object? avatarBase64 = freezed,
  }) {
    return _then(
      _value.copyWith(
            mssv: null == mssv
                ? _value.mssv
                : mssv // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            avatar: freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarBase64: freezed == avatarBase64
                ? _value.avatarBase64
                : avatarBase64 // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
    _$UserModelImpl value,
    $Res Function(_$UserModelImpl) then,
  ) = __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String mssv,
    String name,
    String? avatar,
    @JsonKey(name: 'avatar_base64') String? avatarBase64,
  });
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
    _$UserModelImpl _value,
    $Res Function(_$UserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mssv = null,
    Object? name = null,
    Object? avatar = freezed,
    Object? avatarBase64 = freezed,
  }) {
    return _then(
      _$UserModelImpl(
        mssv: null == mssv
            ? _value.mssv
            : mssv // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        avatar: freezed == avatar
            ? _value.avatar
            : avatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarBase64: freezed == avatarBase64
            ? _value.avatarBase64
            : avatarBase64 // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl({
    required this.mssv,
    required this.name,
    this.avatar,
    @JsonKey(name: 'avatar_base64') this.avatarBase64,
  });

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String mssv;
  @override
  final String name;
  @override
  final String? avatar;
  @override
  @JsonKey(name: 'avatar_base64')
  final String? avatarBase64;

  @override
  String toString() {
    return 'UserModel(mssv: $mssv, name: $name, avatar: $avatar, avatarBase64: $avatarBase64)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.mssv, mssv) || other.mssv == mssv) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.avatarBase64, avatarBase64) ||
                other.avatarBase64 == avatarBase64));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, mssv, name, avatar, avatarBase64);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(this);
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel({
    required final String mssv,
    required final String name,
    final String? avatar,
    @JsonKey(name: 'avatar_base64') final String? avatarBase64,
  }) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get mssv;
  @override
  String get name;
  @override
  String? get avatar;
  @override
  @JsonKey(name: 'avatar_base64')
  String? get avatarBase64;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) {
  return _UserProfileModel.fromJson(json);
}

/// @nodoc
mixin _$UserProfileModel {
  AcademicInfo get academic => throw _privateConstructorUsedError;
  PersonalInfo get personal => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_base64')
  String? get avatarBase64 => throw _privateConstructorUsedError;

  /// Serializes this UserProfileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileModelCopyWith<UserProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileModelCopyWith<$Res> {
  factory $UserProfileModelCopyWith(
    UserProfileModel value,
    $Res Function(UserProfileModel) then,
  ) = _$UserProfileModelCopyWithImpl<$Res, UserProfileModel>;
  @useResult
  $Res call({
    AcademicInfo academic,
    PersonalInfo personal,
    String? avatar,
    @JsonKey(name: 'avatar_base64') String? avatarBase64,
  });

  $AcademicInfoCopyWith<$Res> get academic;
  $PersonalInfoCopyWith<$Res> get personal;
}

/// @nodoc
class _$UserProfileModelCopyWithImpl<$Res, $Val extends UserProfileModel>
    implements $UserProfileModelCopyWith<$Res> {
  _$UserProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? academic = null,
    Object? personal = null,
    Object? avatar = freezed,
    Object? avatarBase64 = freezed,
  }) {
    return _then(
      _value.copyWith(
            academic: null == academic
                ? _value.academic
                : academic // ignore: cast_nullable_to_non_nullable
                      as AcademicInfo,
            personal: null == personal
                ? _value.personal
                : personal // ignore: cast_nullable_to_non_nullable
                      as PersonalInfo,
            avatar: freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarBase64: freezed == avatarBase64
                ? _value.avatarBase64
                : avatarBase64 // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AcademicInfoCopyWith<$Res> get academic {
    return $AcademicInfoCopyWith<$Res>(_value.academic, (value) {
      return _then(_value.copyWith(academic: value) as $Val);
    });
  }

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PersonalInfoCopyWith<$Res> get personal {
    return $PersonalInfoCopyWith<$Res>(_value.personal, (value) {
      return _then(_value.copyWith(personal: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileModelImplCopyWith<$Res>
    implements $UserProfileModelCopyWith<$Res> {
  factory _$$UserProfileModelImplCopyWith(
    _$UserProfileModelImpl value,
    $Res Function(_$UserProfileModelImpl) then,
  ) = __$$UserProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AcademicInfo academic,
    PersonalInfo personal,
    String? avatar,
    @JsonKey(name: 'avatar_base64') String? avatarBase64,
  });

  @override
  $AcademicInfoCopyWith<$Res> get academic;
  @override
  $PersonalInfoCopyWith<$Res> get personal;
}

/// @nodoc
class __$$UserProfileModelImplCopyWithImpl<$Res>
    extends _$UserProfileModelCopyWithImpl<$Res, _$UserProfileModelImpl>
    implements _$$UserProfileModelImplCopyWith<$Res> {
  __$$UserProfileModelImplCopyWithImpl(
    _$UserProfileModelImpl _value,
    $Res Function(_$UserProfileModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? academic = null,
    Object? personal = null,
    Object? avatar = freezed,
    Object? avatarBase64 = freezed,
  }) {
    return _then(
      _$UserProfileModelImpl(
        academic: null == academic
            ? _value.academic
            : academic // ignore: cast_nullable_to_non_nullable
                  as AcademicInfo,
        personal: null == personal
            ? _value.personal
            : personal // ignore: cast_nullable_to_non_nullable
                  as PersonalInfo,
        avatar: freezed == avatar
            ? _value.avatar
            : avatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarBase64: freezed == avatarBase64
            ? _value.avatarBase64
            : avatarBase64 // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileModelImpl implements _UserProfileModel {
  const _$UserProfileModelImpl({
    required this.academic,
    required this.personal,
    this.avatar,
    @JsonKey(name: 'avatar_base64') this.avatarBase64,
  });

  factory _$UserProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileModelImplFromJson(json);

  @override
  final AcademicInfo academic;
  @override
  final PersonalInfo personal;
  @override
  final String? avatar;
  @override
  @JsonKey(name: 'avatar_base64')
  final String? avatarBase64;

  @override
  String toString() {
    return 'UserProfileModel(academic: $academic, personal: $personal, avatar: $avatar, avatarBase64: $avatarBase64)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileModelImpl &&
            (identical(other.academic, academic) ||
                other.academic == academic) &&
            (identical(other.personal, personal) ||
                other.personal == personal) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.avatarBase64, avatarBase64) ||
                other.avatarBase64 == avatarBase64));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, academic, personal, avatar, avatarBase64);

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      __$$UserProfileModelImplCopyWithImpl<_$UserProfileModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileModelImplToJson(this);
  }
}

abstract class _UserProfileModel implements UserProfileModel {
  const factory _UserProfileModel({
    required final AcademicInfo academic,
    required final PersonalInfo personal,
    final String? avatar,
    @JsonKey(name: 'avatar_base64') final String? avatarBase64,
  }) = _$UserProfileModelImpl;

  factory _UserProfileModel.fromJson(Map<String, dynamic> json) =
      _$UserProfileModelImpl.fromJson;

  @override
  AcademicInfo get academic;
  @override
  PersonalInfo get personal;
  @override
  String? get avatar;
  @override
  @JsonKey(name: 'avatar_base64')
  String? get avatarBase64;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AcademicInfo _$AcademicInfoFromJson(Map<String, dynamic> json) {
  return _AcademicInfo.fromJson(json);
}

/// @nodoc
mixin _$AcademicInfo {
  String get status => throw _privateConstructorUsedError;
  String get className => throw _privateConstructorUsedError;
  String get educationType => throw _privateConstructorUsedError;
  String get course => throw _privateConstructorUsedError;
  String get major => throw _privateConstructorUsedError;
  String get specialization => throw _privateConstructorUsedError;

  /// Serializes this AcademicInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AcademicInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AcademicInfoCopyWith<AcademicInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcademicInfoCopyWith<$Res> {
  factory $AcademicInfoCopyWith(
    AcademicInfo value,
    $Res Function(AcademicInfo) then,
  ) = _$AcademicInfoCopyWithImpl<$Res, AcademicInfo>;
  @useResult
  $Res call({
    String status,
    String className,
    String educationType,
    String course,
    String major,
    String specialization,
  });
}

/// @nodoc
class _$AcademicInfoCopyWithImpl<$Res, $Val extends AcademicInfo>
    implements $AcademicInfoCopyWith<$Res> {
  _$AcademicInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AcademicInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? className = null,
    Object? educationType = null,
    Object? course = null,
    Object? major = null,
    Object? specialization = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            className: null == className
                ? _value.className
                : className // ignore: cast_nullable_to_non_nullable
                      as String,
            educationType: null == educationType
                ? _value.educationType
                : educationType // ignore: cast_nullable_to_non_nullable
                      as String,
            course: null == course
                ? _value.course
                : course // ignore: cast_nullable_to_non_nullable
                      as String,
            major: null == major
                ? _value.major
                : major // ignore: cast_nullable_to_non_nullable
                      as String,
            specialization: null == specialization
                ? _value.specialization
                : specialization // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AcademicInfoImplCopyWith<$Res>
    implements $AcademicInfoCopyWith<$Res> {
  factory _$$AcademicInfoImplCopyWith(
    _$AcademicInfoImpl value,
    $Res Function(_$AcademicInfoImpl) then,
  ) = __$$AcademicInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String status,
    String className,
    String educationType,
    String course,
    String major,
    String specialization,
  });
}

/// @nodoc
class __$$AcademicInfoImplCopyWithImpl<$Res>
    extends _$AcademicInfoCopyWithImpl<$Res, _$AcademicInfoImpl>
    implements _$$AcademicInfoImplCopyWith<$Res> {
  __$$AcademicInfoImplCopyWithImpl(
    _$AcademicInfoImpl _value,
    $Res Function(_$AcademicInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AcademicInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? className = null,
    Object? educationType = null,
    Object? course = null,
    Object? major = null,
    Object? specialization = null,
  }) {
    return _then(
      _$AcademicInfoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        className: null == className
            ? _value.className
            : className // ignore: cast_nullable_to_non_nullable
                  as String,
        educationType: null == educationType
            ? _value.educationType
            : educationType // ignore: cast_nullable_to_non_nullable
                  as String,
        course: null == course
            ? _value.course
            : course // ignore: cast_nullable_to_non_nullable
                  as String,
        major: null == major
            ? _value.major
            : major // ignore: cast_nullable_to_non_nullable
                  as String,
        specialization: null == specialization
            ? _value.specialization
            : specialization // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AcademicInfoImpl implements _AcademicInfo {
  const _$AcademicInfoImpl({
    required this.status,
    required this.className,
    required this.educationType,
    required this.course,
    required this.major,
    required this.specialization,
  });

  factory _$AcademicInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AcademicInfoImplFromJson(json);

  @override
  final String status;
  @override
  final String className;
  @override
  final String educationType;
  @override
  final String course;
  @override
  final String major;
  @override
  final String specialization;

  @override
  String toString() {
    return 'AcademicInfo(status: $status, className: $className, educationType: $educationType, course: $course, major: $major, specialization: $specialization)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcademicInfoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.educationType, educationType) ||
                other.educationType == educationType) &&
            (identical(other.course, course) || other.course == course) &&
            (identical(other.major, major) || other.major == major) &&
            (identical(other.specialization, specialization) ||
                other.specialization == specialization));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    className,
    educationType,
    course,
    major,
    specialization,
  );

  /// Create a copy of AcademicInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AcademicInfoImplCopyWith<_$AcademicInfoImpl> get copyWith =>
      __$$AcademicInfoImplCopyWithImpl<_$AcademicInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AcademicInfoImplToJson(this);
  }
}

abstract class _AcademicInfo implements AcademicInfo {
  const factory _AcademicInfo({
    required final String status,
    required final String className,
    required final String educationType,
    required final String course,
    required final String major,
    required final String specialization,
  }) = _$AcademicInfoImpl;

  factory _AcademicInfo.fromJson(Map<String, dynamic> json) =
      _$AcademicInfoImpl.fromJson;

  @override
  String get status;
  @override
  String get className;
  @override
  String get educationType;
  @override
  String get course;
  @override
  String get major;
  @override
  String get specialization;

  /// Create a copy of AcademicInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcademicInfoImplCopyWith<_$AcademicInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PersonalInfo _$PersonalInfoFromJson(Map<String, dynamic> json) {
  return _PersonalInfo.fromJson(json);
}

/// @nodoc
mixin _$PersonalInfo {
  String get fullName => throw _privateConstructorUsedError;
  String get mssv => throw _privateConstructorUsedError;
  String get dob => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get pob => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;

  /// Serializes this PersonalInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PersonalInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PersonalInfoCopyWith<PersonalInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalInfoCopyWith<$Res> {
  factory $PersonalInfoCopyWith(
    PersonalInfo value,
    $Res Function(PersonalInfo) then,
  ) = _$PersonalInfoCopyWithImpl<$Res, PersonalInfo>;
  @useResult
  $Res call({
    String fullName,
    String mssv,
    String dob,
    String gender,
    String pob,
    String phone,
    String email,
  });
}

/// @nodoc
class _$PersonalInfoCopyWithImpl<$Res, $Val extends PersonalInfo>
    implements $PersonalInfoCopyWith<$Res> {
  _$PersonalInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PersonalInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? mssv = null,
    Object? dob = null,
    Object? gender = null,
    Object? pob = null,
    Object? phone = null,
    Object? email = null,
  }) {
    return _then(
      _value.copyWith(
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            mssv: null == mssv
                ? _value.mssv
                : mssv // ignore: cast_nullable_to_non_nullable
                      as String,
            dob: null == dob
                ? _value.dob
                : dob // ignore: cast_nullable_to_non_nullable
                      as String,
            gender: null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String,
            pob: null == pob
                ? _value.pob
                : pob // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PersonalInfoImplCopyWith<$Res>
    implements $PersonalInfoCopyWith<$Res> {
  factory _$$PersonalInfoImplCopyWith(
    _$PersonalInfoImpl value,
    $Res Function(_$PersonalInfoImpl) then,
  ) = __$$PersonalInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String fullName,
    String mssv,
    String dob,
    String gender,
    String pob,
    String phone,
    String email,
  });
}

/// @nodoc
class __$$PersonalInfoImplCopyWithImpl<$Res>
    extends _$PersonalInfoCopyWithImpl<$Res, _$PersonalInfoImpl>
    implements _$$PersonalInfoImplCopyWith<$Res> {
  __$$PersonalInfoImplCopyWithImpl(
    _$PersonalInfoImpl _value,
    $Res Function(_$PersonalInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PersonalInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? mssv = null,
    Object? dob = null,
    Object? gender = null,
    Object? pob = null,
    Object? phone = null,
    Object? email = null,
  }) {
    return _then(
      _$PersonalInfoImpl(
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        mssv: null == mssv
            ? _value.mssv
            : mssv // ignore: cast_nullable_to_non_nullable
                  as String,
        dob: null == dob
            ? _value.dob
            : dob // ignore: cast_nullable_to_non_nullable
                  as String,
        gender: null == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String,
        pob: null == pob
            ? _value.pob
            : pob // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonalInfoImpl implements _PersonalInfo {
  const _$PersonalInfoImpl({
    required this.fullName,
    required this.mssv,
    required this.dob,
    required this.gender,
    required this.pob,
    required this.phone,
    required this.email,
  });

  factory _$PersonalInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersonalInfoImplFromJson(json);

  @override
  final String fullName;
  @override
  final String mssv;
  @override
  final String dob;
  @override
  final String gender;
  @override
  final String pob;
  @override
  final String phone;
  @override
  final String email;

  @override
  String toString() {
    return 'PersonalInfo(fullName: $fullName, mssv: $mssv, dob: $dob, gender: $gender, pob: $pob, phone: $phone, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalInfoImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.mssv, mssv) || other.mssv == mssv) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.pob, pob) || other.pob == pob) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fullName, mssv, dob, gender, pob, phone, email);

  /// Create a copy of PersonalInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonalInfoImplCopyWith<_$PersonalInfoImpl> get copyWith =>
      __$$PersonalInfoImplCopyWithImpl<_$PersonalInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PersonalInfoImplToJson(this);
  }
}

abstract class _PersonalInfo implements PersonalInfo {
  const factory _PersonalInfo({
    required final String fullName,
    required final String mssv,
    required final String dob,
    required final String gender,
    required final String pob,
    required final String phone,
    required final String email,
  }) = _$PersonalInfoImpl;

  factory _PersonalInfo.fromJson(Map<String, dynamic> json) =
      _$PersonalInfoImpl.fromJson;

  @override
  String get fullName;
  @override
  String get mssv;
  @override
  String get dob;
  @override
  String get gender;
  @override
  String get pob;
  @override
  String get phone;
  @override
  String get email;

  /// Create a copy of PersonalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PersonalInfoImplCopyWith<_$PersonalInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
