import 'package:json_annotation/json_annotation.dart';

part 'kemenag.g.dart';

@JsonSerializable()
class Kemenag {
  Kemenag({
    this.name,
    this.text,
  });

  factory Kemenag.fromJson(Map<String, dynamic> json) =>
      _$KemenagFromJson(json);

  Map<String, dynamic> toJson() => _$KemenagToJson(this);

  String name;
  String source;
  Map<String, String> text;

  @override
  String toString() {
    return '''
Kemenag : {${'name: $name, '}${'source: $source, '}${'text: $text '}}''';
  }
}
