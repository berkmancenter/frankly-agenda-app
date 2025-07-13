// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agenda_builder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AgendaBuilder {
  List<Goals>? get goals;
  set goals(List<Goals>? value);
  String? get topic;
  set topic(String? value);
  String? get topicDescription;
  set topicDescription(String? value);
  String? get audienceDescription;
  set audienceDescription(String? value);
  ParticipantBatches? get participantCount;
  set participantCount(ParticipantBatches? value);
  bool? get hasBreakoutGroups;
  set hasBreakoutGroups(bool? value);
  bool? get isFacilitated;
  set isFacilitated(bool? value);
  bool? get isSeries;
  set isSeries(bool? value);
  int? get eventCount;
  set eventCount(int? value);
  Duration? get eventLength;
  set eventLength(Duration? value);

  /// Create a copy of AgendaBuilder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AgendaBuilderCopyWith<AgendaBuilder> get copyWith =>
      _$AgendaBuilderCopyWithImpl<AgendaBuilder>(
          this as AgendaBuilder, _$identity);

  /// Serializes this AgendaBuilder to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'AgendaBuilder(goals: $goals, topic: $topic, topicDescription: $topicDescription, audienceDescription: $audienceDescription, participantCount: $participantCount, hasBreakoutGroups: $hasBreakoutGroups, isFacilitated: $isFacilitated, isSeries: $isSeries, eventCount: $eventCount, eventLength: $eventLength)';
  }
}

/// @nodoc
abstract mixin class $AgendaBuilderCopyWith<$Res> {
  factory $AgendaBuilderCopyWith(
          AgendaBuilder value, $Res Function(AgendaBuilder) _then) =
      _$AgendaBuilderCopyWithImpl;
  @useResult
  $Res call(
      {List<Goals>? goals,
      String? topic,
      String? topicDescription,
      String? audienceDescription,
      ParticipantBatches? participantCount,
      bool? hasBreakoutGroups,
      bool? isFacilitated,
      bool? isSeries,
      int? eventCount,
      Duration? eventLength});
}

/// @nodoc
class _$AgendaBuilderCopyWithImpl<$Res>
    implements $AgendaBuilderCopyWith<$Res> {
  _$AgendaBuilderCopyWithImpl(this._self, this._then);

  final AgendaBuilder _self;
  final $Res Function(AgendaBuilder) _then;

  /// Create a copy of AgendaBuilder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goals = freezed,
    Object? topic = freezed,
    Object? topicDescription = freezed,
    Object? audienceDescription = freezed,
    Object? participantCount = freezed,
    Object? hasBreakoutGroups = freezed,
    Object? isFacilitated = freezed,
    Object? isSeries = freezed,
    Object? eventCount = freezed,
    Object? eventLength = freezed,
  }) {
    return _then(_self.copyWith(
      goals: freezed == goals
          ? _self.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<Goals>?,
      topic: freezed == topic
          ? _self.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String?,
      topicDescription: freezed == topicDescription
          ? _self.topicDescription
          : topicDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      audienceDescription: freezed == audienceDescription
          ? _self.audienceDescription
          : audienceDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      participantCount: freezed == participantCount
          ? _self.participantCount
          : participantCount // ignore: cast_nullable_to_non_nullable
              as ParticipantBatches?,
      hasBreakoutGroups: freezed == hasBreakoutGroups
          ? _self.hasBreakoutGroups
          : hasBreakoutGroups // ignore: cast_nullable_to_non_nullable
              as bool?,
      isFacilitated: freezed == isFacilitated
          ? _self.isFacilitated
          : isFacilitated // ignore: cast_nullable_to_non_nullable
              as bool?,
      isSeries: freezed == isSeries
          ? _self.isSeries
          : isSeries // ignore: cast_nullable_to_non_nullable
              as bool?,
      eventCount: freezed == eventCount
          ? _self.eventCount
          : eventCount // ignore: cast_nullable_to_non_nullable
              as int?,
      eventLength: freezed == eventLength
          ? _self.eventLength
          : eventLength // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AgendaBuilder extends AgendaBuilder {
  _AgendaBuilder(
      {this.goals,
      this.topic,
      this.topicDescription,
      this.audienceDescription,
      this.participantCount,
      this.hasBreakoutGroups,
      this.isFacilitated,
      this.isSeries,
      this.eventCount,
      this.eventLength})
      : super._();
  factory _AgendaBuilder.fromJson(Map<String, dynamic> json) =>
      _$AgendaBuilderFromJson(json);

  @override
  List<Goals>? goals;
  @override
  String? topic;
  @override
  String? topicDescription;
  @override
  String? audienceDescription;
  @override
  ParticipantBatches? participantCount;
  @override
  bool? hasBreakoutGroups;
  @override
  bool? isFacilitated;
  @override
  bool? isSeries;
  @override
  int? eventCount;
  @override
  Duration? eventLength;

  /// Create a copy of AgendaBuilder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AgendaBuilderCopyWith<_AgendaBuilder> get copyWith =>
      __$AgendaBuilderCopyWithImpl<_AgendaBuilder>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AgendaBuilderToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'AgendaBuilder(goals: $goals, topic: $topic, topicDescription: $topicDescription, audienceDescription: $audienceDescription, participantCount: $participantCount, hasBreakoutGroups: $hasBreakoutGroups, isFacilitated: $isFacilitated, isSeries: $isSeries, eventCount: $eventCount, eventLength: $eventLength)';
  }
}

/// @nodoc
abstract mixin class _$AgendaBuilderCopyWith<$Res>
    implements $AgendaBuilderCopyWith<$Res> {
  factory _$AgendaBuilderCopyWith(
          _AgendaBuilder value, $Res Function(_AgendaBuilder) _then) =
      __$AgendaBuilderCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<Goals>? goals,
      String? topic,
      String? topicDescription,
      String? audienceDescription,
      ParticipantBatches? participantCount,
      bool? hasBreakoutGroups,
      bool? isFacilitated,
      bool? isSeries,
      int? eventCount,
      Duration? eventLength});
}

/// @nodoc
class __$AgendaBuilderCopyWithImpl<$Res>
    implements _$AgendaBuilderCopyWith<$Res> {
  __$AgendaBuilderCopyWithImpl(this._self, this._then);

  final _AgendaBuilder _self;
  final $Res Function(_AgendaBuilder) _then;

  /// Create a copy of AgendaBuilder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? goals = freezed,
    Object? topic = freezed,
    Object? topicDescription = freezed,
    Object? audienceDescription = freezed,
    Object? participantCount = freezed,
    Object? hasBreakoutGroups = freezed,
    Object? isFacilitated = freezed,
    Object? isSeries = freezed,
    Object? eventCount = freezed,
    Object? eventLength = freezed,
  }) {
    return _then(_AgendaBuilder(
      goals: freezed == goals
          ? _self.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<Goals>?,
      topic: freezed == topic
          ? _self.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String?,
      topicDescription: freezed == topicDescription
          ? _self.topicDescription
          : topicDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      audienceDescription: freezed == audienceDescription
          ? _self.audienceDescription
          : audienceDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      participantCount: freezed == participantCount
          ? _self.participantCount
          : participantCount // ignore: cast_nullable_to_non_nullable
              as ParticipantBatches?,
      hasBreakoutGroups: freezed == hasBreakoutGroups
          ? _self.hasBreakoutGroups
          : hasBreakoutGroups // ignore: cast_nullable_to_non_nullable
              as bool?,
      isFacilitated: freezed == isFacilitated
          ? _self.isFacilitated
          : isFacilitated // ignore: cast_nullable_to_non_nullable
              as bool?,
      isSeries: freezed == isSeries
          ? _self.isSeries
          : isSeries // ignore: cast_nullable_to_non_nullable
              as bool?,
      eventCount: freezed == eventCount
          ? _self.eventCount
          : eventCount // ignore: cast_nullable_to_non_nullable
              as int?,
      eventLength: freezed == eventLength
          ? _self.eventLength
          : eventLength // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

// dart format on
