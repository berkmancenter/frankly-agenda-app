import 'package:json_annotation/json_annotation.dart';
part 'warning.g.dart';

@JsonSerializable()
class Warning {
  final String name;
  final String message;
  final String errorType;

  Warning({
    required this.name,
    required this.message,
    required this.errorType,
  });

  factory Warning.fromJson(Map<String, dynamic> json) =>
      _$WarningFromJson(json);

  Map<String, dynamic> toJson() => _$WarningToJson(this);

  Warning deepCopy() {
    Warning newWarning =
        Warning(name: name, message: message, errorType: errorType);
    return newWarning;
  }
}
