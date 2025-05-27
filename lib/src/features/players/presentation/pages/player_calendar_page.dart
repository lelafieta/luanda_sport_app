import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

// Enums e models
enum ActivityType { treino, jogo, evento }

class Activity {
  final String title;
  final ActivityType type;

  Activity(this.title, this.type);

  IconData get icon {
    switch (type) {
      case ActivityType.treino:
        return Icons.fitness_center;
      case ActivityType.jogo:
        return Icons.sports_soccer;
      case ActivityType.evento:
        return Icons.event;
    }
  }
}

// Dummy models (suas entidades)
class TrainingSession {
  final String title;
  final DateTime date;

  TrainingSession(this.title, this.date);
}

class Match {
  final String opponent;
  final DateTime date;

  Match(this.opponent, this.date);
}

class CallUp {
  final String reason;
  final DateTime date;

  CallUp(this.reason, this.date);
}

// Cubits
class TrainingSessionsCubit extends Cubit<List<TrainingSession>> {
  TrainingSessionsCubit() : super([]);

  void loadTrainings() {
    emit([
      TrainingSession('Treino físico', DateTime.utc(2025, 5, 16)),
      TrainingSession('Sessão de Treino', DateTime.utc(2025, 5, 23)),
    ]);
  }
}

class MatchesCubit extends Cubit<List<Match>> {
  MatchesCubit() : super([]);

  void loadMatches() {
    emit([
      Match('FC Luanda', DateTime.utc(2025, 5, 17)),
      Match('Outro Jogo', DateTime.utc(2025, 5, 23)),
    ]);
  }
}

class CallUpsCubit extends Cubit<List<CallUp>> {
  CallUpsCubit() : super([]);

  void loadCallUps() {
    emit([
      CallUp('Reunião de equipa', DateTime.utc(2025, 5, 18)),
      CallUp('Algum evento', DateTime.utc(2025, 5, 23)),
    ]);
  }
}

// Página principal
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<Activity>> _mergeActivities({
    required List<TrainingSession> trainings,
    required List<Match> matches,
    required List<CallUp> callUps,
  }) {
    final Map<DateTime, List<Activity>> events = {};

    void addActivity(DateTime date, Activity activity) {
      final key = DateTime.utc(date.year, date.month, date.day);
      events.putIfAbsent(key, () => []).add(activity);
    }

    for (var t in trainings) {
      addActivity(t.date, Activity(t.title, ActivityType.treino));
    }

    for (var m in matches) {
      addActivity(
          m.date, Activity('Jogo contra ${m.opponent}', ActivityType.jogo));
    }

    for (var c in callUps) {
      addActivity(c.date, Activity(c.reason, ActivityType.evento));
    }

    return events;
  }

  List<Activity> _getActivitiesForDay(
      DateTime day, Map<DateTime, List<Activity>> events) {
    return events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  Color _getColorForType(ActivityType type) {
    switch (type) {
      case ActivityType.treino:
        return Colors.green;
      case ActivityType.jogo:
        return Colors.red;
      case ActivityType.evento:
        return Colors.orange;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  void initState() {
    super.initState();
    context.read<TrainingSessionsCubit>().loadTrainings();
    context.read<MatchesCubit>().loadMatches();
    context.read<CallUpsCubit>().loadCallUps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📅 Agenda do Jogador')),
      body: MultiBlocBuilder<List<TrainingSession>, List<Match>, List<CallUp>>(
        blocs: (
          context.watch<TrainingSessionsCubit>(),
          context.watch<MatchesCubit>(),
          context.watch<CallUpsCubit>()
        ),
        builder: (context, trainings, matches, callUps) {
          final events = _mergeActivities(
            trainings: trainings,
            matches: matches,
            callUps: callUps,
          );

          final selectedActivities = _getActivitiesForDay(
            _selectedDay ?? _focusedDay,
            events,
          );

          return Column(
            children: [
              TableCalendar<Activity>(
                focusedDay: _focusedDay,
                firstDay: DateTime.utc(2024, 1, 1),
                lastDay: DateTime.utc(2026, 12, 31),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selected, focused) {
                  setState(() {
                    _selectedDay = selected;
                    _focusedDay = focused;
                  });
                },
                eventLoader: (day) => _getActivitiesForDay(day, events),
                calendarStyle: const CalendarStyle(
                  markerDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (events.isNotEmpty) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: events.take(3).map((activity) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: Icon(
                              activity.icon,
                              size: 14,
                              color: _getColorForType(activity.type),
                            ),
                          );
                        }).toList(),
                      );
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: selectedActivities.length,
                  itemBuilder: (context, index) {
                    final activity = selectedActivities[index];
                    return ListTile(
                      leading: Icon(activity.icon,
                          color: _getColorForType(activity.type)),
                      title: Text(activity.title),
                      subtitle: Text(_formatDate(_selectedDay ?? _focusedDay)),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
