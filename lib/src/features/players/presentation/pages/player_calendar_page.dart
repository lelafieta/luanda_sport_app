import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luanda_sport_app/src/app/app_entity.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../activities/domain/entities/activity_entity.dart';
import '../../domain/enums/activity_enum.dart';
import '../cubit/activity/activity_cubit.dart';

// Enum e modelo

class Activity {
  final String title;
  final ActivityType type;
  final DateTime date;

  Activity(this.title, this.type, this.date);

  IconData get icon {
    switch (type) {
      case ActivityType.trainingSession:
        return Icons.fitness_center;
      case ActivityType.match:
        return Icons.sports_soccer;
      case ActivityType.callUp:
        return Icons.event;
    }
  }
}

// Página do calendário
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    context.read<ActivityCubit>().loadActivities(AppEntity.uId!,
        "73e63a02-901f-4d21-9b20-6c120ee3975d"); // Use valores reais
  }

  List<ActivityEntity> _getActivitiesForDay(
      DateTime day, List<ActivityEntity> activities) {
    return activities.where((activity) {
      return isSameDay(activity.date, day);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ActivityCubit, ActivityState>(
        builder: (context, state) {
          if (state is ActivityLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ActivityFailure) {
            return Center(child: Text(state.error));
          } else if (state is ActivityLoaded) {
            final selectedActivities = _getActivitiesForDay(
                _selectedDay ?? _focusedDay, state.activities);

            return Column(
              children: [
                TableCalendar<ActivityEntity>(
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
                  eventLoader: (day) =>
                      _getActivitiesForDay(day, state.activities),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: Icon(
                                activity.icon,
                                size: 14,
                                color: _getColorForType(activity.type!),
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
                        leading: Icon(
                          activity.icon,
                          color: _getColorForType(activity.type!),
                        ),
                        title: Text(activity.title ?? "Sem titulo"),
                        subtitle: Text(_formatDate(activity.date!)),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Color _getColorForType(ActivityType type) {
    switch (type) {
      case ActivityType.trainingSession:
        return Colors.green;
      case ActivityType.match:
        return Colors.red;
      case ActivityType.callUp:
        return Colors.orange;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
