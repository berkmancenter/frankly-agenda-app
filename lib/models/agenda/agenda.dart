import 'package:agenda_wizard/models/agenda/agenda_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'agenda.freezed.dart';
part 'agenda.g.dart';

@freezed
abstract class AgendaModel with _$AgendaModel {
  const factory AgendaModel({
    required String name,
    required String description,
    required List<AgendaItemModel> agendaItems,
  }) = _Agenda;

  factory AgendaModel.fromJson(Map<String, Object?> json) => _$AgendaFromJson(json);

}