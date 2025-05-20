import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/resources/app_icons.dart';
import '../../../../core/strings/app_strings.dart';

class OrganizerProfileScreen extends StatefulWidget {
  const OrganizerProfileScreen({super.key});

  @override
  State<OrganizerProfileScreen> createState() => _OrganizerProfileScreenState();
}

class _OrganizerProfileScreenState extends State<OrganizerProfileScreen> {
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
                      'LINGARD',
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
                      text: ' Eventos',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    // const TextSpan(
                    //   text: '3,5 M',
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // TextSpan(
                    //   text: ' seguidores',
                    //   style: TextStyle(color: Colors.grey[700]),
                    // ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, color: Colors.grey),
              const SizedBox(width: 5),
              Text("Angola, Luanda, Morro Bento"),
            ],
          ),
          const SizedBox(height: 15),
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
