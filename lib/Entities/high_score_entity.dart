import 'dart:convert';

class HighScoreEntity {
  DateTime dateTime;
  String username;
  int score;
  int? id;

  HighScoreEntity({
    required this.dateTime,
    required this.username,
    required this.score,
    this.id,
  });

  HighScoreEntity copyWith({
    DateTime? dateTime,
    String? username,
    int? score,
  }) {
    return HighScoreEntity(
      dateTime: dateTime ?? this.dateTime,
      username: username ?? this.username,
      score: score ?? this.score,
      id: id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime.millisecondsSinceEpoch,
      'username': username,
      'score': score,
    };
  }

  factory HighScoreEntity.fromMap(Map<String, dynamic> map) {
    return HighScoreEntity(
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      username: map['username'] ?? '',
      score: map['score']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory HighScoreEntity.fromJson(String source) =>
      HighScoreEntity.fromMap(json.decode(source));

  @override
  String toString() =>
      'HighScore(dateTime: $dateTime, username: $username, score: $score)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HighScoreEntity &&
        other.dateTime == dateTime &&
        other.username == username &&
        other.score == score;
  }

  @override
  int get hashCode => dateTime.hashCode ^ username.hashCode ^ score.hashCode;
}
