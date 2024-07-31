import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_apps/models/movie.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

 Future<Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath(); // database parent directory
    final db = await sql.openDatabase(
      path.join(dbPath,
          'movies.db'), // create database in that parent directory if it doesn't exist
      onCreate: (db, version) {
        // a function that executed when database is created for the first time
        return db.execute(
            'CREATE TABLE favorite_movies(adult TEXT, backdropPath TEXT, genreIds TEXT ,id INTEGER, originalLanguage TEXT, originalTitle TEXT, overview TEXT, popularity REAL, posterPath TEXT, releaseDate TEXT, title TEXT, video TEXT, voteAverage REAL, voteCount INTEGER)');
      },
      version: 1,
    );
    return db;
  }

class FavoritesMovieProvider extends StateNotifier<List<Movie>> {
  FavoritesMovieProvider(): super([]);

 

  Future<void> loadMovies () async {
    final db = await _getDatabase();
    final data = await db.query('favorite_movies');
    final movies = data.map(
      (row) => Movie(adult: row['adult'] as bool, backdropPath: row['backdropPath'] as String, genreIds: row['gerenIds'] as List<int>, id: row['id'] as int, originalLanguage: row['originalLanguage'] as String, originalTitle: row['originalTitle'] as String, overview: row['overview'] as String, popularity: row['popularity'] as double, posterPath: row['posterPath'] as String, releaseDate: row['releaseDate'] as DateTime, title: row['title'] as String, video: row['video'] as bool, voteAverage: row['voteAverage'] as double, voteCount: row['voteCount'] as int)
    ).toList();
    state = movies;
  }

  Future<bool> toogleFavorite (Movie movie)  async {
    final movieIsFavorited = state.contains(movie);

    if (movieIsFavorited) {
        state = state.where((element) => element.id != movie.id,).toList();
        return true;
    } else {
      final db = await _getDatabase();
      await db.insert('favorite_movies', {
        'adult' : movie.adult.toString(),
        'backdropPath': movie.backdropPath,
        'genreIds' : movie.genreIds.toString(),
        'id': movie.id,
        'originalLanguage': movie.originalLanguage,
        'originalTitle' : movie.originalTitle,
        'overview': movie.overview,
        'popularity': movie.popularity,
        'posterPath': movie.posterPath,
        'releaseDate': movie.releaseDate.toString(),
        'title': movie.title,
        'video': movie.video.toString(),
        'voteAverage': movie.voteAverage,
        'voteCount': movie.voteCount,
      });
      state = [...state, movie];
      return false;
    }
  }
}

final favoritesMovieProvider = StateNotifierProvider<FavoritesMovieProvider, List<Movie>>((ref) {
  return FavoritesMovieProvider();
});