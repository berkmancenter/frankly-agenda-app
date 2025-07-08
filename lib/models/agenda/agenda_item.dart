import 'package:freezed_annotation/freezed_annotation.dart';
part 'agenda_item.freezed.dart';
part 'agenda_item.g.dart';


@freezed
abstract class AgendaItemModel with _$AgendaItemModel {
  const factory AgendaItemModel({
    required String title,
    String? content,
    required Duration duration,
  }) = _AgendaItem;

  factory AgendaItemModel.fromJson(Map<String, Object?> json) =>
      _$AgendaItemFromJson(json);
}
