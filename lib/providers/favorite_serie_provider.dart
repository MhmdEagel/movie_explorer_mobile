import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_apps/models/serie.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

Future<Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath(); // database parent directory
    final db = await sql.openDatabase(
      path.join(dbPath,
          'series.db'), // create database in that parent directory if it doesn't exist
      onCreate: (db, version) {
        // a function that executed when database is created for the first time
        return db.execute(
            'CREATE TABLE favorite_series(adult TEXT, backdropPath TEXT, genreIds TEXT, id INTEGER, originCountry TEXT, originalLanguage TEXT, originalName TEXT, overview TEXT, popularity REAL, posterPath TEXT, firstAirDate TEXT, name TEXT, voteAverage REAL, voteCount INTEGER)');
      },
      version: 1,
    );
    return db;
  }

class FavoriteSerieProvider extends StateNotifier<List<Serie>> {
  FavoriteSerieProvider(): super([]);


  Future<void> loadSeries () async {
    final db = await _getDatabase();
    final data = await db.query('favorite_series');
    final series = data.map(
      (row) => Serie(adult: row['adult'] as bool, backdropPath: row['backdropPath'] as String, genreIds: row['gerenIds'] as List<int>, id: row['id'] as int, 
      originalLanguage: row['originalLanguage'] as String, originalName: row['originalName'] as String, overview: row['overview'] as String, popularity: row['popularity'] as double, posterPath: row['posterPath'] as String, firstAirDate: row['firstAirDate'] as DateTime, name: row['name'] as String, voteAverage: row['voteAverage'] as double, voteCount: row['voteCount'] as int, originCountry: row['originCountry'] as List<String>)
    ).toList();
    state = series;
  }
  

  Future<bool> toogleFavorite (Serie serie) async {
    final serieIsFavorited = state.contains(serie);

    if (serieIsFavorited) {
        state = state.where((element) => element.id != serie.id,).toList();
        return true;
    } else {
      state = [...state, serie];
      final db = await _getDatabase();
      await db.insert('favorite_series', {
        'adult' : serie.adult.toString(),
        'backdropPath': serie.backdropPath,
        'genreIds' : serie.genreIds.toString(),
        'id': serie.id,
        'originCountry': serie.originCountry.toString(),
        'originalLanguage': serie.originalLanguage,
        'originalName' : serie.originalName,
        'overview': serie.overview,
        'popularity': serie.popularity,
        'posterPath': serie.posterPath,
        'firstAirDate': serie.firstAirDate.toString(),
        'name': serie.name,
        'voteAverage': serie.voteAverage,
        'voteCount': serie.voteCount,
      });
      return false;
    }
  }
}

final favoriteSerieProvider = StateNotifierProvider<FavoriteSerieProvider, List<Serie>>((ref) {
  return FavoriteSerieProvider();
});