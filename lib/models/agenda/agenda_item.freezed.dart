// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agenda_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
AgendaItemModel _$AgendaItemModelFromJson(Map<String, dynamic> json) {
  return _AgendaItem.fromJson(json);
}

/// @nodoc
mixin _$AgendaItemModel {
  String get title;
  String? get content;
  Duration get duration;

  /// Create a copy of AgendaItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AgendaItemModelCopyWith<AgendaItemModel> get copyWith =>
      _$AgendaItemModelCopyWithImpl<AgendaItemModel>(
          this as AgendaItemModel, _$identity);

  /// Serializes this AgendaItemModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AgendaItemModel &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, content, duration);

  @override
  String toString() {
    return 'AgendaItemModel(title: $title, content: $content, duration: $duration)';
  }
}

/// @nodoc
abstract mixin class $AgendaItemModelCopyWith<$Res> {
  factory $AgendaItemModelCopyWith(
          AgendaItemModel value, $Res Function(AgendaItemModel) _then) =
      _$AgendaItemModelCopyWithImpl;
  @useResult
  $Res call({String title, String? content, Duration duration});
}

/// @nodoc
class _$AgendaItemModelCopyWithImpl<$Res>
    implements $AgendaItemModelCopyWith<$Res> {
  _$AgendaItemModelCopyWithImpl(this._self, this._then);

  final AgendaItemModel _self;
  final $Res Function(AgendaItemModel) _then;

  /// Create a copy of AgendaItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = freezed,
    Object? duration = null,
  }) {
    return _then(_self.copyWith(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AgendaItem implements AgendaItemModel {
  const _AgendaItem(
      {required this.title, this.content, required this.duration});
  factory _AgendaItem.fromJson(Map<String, dynamic> json) =>
      _$AgendaItemFromJson(json);

  @override
  final String title;
  @override
  final String? content;
  @override
  final Duration duration;

  /// Create a copy of AgendaItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AgendaItemCopyWith<_AgendaItem> get copyWith =>
      __$AgendaItemCopyWithImpl<_AgendaItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AgendaItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AgendaItem &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, content, duration);

  @override
  String toString() {
    return 'AgendaItemModel(title: $title, content: $content, duration: $duration)';
  }
}

/// @nodoc
abstract mixin class _$AgendaItemCopyWith<$Res>
    implements $AgendaItemModelCopyWith<$Res> {
  factory _$AgendaItemCopyWith(
          _AgendaItem value, $Res Function(_AgendaItem) _then) =
      __$AgendaItemCopyWithImpl;
  @override
  @useResult
  $Res call({String title, String? content, Duration duration});
}

/// @nodoc
class __$AgendaItemCopyWithImpl<$Res> implements _$AgendaItemCopyWith<$Res> {
  __$AgendaItemCopyWithImpl(this._self, this._then);

  final _AgendaItem _self;
  final $Res Function(_AgendaItem) _then;

  /// Create a copy of AgendaItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? content = freezed,
    Object? duration = null,
  }) {
    return _then(_AgendaItem(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

// dart format on
