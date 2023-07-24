class MovieUser {
  MovieUser({this.nickName = '', this.photoUrl = ''});

  final String nickName;
  final String photoUrl;

  MovieUser copyWith({
    String? nickName,
    String? photoUrl,
  }) {
    return MovieUser(
      nickName: nickName ?? this.nickName,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
