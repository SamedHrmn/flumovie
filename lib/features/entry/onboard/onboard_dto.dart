import 'package:json_annotation/json_annotation.dart';

part 'onboard_dto.g.dart';

@JsonSerializable()
class OnboardDTO {
  OnboardDTO({this.nickName = '', this.avatarPath = '', this.avatarAssets = const []});

  factory OnboardDTO.fromJson(Map<String, dynamic> json) => _$OnboardDTOFromJson(json);

  final String nickName;

  final String avatarPath;
  final List<String> avatarAssets;

  OnboardDTO copyWith({
    String? nickName,
    String? avatarPath,
    List<String>? avatarAssets,
  }) {
    return OnboardDTO(
      nickName: nickName ?? this.nickName,
      avatarPath: avatarPath ?? this.avatarPath,
      avatarAssets: avatarAssets ?? this.avatarAssets,
    );
  }

  Map<String, dynamic> toJson() => _$OnboardDTOToJson(this);
}
