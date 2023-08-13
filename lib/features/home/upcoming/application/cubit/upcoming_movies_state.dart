// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flumovie/features/home/upcoming/application/upcoming_movies_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upcoming_movies_state.g.dart';

enum UpcomingMoviesStatus { initial, loading, success, failure }

@JsonSerializable()
class UpcomingMoviesState {
  UpcomingMoviesState({required this.status, this.upcomingMoviesDTO});

  final UpcomingMoviesDTO? upcomingMoviesDTO;
  final UpcomingMoviesStatus status;

  UpcomingMoviesState copyWith({
    UpcomingMoviesDTO? upcomingMoviesDTO,
    UpcomingMoviesStatus? status,
  }) {
    return UpcomingMoviesState(
      upcomingMoviesDTO: upcomingMoviesDTO ?? this.upcomingMoviesDTO,
      status: status ?? this.status,
    );
  }

  factory UpcomingMoviesState.fromJson(Map<String, dynamic> json) => _$UpcomingMoviesStateFromJson(json);

  Map<String, dynamic> toJson() => _$UpcomingMoviesStateToJson(this);
}
