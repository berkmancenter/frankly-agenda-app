// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agenda.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
AgendaModel _$AgendaModelFromJson(Map<String, dynamic> json) {
  return _Agenda.fromJson(json);
}

/// @nodoc
mixin _$AgendaModel {
  String get name;
  String get description;
  List<AgendaItemModel> get agendaItems;

  /// Create a copy of AgendaModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AgendaModelCopyWith<AgendaModel> get copyWith =>
      _$AgendaModelCopyWithImpl<AgendaModel>(this as AgendaModel, _$identity);

  /// Serializes this AgendaModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AgendaModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other.agendaItems, agendaItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, description,
      const DeepCollectionEquality().hash(agendaItems));

  @override
  String toString() {
    return 'AgendaModel(name: $name, description: $description, agendaItems: $agendaItems)';
  }
}

/// @nodoc
abstract mixin class $AgendaModelCopyWith<$Res> {
  factory $AgendaModelCopyWith(
          AgendaModel value, $Res Function(AgendaModel) _then) =
      _$AgendaModelCopyWithImpl;
  @useResult
  $Res call(
      {String name, String description, List<AgendaItemModel> agendaItems});
}

/// @nodoc
class _$AgendaModelCopyWithImpl<$Res> implements $AgendaModelCopyWith<$Res> {
  _$AgendaModelCopyWithImpl(this._self, this._then);

  final AgendaModel _self;
  final $Res Function(AgendaModel) _then;

  /// Create a copy of AgendaModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? agendaItems = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      agendaItems: null == agendaItems
          ? _self.agendaItems
          : agendaItems // ignore: cast_nullable_to_non_nullable
              as List<AgendaItemModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Agenda implements AgendaModel {
  const _Agenda(
      {required this.name,
      required this.description,
      required final List<AgendaItemModel> agendaItems})
      : _agendaItems = agendaItems;
  factory _Agenda.fromJson(Map<String, dynamic> json) => _$AgendaFromJson(json);

  @override
  final String name;
  @override
  final String description;
  final List<AgendaItemModel> _agendaItems;
  @override
  List<AgendaItemModel> get agendaItems {
    if (_agendaItems is EqualUnmodifiableListView) return _agendaItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_agendaItems);
  }

  /// Create a copy of AgendaModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AgendaCopyWith<_Agenda> get copyWith =>
      __$AgendaCopyWithImpl<_Agenda>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AgendaToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Agenda &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._agendaItems, _agendaItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, description,
      const DeepCollectionEquality().hash(_agendaItems));

  @override
  String toString() {
    return 'AgendaModel(name: $name, description: $description, agendaItems: $agendaItems)';
  }
}

/// @nodoc
abstract mixin class _$AgendaCopyWith<$Res>
    implements $AgendaModelCopyWith<$Res> {
  factory _$AgendaCopyWith(_Agenda value, $Res Function(_Agenda) _then) =
      __$AgendaCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String name, String description, List<AgendaItemModel> agendaItems});
}

/// @nodoc
class __$AgendaCopyWithImpl<$Res> implements _$AgendaCopyWith<$Res> {
  __$AgendaCopyWithImpl(this._self, this._then);

  final _Agenda _self;
  final $Res Function(_Agenda) _then;

  /// Create a copy of AgendaModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? agendaItems = null,
  }) {
    return _then(_Agenda(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      agendaItems: null == agendaItems
          ? _self._agendaItems
          : agendaItems // ignore: cast_nullable_to_non_nullable
              as List<AgendaItemModel>,
    ));
  }
}

// dart format on
