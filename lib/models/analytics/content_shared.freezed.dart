// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'content_shared.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ContentSharedEvent _$ContentSharedEventFromJson(Map<String, dynamic> json) {
  return _ContentSharedEvent.fromJson(json);
}

/// @nodoc
mixin _$ContentSharedEvent {
  String get pageCode => throw _privateConstructorUsedError;
  String get elementType => throw _privateConstructorUsedError;
  String get elementId => throw _privateConstructorUsedError;
  int? get position => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContentSharedEventCopyWith<ContentSharedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentSharedEventCopyWith<$Res> {
  factory $ContentSharedEventCopyWith(
          ContentSharedEvent value, $Res Function(ContentSharedEvent) then) =
      _$ContentSharedEventCopyWithImpl<$Res>;
  $Res call(
      {String pageCode, String elementType, String elementId, int? position});
}

/// @nodoc
class _$ContentSharedEventCopyWithImpl<$Res>
    implements $ContentSharedEventCopyWith<$Res> {
  _$ContentSharedEventCopyWithImpl(this._value, this._then);

  final ContentSharedEvent _value;
  // ignore: unused_field
  final $Res Function(ContentSharedEvent) _then;

  @override
  $Res call({
    Object? pageCode = freezed,
    Object? elementType = freezed,
    Object? elementId = freezed,
    Object? position = freezed,
  }) {
    return _then(_value.copyWith(
      pageCode: pageCode == freezed
          ? _value.pageCode
          : pageCode // ignore: cast_nullable_to_non_nullable
              as String,
      elementType: elementType == freezed
          ? _value.elementType
          : elementType // ignore: cast_nullable_to_non_nullable
              as String,
      elementId: elementId == freezed
          ? _value.elementId
          : elementId // ignore: cast_nullable_to_non_nullable
              as String,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_ContentSharedEventCopyWith<$Res>
    implements $ContentSharedEventCopyWith<$Res> {
  factory _$$_ContentSharedEventCopyWith(_$_ContentSharedEvent value,
          $Res Function(_$_ContentSharedEvent) then) =
      __$$_ContentSharedEventCopyWithImpl<$Res>;
  @override
  $Res call(
      {String pageCode, String elementType, String elementId, int? position});
}

/// @nodoc
class __$$_ContentSharedEventCopyWithImpl<$Res>
    extends _$ContentSharedEventCopyWithImpl<$Res>
    implements _$$_ContentSharedEventCopyWith<$Res> {
  __$$_ContentSharedEventCopyWithImpl(
      _$_ContentSharedEvent _value, $Res Function(_$_ContentSharedEvent) _then)
      : super(_value, (v) => _then(v as _$_ContentSharedEvent));

  @override
  _$_ContentSharedEvent get _value => super._value as _$_ContentSharedEvent;

  @override
  $Res call({
    Object? pageCode = freezed,
    Object? elementType = freezed,
    Object? elementId = freezed,
    Object? position = freezed,
  }) {
    return _then(_$_ContentSharedEvent(
      pageCode: pageCode == freezed
          ? _value.pageCode
          : pageCode // ignore: cast_nullable_to_non_nullable
              as String,
      elementType: elementType == freezed
          ? _value.elementType
          : elementType // ignore: cast_nullable_to_non_nullable
              as String,
      elementId: elementId == freezed
          ? _value.elementId
          : elementId // ignore: cast_nullable_to_non_nullable
              as String,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ContentSharedEvent implements _ContentSharedEvent {
  const _$_ContentSharedEvent(
      {required this.pageCode,
      required this.elementType,
      required this.elementId,
      this.position});

  factory _$_ContentSharedEvent.fromJson(Map<String, dynamic> json) =>
      _$$_ContentSharedEventFromJson(json);

  @override
  final String pageCode;
  @override
  final String elementType;
  @override
  final String elementId;
  @override
  final int? position;

  @override
  String toString() {
    return 'ContentSharedEvent(pageCode: $pageCode, elementType: $elementType, elementId: $elementId, position: $position)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ContentSharedEvent &&
            const DeepCollectionEquality().equals(other.pageCode, pageCode) &&
            const DeepCollectionEquality()
                .equals(other.elementType, elementType) &&
            const DeepCollectionEquality().equals(other.elementId, elementId) &&
            const DeepCollectionEquality().equals(other.position, position));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(pageCode),
      const DeepCollectionEquality().hash(elementType),
      const DeepCollectionEquality().hash(elementId),
      const DeepCollectionEquality().hash(position));

  @JsonKey(ignore: true)
  @override
  _$$_ContentSharedEventCopyWith<_$_ContentSharedEvent> get copyWith =>
      __$$_ContentSharedEventCopyWithImpl<_$_ContentSharedEvent>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ContentSharedEventToJson(
      this,
    );
  }
}

abstract class _ContentSharedEvent implements ContentSharedEvent {
  const factory _ContentSharedEvent(
      {required final String pageCode,
      required final String elementType,
      required final String elementId,
      final int? position}) = _$_ContentSharedEvent;

  factory _ContentSharedEvent.fromJson(Map<String, dynamic> json) =
      _$_ContentSharedEvent.fromJson;

  @override
  String get pageCode;
  @override
  String get elementType;
  @override
  String get elementId;
  @override
  int? get position;
  @override
  @JsonKey(ignore: true)
  _$$_ContentSharedEventCopyWith<_$_ContentSharedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
