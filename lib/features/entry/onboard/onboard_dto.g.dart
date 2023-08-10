// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboard_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnboardDTO _$OnboardDTOFromJson(Map<String, dynamic> json) => OnboardDTO(
      nickName: json['nickName'] as String? ?? '',
      avatarPath: json['avatarPath'] as String? ?? '',
      avatarAssets: (json['avatarAssets'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OnboardDTOToJson(OnboardDTO instance) =>
    <String, dynamic>{
      'nickName': instance.nickName,
      'avatarPath': instance.avatarPath,
      'avatarAssets': instance.avatarAssets,
    };
