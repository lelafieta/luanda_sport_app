// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreatePlayerTeamParams {
  final String? id;
  final String? playerId;
  final String? teamId;
  final int? value;
  final DateTime? joinedAt;
  final DateTime? leftAt;
  final String? position;
  final int? shirtNumber;
  final DateTime? createdAt;
  CreatePlayerTeamParams({
    this.id,
    this.playerId,
    this.teamId,
    this.value,
    this.joinedAt,
    this.leftAt,
    this.position,
    this.shirtNumber,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'playerId': playerId,
      'teamId': teamId,
      'value': value,
      'joinedAt': joinedAt?.millisecondsSinceEpoch,
      'leftAt': leftAt?.millisecondsSinceEpoch,
      'position': position,
      'shirtNumber': shirtNumber,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory CreatePlayerTeamParams.fromMap(Map<String, dynamic> map) {
    return CreatePlayerTeamParams(
      id: map['id'] != null ? map['id'] as String : null,
      playerId: map['playerId'] != null ? map['playerId'] as String : null,
      teamId: map['teamId'] != null ? map['teamId'] as String : null,
      value: map['value'] != null ? map['value'] as int : null,
      joinedAt: map['joinedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['joinedAt'] as int)
          : null,
      leftAt: map['leftAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['leftAt'] as int)
          : null,
      position: map['position'] != null ? map['position'] as String : null,
      shirtNumber:
          map['shirtNumber'] != null ? map['shirtNumber'] as int : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreatePlayerTeamParams.fromJson(String source) =>
      CreatePlayerTeamParams.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
