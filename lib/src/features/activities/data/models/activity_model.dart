import 'dart:convert';

import '../../../players/domain/enums/activity_enum.dart';
import '../../domain/entities/activity_entity.dart';

class ActivityModel extends ActivityEntity {
  ActivityModel({
    super.date,
    super.title,
    super.type,
    super.description,
  });

  ActivityModel copyWith({
    DateTime? date,
    String? title,
    ActivityType? type,
    String? description,
  }) {
    return ActivityModel(
      date: date ?? this.date,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date?.millisecondsSinceEpoch,
      'title': title,
      'type': type,
      'description': description,
    };
  }

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
          : null,
      title: map['title'] != null ? map['title'] as String : null,
      type: map['type'],
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityModel.fromJson(String source) =>
      ActivityModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
