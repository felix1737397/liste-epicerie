import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:liste_epicerie/Entities/high_score_entity.dart';
import 'package:liste_epicerie/services/sqlite.service.dart';

//insert
//https://docs.flutter.dev/cookbook/persistence/sqlite

Future<bool> inserthighScore(HighScoreEntity highScore) async {
  final db = await SqliteService.database;

  await db.insert(
    'highscore',
    highScore.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  return true;
}

//select
Future<List<HighScoreEntity>> getAllHighScore() async {
  final db = await SqliteService.database;

  final List<Map<String, dynamic>> maps =
      await db.rawQuery("SELECT * FROM highscore ORDER BY score DESC");
  return List.generate(maps.length, (i) {
    return HighScoreEntity.fromMap(maps[i]);
  });
}

//delete
//delete an item
Future<void> deleteHighScore(int id) async {
  final db = await SqliteService.database;

  await db.delete(
    'highscore',
    where: "id = ?",
    whereArgs: [id],
  );
}

//update
Future<void> updateHighScore(HighScoreEntity highScore) async {
  final db = await SqliteService.database;

  await db.update(
    'highscore',
    highScore.toMap(),
    where: "id = ?",
    whereArgs: [highScore.id],
  );
}
