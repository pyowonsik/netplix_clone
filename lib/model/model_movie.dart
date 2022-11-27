class Movie {
  final String title;
  final String keyword;
  final String poster;
  final bool like;

  // 모델 생성
  Movie.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        keyword = map['keyword'],
        poster = map['poster'],
        like = map['like'];

  @override
  String toString() => "Movie<$title:$keyword>";
}
