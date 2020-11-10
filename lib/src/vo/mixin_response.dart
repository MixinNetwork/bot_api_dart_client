import 'package:json_annotation/json_annotation.dart';
import './mixin_error.dart';

part 'mixin_response.g.dart';

@JsonSerializable()
class MixinResponse extends Object {
  @JsonKey(name: 'error')
  MixinError error;

  @JsonKey(name: 'data')
  Map<String, dynamic> data;

  MixinResponse(
    this.error,
    this.data,
  );

  factory MixinResponse.fromJson(Map<String, dynamic> json) =>
      _$MixinResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MixinResponseToJson(this);

  void handleResponse({Function onSuccess, Function onFailure}) {
    if (error != null) {
      onFailure(error);
    } else {
      onSuccess(data);
    }
  }
}