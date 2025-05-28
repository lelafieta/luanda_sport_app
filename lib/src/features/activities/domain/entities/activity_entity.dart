import 'package:flutter/material.dart';
import 'package:luanda_sport_app/src/features/call_ups/domain/entities/call_up_entity.dart';
import 'package:luanda_sport_app/src/features/matches/domain/entities/match_entity.dart';
import 'package:luanda_sport_app/src/features/training_sessions/domain/entities/training_session_entity.dart';

import '../../../players/domain/enums/activity_enum.dart';

class ActivityEntity {
  final DateTime? date;
  final String? title;
  final ActivityType? type;
  final String? description;
  final TrainingSessionEntity? trainingSession;
  final MatchEntity? match;
  final CallUpEntity? callUp;

  const ActivityEntity(
      {this.date,
      this.title,
      this.type,
      this.description,
      this.match,
      this.trainingSession,
      this.callUp});

  IconData get icon {
    switch (type) {
      case ActivityType.trainingSession:
        return Icons.fitness_center;
      case ActivityType.match:
        return Icons.sports_soccer;
      case ActivityType.callUp:
        return Icons.call;
      default:
        return Icons.sports_soccer;
    }
  }
}
