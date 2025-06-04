import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luanda_sport_app/src/app/app_entity.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:sliver_snap/widgets/sliver_snap.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/utils/app_date_utils.dart';
import '../../../../core/utils/position_utils.dart';
import '../../../activities/domain/entities/activity_entity.dart';
import '../../../call_ups/domain/entities/call_up_entity.dart';
import '../../../call_ups/domain/params/update_call_up_status_params.dart';
import '../../../matches/domain/entities/cartaz_entity.dart';
import '../../../matches/domain/entities/match_entity.dart';
import '../../domain/enums/activity_enum.dart';
import '../cubit/activity/activity_cubit.dart';
import '../cubit/call_up_response/call_up_response_cubit.dart';

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
    return BlocBuilder<ActivityCubit, ActivityState>(
      builder: (context, state) {
        if (state is ActivityLoaded) {
          final selectedActivities = _getActivitiesForDay(
              _selectedDay ?? _focusedDay, state.activities);

          return SliverSnap(
            onCollapseStateChanged:
                (isCollapsed, scrollingOffset, maxExtent) {},
            collapsedBackgroundColor: Colors.black,
            expandedBackgroundColor: Colors.transparent,
            expandedContentHeight: 350,
            expandedContent: TableCalendar<ActivityEntity>(
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
              eventLoader: (day) => _getActivitiesForDay(day, state.activities),
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
            collapsedContent:
                const Icon(Icons.car_crash, color: Colors.green, size: 45),
            body: Material(
              elevation: 7,
              child: ListView.builder(
                itemCount: selectedActivities.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final activity = selectedActivities[index];

                  if (activity.callUp != null) {
                    return _buildCallUpWidget(activity.callUp!);
                  } else if (activity.match != null) {
                    return _buildMatchWidget(activity.match!);
                  } else {
                    return ListTile(
                      leading: Icon(
                        activity.icon,
                        color: _getColorForType(activity.type!),
                      ),
                      title: Text(activity.title ?? "Sem título"),
                      subtitle: Text(_formatDate(activity.date!)),
                    );
                  }
                },
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
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

                      if (activity.callUp != null) {
                        return _buildCallUpWidget(activity.callUp!);
                      } else if (activity.match != null) {
                        return _buildMatchWidget(activity.match!);
                      } else {
                        return ListTile(
                          leading: Icon(
                            activity.icon,
                            color: _getColorForType(activity.type!),
                          ),
                          title: Text(activity.title ?? "Sem título"),
                          subtitle: Text(_formatDate(activity.date!)),
                        );
                      }
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

  SizedBox _buildCallUpWidget(CallUpEntity callUp) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          border: Border.all(
            width: 1,
            color: Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: GestureDetector(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        (callUp.competitionId == null)
                            ? "Exibição"
                            : "Campeonato",
                        style: const TextStyle(
                          // color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  (callUp.match!.homeTeam == null)
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade300,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      )),
                                                ),
                                                const SizedBox(width: 8),
                                                const Text(
                                                  "Equipe de Casa",
                                                  style: TextStyle(),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: Row(children: [
                                                ClipOval(
                                                  child: (callUp
                                                              .match!
                                                              .homeTeam!
                                                              .logoUrl ==
                                                          null)
                                                      ? Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey.shade300,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                        )
                                                      : CachedNetworkImage(
                                                          width: 30,
                                                          height: 30,
                                                          fit: BoxFit.cover,
                                                          imageUrl: callUp
                                                              .match!
                                                              .homeTeam!
                                                              .logoUrl
                                                              .toString()),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  callUp.match!.homeTeam!.name
                                                      .toString(),
                                                  style: TextStyle(),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                  const SizedBox(height: 10),
                                  (callUp.match!.awayTeam == null)
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: Row(children: [
                                                ClipOval(
                                                  child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade300,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      )),
                                                ),
                                                const SizedBox(width: 8),
                                                const Text(
                                                  "Equipe de Fora",
                                                  style: TextStyle(),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: Row(children: [
                                                ClipOval(
                                                  child: (callUp
                                                              .match!
                                                              .awayTeam!
                                                              .logoUrl ==
                                                          null)
                                                      ? Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey.shade300,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                        )
                                                      : CachedNetworkImage(
                                                          width: 30,
                                                          height: 30,
                                                          fit: BoxFit.cover,
                                                          imageUrl: callUp
                                                              .match!
                                                              .awayTeam!
                                                              .logoUrl
                                                              .toString()),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  callUp.match!.awayTeam!.name
                                                      .toString(),
                                                  style: TextStyle(),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      PositionUtils.covertPosition(callUp.position.toString()),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(AppDateUtils.formatDate(data: callUp.visibleUntil!)),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lightWightColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.red.shade500),
                          ),
                        ),
                        onPressed: () {
                          Dialogs.materialDialog(
                              msg:
                                  'Tens a certeza que deseja recusar a convocatória?',
                              title: "Recusar",
                              color: Colors.white,
                              context: context,
                              titleAlign: TextAlign.center,
                              msgAlign: TextAlign.center,
                              actions: [
                                IconsOutlineButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  text: 'Cancelar',
                                  iconData: Icons.cancel_outlined,
                                  textStyle:
                                      const TextStyle(color: Colors.grey),
                                  iconColor: Colors.grey,
                                ),
                                IconsButton(
                                  padding: const EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  onPressed: () {
                                    context
                                        .read<CallUpResponseCubit>()
                                        .callUpUpdateStatus(
                                            UpdateCallUpStatusParams(
                                                id: callUp.id!,
                                                status: "declined"));

                                    Navigator.of(context).pop();
                                  },
                                  text: 'Recusar',
                                  iconData: Icons.close,
                                  color: Colors.red.shade700,
                                  textStyle:
                                      const TextStyle(color: Colors.white),
                                  iconColor: Colors.white,
                                ),
                              ]);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppIcons.close,
                              width: 22,
                              color: Colors.red.shade500,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Recusar",
                              style: TextStyle(color: Colors.red.shade500),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: AppColors.primary),
                        ),
                      ),
                      onPressed: () {
                        // context.read<CallUpResponseCubit>().callUpUpdateStatus(
                        //     UpdateCallUpStatusParams(
                        //         id: callUp.id!, status: "accepted"));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppIcons.check,
                            width: 22,
                            color: AppColors.white,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Aceitar",
                            style: TextStyle(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatchWidget(MatchEntity match) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: AppColors.primary),
                  ),
                ),
                onPressed: () {
                  final CartazEntity cartazExemplo = CartazEntity(
                    titulo: "Final do Campeonato Municipal",
                    equipeCasa: "Futebol Clube Luanda",
                    equipeVisitante: "Benfica de Talatona",
                    imagemEquipeCasa:
                        "https://template.canva.com/EAF1_XF3BJ4/2/0/1600w-dbetIJWoTcY.jpg",
                    imagemEquipeVisitante:
                        "https://template.canva.com/EAGVBjukC4Q/1/0/1600w-2noOBANFgDY.jpg",
                    logoCompeticao:
                        "https://example.com/imagens/campeonato-logo.png",
                    dataHora: DateTime(2025, 6, 15, 16, 30),
                    local: "Estádio 11 de Novembro",
                    descricao: 'Descrição do jogo',
                  );
                  // context.pushTransparentRoute(
                  //   SecondPage(
                  //     cartaz: cartazExemplo,
                  //   ),
                  // );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppIcons.images,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Partilhar cartaz",
                      style: TextStyle(color: AppColors.lightWightColor),
                    ),
                  ],
                )),
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      match.isExhibition == true
                          ? "Exibição"
                          : match.competition!.name,
                      style: const TextStyle(
                        // color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        )),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    width: 2, color: Colors.grey.shade200),
                              ),
                            ),
                            child: Column(
                              children: [
                                (match.homeTeam == null)
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: Row(children: [
                                              ClipOval(
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              const Text(
                                                "Equipe de Casa",
                                                style: TextStyle(),
                                              ),
                                            ]),
                                          ),
                                          const Text("-")
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Row(children: [
                                              ClipOval(
                                                child:
                                                    (match.homeTeam!.logoUrl ==
                                                            null)
                                                        ? Container(
                                                            width: 30,
                                                            height: 30,
                                                            color: Colors.grey)
                                                        : CachedNetworkImage(
                                                            width: 30,
                                                            height: 30,
                                                            fit: BoxFit.cover,
                                                            imageUrl: match
                                                                .homeTeam!
                                                                .logoUrl
                                                                .toString()),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                match.homeTeam!.name.toString(),
                                                style: const TextStyle(),
                                              ),
                                            ]),
                                          ),
                                          const Text("-")
                                        ],
                                      ),
                                const SizedBox(height: 10),
                                (match.awayTeam == null)
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: Row(children: [
                                              ClipOval(
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              const Text(
                                                "Equipe de Casa",
                                                style: TextStyle(),
                                              ),
                                            ]),
                                          ),
                                          const Text("-")
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Row(children: [
                                              ClipOval(
                                                child:
                                                    (match.awayTeam!.logoUrl ==
                                                            null)
                                                        ? Container(
                                                            width: 30,
                                                            height: 30,
                                                            color: Colors.grey)
                                                        : CachedNetworkImage(
                                                            width: 30,
                                                            height: 30,
                                                            fit: BoxFit.cover,
                                                            imageUrl: match
                                                                .awayTeam!
                                                                .logoUrl
                                                                .toString()),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                match.awayTeam!.name.toString(),
                                                style: const TextStyle(),
                                              ),
                                            ]),
                                          ),
                                          const Text("-")
                                        ],
                                      ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 50,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Center(
                                child: SvgPicture.asset(
                                  AppIcons.football,
                                  width: 20,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${match.matchDate!.hour}:${match.matchDate!.minute}",
                                style: const TextStyle(
                                  // color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Text(AppDateUtils.formatDate(
                showWeekday: true,
                data: match.matchDate!,
              )),
            )
          ],
        ),
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
