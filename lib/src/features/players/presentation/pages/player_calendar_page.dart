import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final Map<DateTime, List<Activity>> _events = {
    DateTime.utc(2025, 5, 16): [
      Activity('Treino físico', ActivityType.treino),
    ],
    DateTime.utc(2025, 5, 17): [
      Activity('Jogo contra FC Luanda', ActivityType.jogo),
      Activity('Jogo contra FC Luanda', ActivityType.jogo),
    ],
    DateTime.utc(2025, 5, 18): [
      Activity('Reunião de equipa', ActivityType.evento),
    ],
    DateTime.utc(2025, 5, 22): [
      Activity('Reunião de equipa', ActivityType.evento),
    ],
    DateTime.utc(2025, 5, 23): [
      Activity('Reunião de equipa', ActivityType.jogo),
      Activity('Sessão de Treino', ActivityType.treino),
      Activity('Algum evento', ActivityType.evento),
    ],
  };

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Activity> _getActivitiesForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final selectedActivities =
        _getActivitiesForDay(_selectedDay ?? _focusedDay);

    return Scaffold(
      body: Column(
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
            eventLoader: _getActivitiesForDay,
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
      ),
    );
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
}

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
