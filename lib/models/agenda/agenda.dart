import 'package:freezed_annotation/freezed_annotation.dart';
part 'agenda.freezed.dart';
part 'agenda.g.dart';

@freezed
abstract class AgendaModel with _$AgendaModel {
  const factory AgendaModel({
    required String name,
    required String description,
  }) = _Agenda;

  factory AgendaModel.fromJson(Map<String, Object?> json) => _$AgendaFromJson(json);

}