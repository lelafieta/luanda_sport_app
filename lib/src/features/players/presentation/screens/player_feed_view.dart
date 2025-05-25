import 'dart:typed_data';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:luanda_sport_app/src/core/utils/app_date_utils.dart';
import 'package:luanda_sport_app/src/features/call_ups/domain/entities/call_up_entity.dart';
import 'package:luanda_sport_app/src/features/call_ups/domain/params/update_call_up_status_params.dart';
import 'package:luanda_sport_app/src/features/matches/domain/entities/cartaz_entity.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../app/app_entity.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/utils/position_utils.dart';
import '../../../call_ups/presentation/cubit/call_up_cubit.dart';
import '../../../matches/domain/entities/match_entity.dart';
import '../../../matches/presentation/views/match_cartaz_view.dart';
import '../cubit/call_up_response/call_up_response_cubit.dart';
import '../cubit/player_upcoming_match/player_upcoming_match_cubit.dart';
import 'print_image.dart';

class PlayerFeedView extends StatefulWidget {
  const PlayerFeedView({super.key});

  @override
  State<PlayerFeedView> createState() => _PlayerFeedViewState();
}

class _PlayerFeedViewState extends State<PlayerFeedView> {
  // Simulações para exemplo
  final bool convocado = false;
  final bool noOnzeInicial = false;
  final bool isTreino = false; // true para mostrar treino

  // Detalhes do evento atual
  final String adversario = "Petro de Luanda";
  final String dataEvento = "Dom, 26 de Maio - 15h30";
  final String estadio = "Estádio 11 de Novembro";
  final String posicao = "Meio-Campo";

  // Próximos treinos (simulação)
  final List<Map<String, String>> proximosTreinos = [
    {"data": "Seg, 27 de Maio - 08h00", "local": "Campo Anexo 1"},
    {"data": "Qua, 29 de Maio - 16h00", "local": "Campo Principal"},
    {"data": "Sex, 31 de Maio - 10h00", "local": "Centro de Treinamento"},
  ];

  @override
  void initState() {
    context.read<CallUpCubit>().getCallUpByPlayerPending(AppEntity.uId!);
    context
        .read<PlayerUpcomingMatchCubit>()
        .getUpComingMatchesByPlayer(AppEntity.uId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const TitleWidget(title: "Meu Estatus na equipe")),
      body: FadeIn(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Proximo jogo",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildUpComingMatchesWidget(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  "Convocatórias",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              _buildCallUpsWidget(),
              const SizedBox(height: 16),
              if (convocado) ...[
                const SizedBox(height: 16),
                if (isTreino && proximosTreinos.isNotEmpty)
                  Card(
                    elevation: 2,
                    color: Colors.red[50],
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Próximos Treinos",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...proximosTreinos.map((treino) => ListTile(
                                leading: const Icon(Icons.schedule,
                                    color: Colors.red),
                                title: Text(treino['data']!),
                                subtitle: Text(treino['local']!),
                              )),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
              ],
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget showGame() {
    return Container(
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
            child: const Text(
              "Exibição",
              style: TextStyle(
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
                        right:
                            BorderSide(width: 2, color: Colors.grey.shade200),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Row(children: [
                                ClipOval(
                                  child: CachedNetworkImage(
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          "https://template.canva.com/EAF1_XF3BJ4/2/0/1600w-dbetIJWoTcY.jpg"),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Dourada FC",
                                  style: TextStyle(),
                                ),
                              ]),
                            ),
                            const Text("-")
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Row(children: [
                                ClipOval(
                                  child: CachedNetworkImage(
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          "https://template.canva.com/EAGVBjukC4Q/1/0/1600w-2noOBANFgDY.jpg"),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Ell Fantasma",
                                  style: TextStyle(),
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
                      const Text(
                        "20:00",
                        style: TextStyle(
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
    );
  }

  Widget _buildUpComingMatchesWidget() {
    return BlocBuilder<PlayerUpcomingMatchCubit, PlayerUpcomingMatchState>(
      builder: (context, state) {
        if (state is PlayerUpcomingMatchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PlayerUpcomingMatchLoaded) {
          final matches = state.upcomingMatches;

          if (matches.isEmpty) {
            return const Center(child: Text("Sem jogos"));
          }

          return ImageSlideshow(
            width: double.infinity,
            height: 250,
            initialPage: 0,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              print('Page changed: $value');
            },
            autoPlayInterval: 0,
            isLoop: false,
            children: matches.map((match) {
              return nextMatchWidget(match);
            }).toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget nextMatchWidget(MatchEntity match) {
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
                  context.pushTransparentRoute(
                    SecondPage(
                      cartaz: cartazExemplo,
                    ),
                  );
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

  Widget _buildCallUpsWidget() {
    return BlocConsumer<CallUpResponseCubit, CallUpResponseState>(
      listener: (context, state) {
        EasyLoading.dismiss();
        if (state is CallUpResponseLoading) {
          EasyLoading.show();
        } else if (state is CallUpResponseSuccess) {
          context.read<CallUpCubit>().getCallUpByPlayerPending(AppEntity.uId!);
        } else if (state is CallUpResponseFailure) {
          EasyLoading.showError(state.error);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<CallUpCubit, CallUpState>(
            builder: (context, state) {
              if (state is CallUpLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CallUpLoaded) {
                final callUps = state.callUps;
                if (callUps.isEmpty) {
                  return const Center(child: Text("Sem convocatória"));
                }

                return FadeIn(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final callUp = callUps[index];

                      return _callUpComponent(callUp);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: callUps.length,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }

  SizedBox _callUpComponent(CallUpEntity callUp) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(10),
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
                        fontWeight: ui.FontWeight.bold,
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
                                  textStyle: TextStyle(color: Colors.grey),
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
}

const imageUrl =
    'https://user-images.githubusercontent.com/26390946/155666045-aa93bf48-f8e7-407c-bb19-bc247d9e12bd.png';

class SecondPage extends StatelessWidget {
  final CartazEntity cartaz;

  const SecondPage({super.key, required this.cartaz});
  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      isFullScreen: false,
      disabled: false,
      minRadius: 10,
      maxRadius: 10,
      dragSensitivity: 1.0,
      maxTransformValue: .8,
      direction: DismissiblePageDismissDirection.multi,
      backgroundColor: Colors.black,
      onDragStart: () {
        print('onDragStart');
      },
      onDragUpdate: (details) {
        print(details);
      },
      dismissThresholds: const {
        DismissiblePageDismissDirection.vertical: .2,
      },
      minScale: .8,
      startingOpacity: 1,
      reverseDuration: const Duration(milliseconds: 250),
      onDismissed: () {
        Navigator.of(context).pop();
      },
      child: MatchCartazView(cartaz: cartaz),
    );
  }
}
