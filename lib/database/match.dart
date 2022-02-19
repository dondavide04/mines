const String tableMatches = 'matches';

class MatchFields {
  static const values = [id, cells, mines, win, startedAt, endedAt];

  static const String id = '_id';
  static const String cells = 'cells';
  static const String mines = 'mines';
  static const String win = 'win';
  static const String startedAt = 'startedAt';
  static const String endedAt = 'endedAt';
}

class Match {
  final int? id;
  final int cells;
  final int mines;
  final bool win;
  final DateTime startedAt;
  final DateTime? endedAt;

  const Match({
    this.id,
    required this.cells,
    required this.mines,
    required this.win,
    required this.startedAt,
    this.endedAt,
  });

  Match copy({
    int? id,
    int? cells,
    int? mines,
    bool? win,
    DateTime? startedAt,
    DateTime? endedAt,
  }) =>
      Match(
        id: id ?? this.id,
        cells: cells ?? this.cells,
        mines: mines ?? this.mines,
        win: win ?? this.win,
        startedAt: startedAt ?? this.startedAt,
        endedAt: endedAt ?? this.endedAt,
      );

  Map<String, Object?> toMap() => {
        MatchFields.id: id,
        MatchFields.cells: cells,
        MatchFields.mines: mines,
        MatchFields.win: win ? 1 : 0,
        MatchFields.startedAt: startedAt.toIso8601String(),
        MatchFields.endedAt: endedAt?.toIso8601String(),
      };

  static Match fromMap(Map<String, Object?> map) {
    final endedAtMap = map[MatchFields.endedAt] as String?;
    return Match(
        id: map[MatchFields.id] as int?,
        cells: map[MatchFields.cells] as int,
        mines: map[MatchFields.mines] as int,
        win: map[MatchFields.win] == 1,
        startedAt: DateTime.parse(map[MatchFields.startedAt] as String),
        endedAt: endedAtMap == null ? null : DateTime.parse(endedAtMap));
  }
}
