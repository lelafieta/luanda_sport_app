import '../../domain/entities/rule_entity.dart';

class RulesModel extends RuleEntity {
  RulesModel({
    super.tiebreakers,
    super.matchDuration,
    super.restTime,
    super.substitutionsAllowed,
    super.drawsAllowed,
    super.extraTimeAllowed,
    super.extraTimeDuration,
    super.penaltyAllowed,
    super.homeAndAway,
    super.pointsVictory,
    super.pointsDraw,
    super.pointsLose,
    super.maxPlayers,
    super.registrationDeadline,
    super.foreignPlayers,
    super.punishments,
    super.createdBy,
  });

  // Converting RulesModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'tiebreakers': tiebreakers,
      'matchDuration': matchDuration,
      'restTime': restTime,
      'substitutionsAllowed': substitutionsAllowed,
      'drawsAllowed': drawsAllowed,
      'extraTimeAllowed': extraTimeAllowed,
      'extraTimeDuration': extraTimeDuration,
      'penaltyAllowed': penaltyAllowed,
      'homeAndAway': homeAndAway,
      'pointsVictory': pointsVictory,
      'pointsDraw': pointsDraw,
      'pointsLose': pointsLose,
      'maxPlayers': maxPlayers,
      'registrationDeadline': registrationDeadline?.toIso8601String(),
      'foreignPlayers': foreignPlayers,
      'punishments': punishments,
      'createdBy': createdBy,
    };
  }

  // Converting JSON to RulesModel
  factory RulesModel.fromJson(Map<String, dynamic> json) {
    return RulesModel(
      tiebreakers: json['tiebreakers'] != null
          ? List<String>.from(json['tiebreakers'])
          : null,
      matchDuration: json['matchDuration'],
      restTime: json['restTime'],
      substitutionsAllowed: json['substitutionsAllowed'],
      drawsAllowed: json['drawsAllowed'],
      extraTimeAllowed: json['extraTimeAllowed'],
      extraTimeDuration: json['extraTimeDuration'],
      penaltyAllowed: json['penaltyAllowed'],
      homeAndAway: json['homeAndAway'],
      pointsVictory: json['pointsVictory'],
      pointsDraw: json['pointsDraw'],
      pointsLose: json['pointsLose'],
      maxPlayers: json['maxPlayers'],
      registrationDeadline: json['registrationDeadline'] != null
          ? DateTime.parse(json['registrationDeadline'])
          : null,
      foreignPlayers: json['foreignPlayers'],
      punishments: json['punishments'] != null
          ? List<String>.from(json['punishments'])
          : null,
      createdBy: json['createdBy'],
    );
  }
}
