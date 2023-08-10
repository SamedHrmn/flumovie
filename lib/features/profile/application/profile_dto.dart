class ProfileDTO {
  const ProfileDTO({this.nickName, this.avatarPath});

  final String? nickName;
  final String? avatarPath;

  ProfileDTO copyWith({
    String? nickName,
    String? avatarPath,
  }) {
    return ProfileDTO(
      nickName: nickName ?? this.nickName,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }
}
