import '../../domain/entities/prize_entity.dart';

class PrizeModel extends PrizeEntity {
  PrizeModel({
    super.prizeChampion,
    super.prizeTopScorer,
    super.prizeFairPlay,
  });

  // Converting PrizeModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'prizeChampion': prizeChampion,
      'prizeTopScorer': prizeTopScorer,
      'prizeFairPlay': prizeFairPlay,
    };
  }

  // Converting JSON to PrizeModel
  factory PrizeModel.fromJson(Map<String, dynamic> json) {
    return PrizeModel(
      prizeChampion: json['prizeChampion'] ?? false, // Default to false if null
      prizeTopScorer:
          json['prizeTopScorer'] ?? false, // Default to false if null
      prizeFairPlay: json['prizeFairPlay'] ?? false, // Default to false if null
    );
  }
}
