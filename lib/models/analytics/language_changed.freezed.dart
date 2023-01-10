// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'language_changed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LanguageChangedEvent _$LanguageChangedEventFromJson(Map<String, dynamic> json) {
  return _LanguageChangedEvent.fromJson(json);
}

/// @nodoc
mixin _$LanguageChangedEvent {
  String? get languageFrom => throw _privateConstructorUsedError;
  String get languageTo => throw _privateConstructorUsedError;
  String get languageChangeType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LanguageChangedEventCopyWith<LanguageChangedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LanguageChangedEventCopyWith<$Res> {
  factory $LanguageChangedEventCopyWith(LanguageChangedEvent value,
          $Res Function(LanguageChangedEvent) then) =
      _$LanguageChangedEventCopyWithImpl<$Res>;
  $Res call(
      {String? languageFrom, String languageTo, String languageChangeType});
}

/// @nodoc
class _$LanguageChangedEventCopyWithImpl<$Res>
    implements $LanguageChangedEventCopyWith<$Res> {
  _$LanguageChangedEventCopyWithImpl(this._value, this._then);

  final LanguageChangedEvent _value;
  // ignore: unused_field
  final $Res Function(LanguageChangedEvent) _then;

  @override
  $Res call({
    Object? languageFrom = freezed,
    Object? languageTo = freezed,
    Object? languageChangeType = freezed,
  }) {
    return _then(_value.copyWith(
      languageFrom: languageFrom == freezed
          ? _value.languageFrom
          : languageFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      languageTo: languageTo == freezed
          ? _value.languageTo
          : languageTo // ignore: cast_nullable_to_non_nullable
              as String,
      languageChangeType: languageChangeType == freezed
          ? _value.languageChangeType
          : languageChangeType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_LanguageChangedEventCopyWith<$Res>
    implements $LanguageChangedEventCopyWith<$Res> {
  factory _$$_LanguageChangedEventCopyWith(_$_LanguageChangedEvent value,
          $Res Function(_$_LanguageChangedEvent) then) =
      __$$_LanguageChangedEventCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? languageFrom, String languageTo, String languageChangeType});
}

/// @nodoc
class __$$_LanguageChangedEventCopyWithImpl<$Res>
    extends _$LanguageChangedEventCopyWithImpl<$Res>
    implements _$$_LanguageChangedEventCopyWith<$Res> {
  __$$_LanguageChangedEventCopyWithImpl(_$_LanguageChangedEvent _value,
      $Res Function(_$_LanguageChangedEvent) _then)
      : super(_value, (v) => _then(v as _$_LanguageChangedEvent));

  @override
  _$_LanguageChangedEvent get _value => super._value as _$_LanguageChangedEvent;

  @override
  $Res call({
    Object? languageFrom = freezed,
    Object? languageTo = freezed,
    Object? languageChangeType = freezed,
  }) {
    return _then(_$_LanguageChangedEvent(
      languageFrom: languageFrom == freezed
          ? _value.languageFrom
          : languageFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      languageTo: languageTo == freezed
          ? _value.languageTo
          : languageTo // ignore: cast_nullable_to_non_nullable
              as String,
      languageChangeType: languageChangeType == freezed
          ? _value.languageChangeType
          : languageChangeType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LanguageChangedEvent implements _LanguageChangedEvent {
  const _$_LanguageChangedEvent(
      {required this.languageFrom,
      required this.languageTo,
      required this.languageChangeType});

  factory _$_LanguageChangedEvent.fromJson(Map<String, dynamic> json) =>
      _$$_LanguageChangedEventFromJson(json);

  @override
  final String? languageFrom;
  @override
  final String languageTo;
  @override
  final String languageChangeType;

  @override
  String toString() {
    return 'LanguageChangedEvent(languageFrom: $languageFrom, languageTo: $languageTo, languageChangeType: $languageChangeType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LanguageChangedEvent &&
            const DeepCollectionEquality()
                .equals(other.languageFrom, languageFrom) &&
            const DeepCollectionEquality()
                .equals(other.languageTo, languageTo) &&
            const DeepCollectionEquality()
                .equals(other.languageChangeType, languageChangeType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(languageFrom),
      const DeepCollectionEquality().hash(languageTo),
      const DeepCollectionEquality().hash(languageChangeType));

  @JsonKey(ignore: true)
  @override
  _$$_LanguageChangedEventCopyWith<_$_LanguageChangedEvent> get copyWith =>
      __$$_LanguageChangedEventCopyWithImpl<_$_LanguageChangedEvent>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LanguageChangedEventToJson(
      this,
    );
  }
}

abstract class _LanguageChangedEvent implements LanguageChangedEvent {
  const factory _LanguageChangedEvent(
      {required final String? languageFrom,
      required final String languageTo,
      required final String languageChangeType}) = _$_LanguageChangedEvent;

  factory _LanguageChangedEvent.fromJson(Map<String, dynamic> json) =
      _$_LanguageChangedEvent.fromJson;

  @override
  String? get languageFrom;
  @override
  String get languageTo;
  @override
  String get languageChangeType;
  @override
  @JsonKey(ignore: true)
  _$$_LanguageChangedEventCopyWith<_$_LanguageChangedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
