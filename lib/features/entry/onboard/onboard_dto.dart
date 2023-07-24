class OnboardDTO {
  OnboardDTO({this.nickName = '', this.isSecondPageActive = false, this.avatarPath = '', this.avatarAssets = const []});

  final String nickName;
  final bool isSecondPageActive;
  final String avatarPath;
  final List<String> avatarAssets;

  OnboardDTO copyWith({
    String? nickName,
    bool? isSecondPageActive,
    String? avatarPath,
    List<String>? avatarAssets,
  }) {
    return OnboardDTO(
      nickName: nickName ?? this.nickName,
      isSecondPageActive: isSecondPageActive ?? this.isSecondPageActive,
      avatarPath: avatarPath ?? this.avatarPath,
      avatarAssets: avatarAssets ?? this.avatarAssets,
    );
  }
}
