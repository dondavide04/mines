import 'package:mines/database/match.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MatchesDatabase {
  static final MatchesDatabase instance = MatchesDatabase._init();

  static Database? _database;

  MatchesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableMatches (
      ${MatchFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${MatchFields.cells} INTEGER NOT NULL,
      ${MatchFields.mines} INTEGER NOT NULL,
      ${MatchFields.win} BOOLEAN NOT NULL,
      ${MatchFields.startedAt} TEXT NOT NULL,
      ${MatchFields.endedAt} TEXT
    )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<Match> create(Match match) async {
    final db = await instance.database;
    final id = await db.insert(tableMatches, match.toMap());
    return match.copy(id: id);
  }

  Future<Match?> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableMatches,
        columns: MatchFields.values,
        where: '${MatchFields.id} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Match.fromMap(maps.first);
    }
  }

  Future<List<Match>> readAll() async {
    final db = await instance.database;
    final maps = await db.query(tableMatches, columns: MatchFields.values);
    return maps.map(Match.fromMap).toList();
  }

  Future<int> update(Match match) async {
    final db = await instance.database;
    return db.update(tableMatches, match.toMap(),
        where: '${MatchFields.id} = ?', whereArgs: [match.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db
        .delete(tableMatches, where: '${MatchFields.id} = ?', whereArgs: [id]);
  }
}
