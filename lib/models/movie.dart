// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

Movie movieFromJson(String str) => Movie.fromJson(json.decode(str));

String movieToJson(Movie data) => json.encode(data.toJson());

class Movie {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

final genre = 
  [
    {"id": 28, "name": "Action", "color": const Color.fromARGB(255, 122, 33, 26)},
    {"id": 12, "name": "Adventure", "color": const Color.fromARGB(255, 121, 73, 0)},
    {"id": 16, "name": "Animation", "color": const Color.fromARGB(255, 13, 60, 99)},
    {"id": 35, "name": "Comedy", "color": const Color.fromARGB(255, 34, 82, 36)},
    {"id": 80, "name": "Crime", "color": const Color.fromARGB(255, 35, 46, 105)},
    {"id": 99, "name": "Documentary", "color": const Color.fromARGB(255, 72, 18, 81)},
    {"id": 18, "name": "Drama", "color": const Color.fromARGB(255, 37, 57, 13)},
    {"id": 10751, "name": "Family", "color": const Color.fromARGB(255, 0, 53, 96)},
    {"id": 14, "name": "Fantasy", "color": const Color.fromARGB(255, 0, 71, 64)},
    {"id": 36, "name": "History", "color": const Color.fromARGB(255, 106, 98, 23)},
    {"id": 27, "name": "Horror", "color": const Color.fromARGB(255, 120, 91, 4)},
    {"id": 10402, "name": "Music", "color": const Color.fromARGB(255, 79, 9, 32)},
    {"id": 9648, "name": "Mystery", "color": const Color.fromARGB(255, 84, 80, 40)},
    {"id": 10749, "name": "Romance", "color": const Color.fromARGB(255, 87, 18, 83)},
    {"id": 878, "name": "Science Fiction", "color": const Color.fromARGB(255, 31, 63, 38)},
    {"id": 10770, "name": "TV Movie", "color": const Color.fromARGB(255, 59, 37, 36)},
    {"id": 53, "name": "Thriller", "color": const Color.fromARGB(255, 27, 65, 46)},
    {"id": 10752, "name": "War", "color": Colors.brown},
    {"id": 37, "name": "Western", "color": Colors.indigo}
  ]
;
