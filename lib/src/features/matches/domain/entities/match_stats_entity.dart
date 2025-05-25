import '../../data/models/match_model.dart';

class MatchStatsEntity {
  final String? id;
  final int? goalsHome;
  final int? goalsAway;
  final double? possessionHome;
  final double? possessionAway;
  final int? shotsHome;
  final int? shotsAway;
  final int? foulsHome;
  final int? foulsAway;
  final int? yellowCardsHome;
  final int? yellowCardsAway;
  final int? redCardsHome;
  final int? redCardsAway;
  final int? cornersHome;
  final int? cornersAway;

  MatchStatsEntity({
    this.id,
    this.goalsHome,
    this.goalsAway,
    this.possessionHome,
    this.possessionAway,
    this.shotsHome,
    this.shotsAway,
    this.foulsHome,
    this.foulsAway,
    this.yellowCardsHome,
    this.yellowCardsAway,
    this.redCardsHome,
    this.redCardsAway,
    this.cornersHome,
    this.cornersAway,
  });
}
