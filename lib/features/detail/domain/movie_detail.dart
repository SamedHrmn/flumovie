import 'package:json_annotation/json_annotation.dart';

part 'movie_detail.g.dart';

@JsonSerializable()
class MovieDetail {
  MovieDetail({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) => _$MovieDetailFromJson(json);
  @JsonKey(name: 'adult')
  final bool? adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'belongs_to_collection')
  final dynamic belongsToCollection;
  @JsonKey(name: 'budget')
  final int? budget;
  @JsonKey(name: 'genres')
  final List<Genre>? genres;
  @JsonKey(name: 'homepage')
  final String? homepage;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'imdb_id')
  final String? imdbId;
  @JsonKey(name: 'original_language')
  final String? originalLanguage;
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  @JsonKey(name: 'overview')
  final String? overview;
  @JsonKey(name: 'popularity')
  final double? popularity;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'production_companies')
  final List<ProductionCompany>? productionCompanies;
  @JsonKey(name: 'production_countries')
  final List<ProductionCountry>? productionCountries;
  @JsonKey(name: 'release_date')
  final DateTime? releaseDate;
  @JsonKey(name: 'revenue')
  final int? revenue;
  @JsonKey(name: 'runtime')
  final int? runtime;
  @JsonKey(name: 'spoken_languages')
  final List<SpokenLanguage>? spokenLanguages;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'tagline')
  final String? tagline;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'video')
  final bool? video;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;

  Map<String, dynamic> toJson() => _$MovieDetailToJson(this);
}

@JsonSerializable()
class Genre {
  Genre({
    this.id,
    this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}

@JsonSerializable()
class ProductionCompany {
  ProductionCompany({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) => _$ProductionCompanyFromJson(json);
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'logo_path')
  final dynamic logoPath;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'origin_country')
  final String? originCountry;

  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);
}

@JsonSerializable()
class ProductionCountry {
  ProductionCountry({
    this.iso31661,
    this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) => _$ProductionCountryFromJson(json);
  @JsonKey(name: 'iso_3166_1')
  final String? iso31661;
  @JsonKey(name: 'name')
  final String? name;

  Map<String, dynamic> toJson() => _$ProductionCountryToJson(this);
}

@JsonSerializable()
class SpokenLanguage {
  SpokenLanguage({
    this.englishName,
    this.iso6391,
    this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => _$SpokenLanguageFromJson(json);
  @JsonKey(name: 'english_name')
  final String? englishName;
  @JsonKey(name: 'iso_639_1')
  final String? iso6391;
  @JsonKey(name: 'name')
  final String? name;

  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);
}
