import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luanda_sport_app/src/app/app_entity.dart';
import 'package:luanda_sport_app/src/core/utils/app_date_utils.dart';
import 'package:luanda_sport_app/src/features/players/domain/entities/player_entity.dart';

import '../../../../core/resources/app_icons.dart';
import '../../../../core/strings/app_strings.dart';

class MyProfileWidget extends StatefulWidget {
  final PlayerEntity player;
  const MyProfileWidget({super.key, required this.player});

  @override
  State<MyProfileWidget> createState() => _MyProfileWidgetState();
}

class _MyProfileWidgetState extends State<MyProfileWidget> {
  bool? displayFlagPicker;
  @override
  Widget build(BuildContext context) {
    final String backgroundUrl =
        'https://cdn.pixabay.com/photo/2014/10/14/20/24/football-488714_1280.jpg';
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Imagem de capa
                  Image.network(
                    backgroundUrl,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      color: Colors.black12,
                    ),
                  ),
                  Positioned(
                    bottom: -60,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 70, // aumentado o tamanho do círculo
                            backgroundColor: Colors.white,
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://template.canva.com/EAGNKZtAo6g/1/0/1600w-HanCQ9IgHSA.jpg",
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                radius: 66, // aumentado o tamanho da imagem
                                backgroundImage: imageProvider,
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.verified,
                                color: Colors.blue, size: 22),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Text(
                      '${widget.player.fullName}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              // Informações adicionais
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: AppStrings.fontFamily,
                  ),
                  children: [
                    const TextSpan(
                      text: '3',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' Colaboradores • ',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const TextSpan(
                      text: '3,5 M',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' seguidores',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flags.fromString(
                  const [
                    "BR",
                    "BR",
                  ],
                  width: 30,
                  height: 20,
                  borderRadius: 5,
                ),
                const SizedBox(width: 5),
                Text("Angola, Luanda",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        )),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl:
                    "https://template.canva.com/EAGP4Vom1pY/1/0/1600w-IOa8p4GmFqQ.jpg",
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 20,
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.player.team!.name}",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "Equipe actual",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.grey[300],
            thickness: .5,
            height: 40,
          ),
          ListTile(
            leading: SvgPicture.asset(
              width: 25,
              AppIcons.footballJersey,
            ),
            title: Text("${widget.player.shirtNumber}"),
            subtitle: const Text("Camisa"),
            onTap: () {
              // Navegar para a tela de configurações
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              width: 25,
              AppIcons.footballShoesShoe,
            ),
            title: Text("${widget.player.foot}"),
            subtitle: const Text("Pé"),
            onTap: () {
              // Navegar para a tela de configurações
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              width: 25,
              AppIcons.soccerField,
            ),
            title: Text("${widget.player.position}"),
            subtitle: const Text("Posição"),
            onTap: () {
              // Navegar para a tela de configurações
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              width: 25,
              AppIcons.birthdayCake,
            ),
            title: Text(
                "${AppDateUtils.formatDate(data: widget.player.birthDate!)}"),
            subtitle: const Text("Aniversário"),
            onTap: () {
              // Navegar para a tela de configurações
            },
          ),
        ],
      ),
    );
  }
}

class PlayerStatsModel {
  final String name;
  final String position;
  final String team;
  final int matchesPlayed;
  final int goals;
  final int assists;
  final int yellowCards;
  final int redCards;
  final int minutesPlayed;
  final double passAccuracy;

  PlayerStatsModel({
    required this.name,
    required this.position,
    required this.team,
    required this.matchesPlayed,
    required this.goals,
    required this.assists,
    required this.yellowCards,
    required this.redCards,
    required this.minutesPlayed,
    required this.passAccuracy,
  });
}
