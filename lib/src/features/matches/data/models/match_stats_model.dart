import '../../domain/entities/match_stats_entity.dart';

class MatchStatsModel extends MatchStatsEntity {
  MatchStatsModel({
    super.id,
    super.goalsHome,
    super.goalsAway,
    super.possessionHome,
    super.possessionAway,
    super.shotsHome,
    super.shotsAway,
    super.foulsHome,
    super.foulsAway,
    super.yellowCardsHome,
    super.yellowCardsAway,
    super.redCardsHome,
    super.redCardsAway,
    super.cornersHome,
    super.cornersAway,
  });

  factory MatchStatsModel.fromMap(Map<String, dynamic> map) {
    return MatchStatsModel(
      id: map['id'],
      goalsHome: map['goals_home'] ?? 0,
      goalsAway: map['goals_away'] ?? 0,
      possessionHome: (map['possession_home'] ?? 0).toDouble(),
      possessionAway: (map['possession_away'] ?? 0).toDouble(),
      shotsHome: map['shots_home'] ?? 0,
      shotsAway: map['shots_away'] ?? 0,
      foulsHome: map['fouls_home'] ?? 0,
      foulsAway: map['fouls_away'] ?? 0,
      yellowCardsHome: map['yellow_cards_home'] ?? 0,
      yellowCardsAway: map['yellow_cards_away'] ?? 0,
      redCardsHome: map['red_cards_home'] ?? 0,
      redCardsAway: map['red_cards_away'] ?? 0,
      cornersHome: map['corners_home'] ?? 0,
      cornersAway: map['corners_away'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'goals_home': goalsHome,
      'goals_away': goalsAway,
      'possession_home': possessionHome,
      'possession_away': possessionAway,
      'shots_home': shotsHome,
      'shots_away': shotsAway,
      'fouls_home': foulsHome,
      'fouls_away': foulsAway,
      'yellow_cards_home': yellowCardsHome,
      'yellow_cards_away': yellowCardsAway,
      'red_cards_home': redCardsHome,
      'red_cards_away': redCardsAway,
      'corners_home': cornersHome,
      'corners_away': cornersAway,
    };
  }
}
