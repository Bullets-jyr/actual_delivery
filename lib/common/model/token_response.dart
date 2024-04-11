import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable()
class TokenResponse {
  final String accessToken;

  TokenResponse({
    required this.accessToken,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);
}
