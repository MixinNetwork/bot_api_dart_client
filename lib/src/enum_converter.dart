import 'package:json_annotation/json_annotation.dart';
import 'package:recase/recase.dart';

class EnumToString {

  static bool _isEnumItem(enumItem) {
    final splitEnum = enumItem.toString().split('.');
    return splitEnum.length > 1 &&
        splitEnum[0] == enumItem.runtimeType.toString();
  }

  static String? convertToString(dynamic enumItem) {
    if(enumItem == null) return null;
    assert(_isEnumItem(enumItem),
    '$enumItem of type ${enumItem.runtimeType.toString()} is not an enum item');
    final _tmp = enumItem.toString().split('.')[1];
    return _tmp;
  }


  static T? fromString<T>(List<T?>? enumValues, String? value) {
    if (value == null || enumValues == null) return null;

    return enumValues.singleWhere(
            (enumItem) =>
        EnumToString.convertToString(enumItem)
            ?.toUpperCase() ==
            value.toUpperCase(),
        orElse: () => null);
  }

}


abstract class EnumJsonConverter<T>
    implements JsonConverter<T?, String?> {
  const EnumJsonConverter();

  List<T> enumValues();

  String get unknownJson => '';

  T? get unknownEnumValue => null;

  @override
  T? fromJson(String? json) => EnumToString.fromString(
      enumValues(),
      json?.camelCase,
    ) ?? unknownEnumValue;

  @override
  String? toJson(T? object) =>
      jsonCase(EnumToString.convertToString(object)) ?? jsonCase(unknownJson);

  String? jsonCase(String? json) => json?.constantCase;
}
