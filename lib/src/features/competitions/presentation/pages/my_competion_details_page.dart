import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luanda_sport_app/src/core/strings/app_strings.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../home/presentantion/screens/home_page.dart';
import '../../../home/presentantion/old_home';

class CompetitionDetailsPage extends StatefulWidget {
  const CompetitionDetailsPage({super.key});

  @override
  State<CompetitionDetailsPage> createState() => _CompetitionDetailsPageState();
}

class _CompetitionDetailsPageState extends State<CompetitionDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final int totalPartidas = 6;
  final ValueNotifier<int> partidaAtual = ValueNotifier<int>(3);

  final String backgroundUrl =
      'https://scontent.flad5-1.fna.fbcdn.net/v/t39.30808-6/481972096_1207928134015658_4427683262273356979_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=zV_8X74IuyoQ7kNvwFNQ4ob&_nc_oc=AdkuSLXzaRPCkaG4Rk49w94sTBmd8Fhxnz2QazxYg2iIpuENHNFuCjDX0VJn-DIsKu_tpPTIOY-QLCN9VE_o77Vv&_nc_zt=23&_nc_ht=scontent.flad5-1.fna&_nc_gid=6g5SEc_mHR1ryf38jcOikw&oh=00_AfHwiN08xuDHuwgUxbjxBUvvfo7y6kwFlL6d0wj-XXV6kA&oe=68047308';
  final String profileUrl =
      'https://scontent.flad5-1.fna.fbcdn.net/v/t39.30808-6/468946321_1143394810468991_6731165110528390324_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=wSrOeJxvDDEQ7kNvwEbvT6L&_nc_oc=AdlTqHYlCPFGfrAGQlDwBDoWGWHzOtYBQvPLz5DFEahZRV2c0WoBBuSIrcQrBKYO_91fpJuk6Y9c1v6oU_Uldije&_nc_zt=23&_nc_ht=scontent.flad5-1.fna&_nc_gid=bu1cwd0CKmhmqZJFsKvxIg&oh=00_AfHS3wRkCA00310Cb6BF1t2f-b46KjsWZzhIrcgxTejGig&oe=68048141';
  final String team1Logo =
      'https://scontent.flad5-1.fna.fbcdn.net/v/t39.30808-1/449761244_1062646795218211_4139834764378388664_n.jpg?stp=c196.196.1199.1199a_dst-jpg_s200x200_tt6&_nc_cat=1&ccb=1-7&_nc_sid=2d3e12&_nc_ohc=2PIv9d0zbT4Q7kNvwFrDdyl&_nc_oc=Adnbea-uBG6-Yjz-swaIok52lxeGLlxbFYlST90cK4dm1KdQveMu-MleJfCBBy4zbgL6PbCyY77uA-Jx-87CXmsf&_nc_zt=24&_nc_ht=scontent.flad5-1.fna&_nc_gid=b_6-6aTZFayQsgqhCcyxhQ&oh=00_AfE78XoqOuYLsaL3vLfGnPlltyuw8ZA_dK-vkLTcnXYkEA&oe=68047744';
  final String team2Logo =
      'https://scontent.flad5-1.fna.fbcdn.net/v/t39.30808-1/273144602_10152602977424953_1955203260619408476_n.jpg?stp=dst-jpg_s200x200_tt6&_nc_cat=1&ccb=1-7&_nc_sid=2d3e12&_nc_ohc=q-W_7Ofx0GIQ7kNvwGEJVrU&_nc_oc=Adnh-RBMtZE6Kr9ubdATmRiKH6NAEiVO92HwxQXcJXb10vyt6hqv1nhkO14Pimi4X05KqocWeD2Q83HP7vsW3Xw6&_nc_zt=24&_nc_ht=scontent.flad5-1.fna&_nc_gid=tINtmFSQ5O2qx6UrzJ1Xjg&oh=00_AfFWaHkb26Gz6qnHdeiku917wrHIZY8eRqAgYFACd31o-Q&oe=68047B4B';
  final List<MatchModel> matches = List.generate(
    6,
    (index) => MatchModel(
      homeTeam: 'FC Bayern Munich',
      awayTeam: 'Manchester United My team',
      homeScore: 3,
      awayScore: 2,
      minute: 48,
      homePossession: 0.78,
      homeLogo:
          'https://upload.wikimedia.org/wikipedia/pt/9/98/Real_Madrid.png',
      awayLogo:
          'https://upload.wikimedia.org/wikipedia/pt/b/b6/Manchester_United_FC_logo.png',
    ),
  );

  final List<Map<String, dynamic>> tableData = [
    {"pos": 1, "club": "Victory Greens", "w": 25, "d": 5, "l": 4, "pts": 80},
    {"pos": 2, "club": "Red Devils", "w": 20, "d": 8, "l": 6, "pts": 68},
    {"pos": 3, "club": "Blue Monkeys", "w": 20, "d": 8, "l": 6, "pts": 68},
    {"pos": 4, "club": "Crazy Eagle", "w": 19, "d": 10, "l": 5, "pts": 67},
    {"pos": 5, "club": "Rocky Birds", "w": 19, "d": 10, "l": 5, "pts": 67},
    {"pos": 6, "club": "Blue Lightning", "w": 19, "d": 9, "l": 6, "pts": 66},
    {"pos": 7, "club": "White Clouds", "w": 17, "d": 11, "l": 6, "pts": 62},
    {"pos": 8, "club": "Yellow Submarine", "w": 17, "d": 11, "l": 6, "pts": 58},
    {"pos": 9, "club": "Sharks", "w": 16, "d": 12, "l": 6, "pts": 56},
    {"pos": 10, "club": "King's Team", "w": 15, "d": 12, "l": 7, "pts": 55},
    {"pos": 11, "club": "Fast Cowboys", "w": 15, "d": 3, "l": 16, "pts": 52},
    {"pos": 12, "club": "Green Lentils", "w": 14, "d": 7, "l": 13, "pts": 49},
    {"pos": 13, "club": "Black Eagles", "w": 14, "d": 5, "l": 15, "pts": 47},
    {"pos": 14, "club": "Red Clove", "w": 14, "d": 1, "l": 19, "pts": 42},
    {"pos": 15, "club": "Wild", "w": 0, "d": 0, "l": 34, "pts": 0},
    {"pos": 16, "club": "Snakes", "w": 0, "d": 0, "l": 34, "pts": 0},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Brinca na areia',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          unselectedLabelColor: AppColors.white.withOpacity(.6),
          labelColor: AppColors.white,
          tabs: const [
            Tab(icon: Icon(Icons.sports_soccer), text: 'Detalhes'),
            Tab(icon: Icon(Icons.emoji_events), text: 'Jogos'),
            Tab(icon: Icon(Icons.leaderboard), text: 'Classificação'),
            Tab(icon: Icon(Icons.group), text: 'Equipes'),
            Tab(icon: Icon(Icons.star), text: 'Estatísticas'),
            Tab(icon: Icon(Icons.article), text: 'News'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _contantGame(),
          _buildTabContentMatch(),
          _buildTable(),
          _buildTeamsList(),
          _buildStats(),
          _buildTabContentNews()
        ],
      ),
    );
  }

  Widget _buildStats() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey,
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            tabs: const [
              Tab(
                text: 'Gols',
              ),
              Tab(text: 'Assistências'),
              // Tab(text: 'Defesas'),
              Tab(text: 'Cartões'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildGoalsWidget(),
                _buildAssistsWidget(),
                _buildCardsWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contantGame() {
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
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      color: Colors.black54,
                    ),
                  ),

                  Positioned(
                    bottom: -60, // ajustado para acomodar o tamanho maior
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 70, // aumentado o tamanho do círculo
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 66, // aumentado o tamanho da imagem
                            backgroundImage: NetworkImage(profileUrl),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Text(
                      'Brinca na Areia',
                      style: TextStyle(
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: Colors.grey),
              SizedBox(width: 5),
              Text("Angola, Luanda, Benfica"),
            ],
          ),
          ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: 'Prêmio',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextSpan(
                      text: " (AOA)",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.red),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppIcons.medalChampionAward3,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "200mi",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppIcons.medalChampionAward1,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "1M",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppIcons.medalChampionAward2,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "600mi",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // child: ListTile(
                //   leading: const Icon(Icons.emoji_events, color: Colors.amber),
                //   title: const Text('1000000 \$ - Valor do grande prêmio'),
                // ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: SvgPicture.asset(
                  AppIcons.money,
                  width: 40,
                ),
                title: const Text('Taxa de registro'),
                subtitle: const Text('10 \$'),
              ),
              const Divider(height: 32),
              Text(
                'Informações',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: SvgPicture.asset(
                  AppIcons.userColor,
                  width: 26,
                ),
                title: Text(
                  'Organizador da competição',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  'Nome do organizador aqui',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  AppIcons.calendarColor,
                  width: 26,
                ),
                title: Text(
                  'Duração do torneio',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  '17 abr 2025 - 17 abr 2025',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  AppIcons.category2,
                  width: 26,
                ),
                title: Text(
                  'Categoria',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  'Torneio local',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  AppIcons.locationIndicatorRed,
                  width: 26,
                ),
                title: Text(
                  'Pitch localização',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  'CXCXCXCXCX CXC',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  AppIcons.ballOfWoolSewing,
                  width: 26,
                ),
                title: Text(
                  'Tipo de competição',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  'Liga',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  AppIcons.gendersGender,
                  width: 26,
                ),
                title: Text(
                  'Tipo de jogadores',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  'Homens',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  AppIcons.footballJersey,
                  width: 26,
                ),
                title: Text(
                  'Tipo de jogo',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  '7x7',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          // const SizedBox(height: 25),
          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(10),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.black.withOpacity(0.1),
          //         blurRadius: 8,
          //         offset: const Offset(0, 10),
          //       ),
          //     ],
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Expanded(
          //         child: Container(
          //           padding: const EdgeInsets.all(16),
          //           child: const Column(
          //             children: [
          //               Icon(Icons.calendar_today,
          //                   color: AppColors.primary, size: 30),
          //               SizedBox(height: 10),
          //               Text(
          //                 "Data de Início",
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.black,
          //                 ),
          //               ),
          //               SizedBox(height: 5),
          //               Text(
          //                 "01/01/2023",
          //                 style: TextStyle(
          //                   fontSize: 14,
          //                   color: Colors.grey,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //       // const SizedBox(width: 10),
          //       Expanded(
          //         child: Container(
          //           padding: const EdgeInsets.all(16),
          //           child: const Column(
          //             children: [
          //               Icon(Icons.calendar_month,
          //                   color: AppColors.primary, size: 30),
          //               SizedBox(height: 10),
          //               Text(
          //                 "Data de Fim",
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.black,
          //                 ),
          //               ),
          //               SizedBox(height: 5),
          //               Text(
          //                 "31/12/2023",
          //                 style: TextStyle(
          //                   fontSize: 14,
          //                   color: Colors.grey,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     IconButton(
          //       onPressed: () {},
          //       icon: SvgPicture.asset(
          //         AppIcons.facebook,
          //         width: 30,
          //         height: 30,
          //       ),
          //     ),
          //     const SizedBox(width: 10),
          //     IconButton(
          //       onPressed: () {},
          //       icon: SvgPicture.asset(
          //         AppIcons.instagram,
          //         width: 30,
          //         height: 30,
          //       ),
          //     ),
          //     const SizedBox(width: 10),
          //     IconButton(
          //       onPressed: () {},
          //       icon: SvgPicture.asset(
          //         AppIcons.link,
          //         width: 30,
          //         height: 30,
          //       ),
          //     ),
          //     const SizedBox(width: 10),
          //     IconButton(
          //       onPressed: () {},
          //       icon: SvgPicture.asset(
          //         AppIcons.whatsapp,
          //         width: 30,
          //         height: 30,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 10),
          // GridView.count(
          //   crossAxisCount: 2,
          //   crossAxisSpacing: 10,
          //   mainAxisSpacing: 10,
          //   shrinkWrap: true,
          //   physics: const ClampingScrollPhysics(),
          //   padding: const EdgeInsets.all(16),
          //   children: [
          //     _buildStatCard(
          //       icon: Icons.group,
          //       title: "Equipes",
          //       value: "20",
          //       color: Colors.blue,
          //     ),
          //     _buildStatCard(
          //       icon: Icons.sports_soccer,
          //       title: "Jogos Disputados",
          //       value: "57",
          //       color: Colors.green,
          //     ),
          //     _buildStatCard(
          //       icon: Icons.emoji_events,
          //       title: "Títulos",
          //       value: "5",
          //       color: Colors.orange,
          //     ),
          //     _buildStatCard(
          //       icon: Icons.star,
          //       title: "Jogadores Destaque",
          //       value: "12",
          //       color: Colors.purple,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildTeam(String logoUrl, String name, CrossAxisAlignment align) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Image.network(logoUrl, width: 40, height: 40),
        const SizedBox(height: 8),
        Text(name,
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis),
      ],
    );
  }

  Widget _buildTabContentMatch() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.09),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ValueListenableBuilder<int>(
            valueListenable: partidaAtual,
            builder: (context, value, _) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Botão esquerda
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: value > 1 ? () => partidaAtual.value-- : null,
                    ),
                  ),

                  // Dropdown com estilo
                  Center(
                    child: ValueListenableBuilder<int>(
                      valueListenable: partidaAtual,
                      builder: (context, value, _) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => _showPartidasBottomSheet(context),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 16),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Partida $value / $totalPartidas'),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Botão direita
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: value < totalPartidas
                          ? () => partidaAtual.value++
                          : null,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Expanded(
          // child: ListView.builder(
          //   itemCount: matches.length,
          //   itemBuilder: (context, index) {
          //     final match = matches[index];
          //     return Container(
          //       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(10),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black.withOpacity(0.09),
          //             blurRadius: 12,
          //             offset: const Offset(0, 4),
          //           ),
          //         ],
          //       ),
          //       child: Padding(
          //         padding: const EdgeInsets.all(16),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Container(
          //               padding:
          //                   EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(50),
          //                 color: AppColors.primary.withOpacity(.1),
          //               ),
          //               child: Center(
          //                 child: Text("Primeira Jornada"),
          //               ),
          //             ),
          //             const SizedBox(height: 8),
          //             Row(
          //               children: [
          //                 Expanded(
          //                   child: _buildTeam(
          //                     match.homeLogo,
          //                     match.homeTeam,
          //                     CrossAxisAlignment.start,
          //                   ),
          //                 ),
          //                 Expanded(
          //                   child: Column(
          //                     children: [
          //                       Text(
          //                         '${match.homeScore} - ${match.awayScore}',
          //                         style: const TextStyle(
          //                           fontSize: 24,
          //                           fontWeight: FontWeight.bold,
          //                           color: Colors.black,
          //                         ),
          //                       ),
          //                       Text(
          //                         "${match.minute}'",
          //                         style: const TextStyle(
          //                             fontSize: 16, color: Colors.grey),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 Expanded(
          //                   child: _buildTeam(
          //                     match.awayLogo,
          //                     match.awayTeam,
          //                     CrossAxisAlignment.end,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             const SizedBox(height: 12),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const PlayerHighlightCard(),
              const SizedBox(height: 16),
              const Text(
                "Sem Data Ainda",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              MatchGroupCard(
                team1: "Equipe 2",
                team2: "Equipe 3",
                group: "GRUPO A",
              ),
              MatchGroupCard(
                team1: "Equipe 2",
                team2: "Equipe 3",
                group: "GRUPO A",
              ),
              MatchGroupCard(
                team1: "Equipe 2",
                team2: "Equipe 3",
                group: "GRUPO A",
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showPartidasBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: totalPartidas,
          itemBuilder: (context, index) {
            int num = index + 1;
            return ListTile(
              title: Text('Partida $num / $totalPartidas'),
              onTap: () {
                partidaAtual.value = num;
                Navigator.pop(
                    context); // Fecha o bottom sheet depois de selecionar
              },
            );
          },
        );
      },
    );
  }

  Widget _buildGoalsWidget() {
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.09),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                "https://fpfimagehandler.fpf.pt/FPFImageHandler.ashx?type=Person&id=3883014&op=t&w=325&h=378",
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              'Cristiano Ronaldo',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 20,
                      height: 20,
                      child: CachedNetworkImage(imageUrl: match.homeLogo),
                    ),
                  ),
                  Text("Real Madrid"),
                ],
              ),
            ),
            trailing: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "20 ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: AppStrings.fontFamily),
                  ),
                  TextSpan(
                    text: "Gol.",
                    style: TextStyle(
                        color: Colors.grey, fontFamily: AppStrings.fontFamily),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTeamsList() {
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.09),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                "https://fpfimagehandler.fpf.pt/FPFImageHandler.ashx?type=Person&id=3883014&op=t&w=325&h=378",
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              'Bayern Munich',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 20,
                      height: 20,
                      child: CachedNetworkImage(imageUrl: match.homeLogo),
                    ),
                  ),
                  Text("Real Madrid"),
                ],
              ),
            ),
            trailing: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "20 ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: AppStrings.fontFamily),
                  ),
                  TextSpan(
                    text: "Gol.",
                    style: TextStyle(
                        color: Colors.grey, fontFamily: AppStrings.fontFamily),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAssistsWidget() {
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.09),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                "https://fpfimagehandler.fpf.pt/FPFImageHandler.ashx?type=Person&id=3883014&op=t&w=325&h=378",
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              'Cristiano Ronaldo',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 20,
                      height: 20,
                      child: CachedNetworkImage(imageUrl: match.homeLogo),
                    ),
                  ),
                  Text("Real Madrid"),
                ],
              ),
            ),
            trailing: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "20 ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: AppStrings.fontFamily),
                  ),
                  TextSpan(
                    text: "Ass.",
                    style: TextStyle(
                        color: Colors.grey, fontFamily: AppStrings.fontFamily),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardsWidget() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.09),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png",
                        width: 50,
                        height: 50),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Sergio Ramos",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Column(
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Center(
                              child: Text(
                                "2",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 20,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Center(
                              child: Text(
                                "2",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                width: 30,
                height: 30,
                child: CachedNetworkImage(
                  imageUrl: match.homeLogo,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return Column(
      children: [
        // Header row
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          color: AppColors.primary,
          child: const Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "POS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  "Clube",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "V",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  "E",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  "D",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  "Pts",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        // Table rows
        Expanded(
          child: ListView.builder(
            itemCount: tableData.length,
            itemBuilder: (context, index) {
              final item = tableData[index];
              final isEvenRow = index % 2 == 0;
              return Container(
                color: isEvenRow ? Colors.grey[200] : Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "${item['pos']}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                "https://upload.wikimedia.org/wikipedia/pt/9/98/Real_Madrid.png",
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "${item['club']}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${item['w']}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${item['d']}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${item['l']}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${item['pts']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTabContentNews() {
    return Text("data");
    // return Container(
    //   width: double.infinity,
    //   margin: const EdgeInsets.symmetric(vertical: 8),
    //   child: ListView.separated(
    //     scrollDirection: Axis.vertical,
    //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    //     physics: ClampingScrollPhysics(),
    //     shrinkWrap: true,
    //     itemBuilder: (context, index) {
    //       final newss = NewsArticle.fromJson(news[index]);
    //       return Container(
    //         width: double.infinity,
    //         height: 100,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Container(
    //               width: 80,
    //               height: 100,
    //               child: ClipRRect(
    //                 borderRadius: BorderRadius.circular(10),
    //                 child: CachedNetworkImage(
    //                   imageUrl: newss.imageUrl,
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               width: 10,
    //             ),
    //             Expanded(
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     newss.title,
    //                     overflow: TextOverflow.ellipsis,
    //                     maxLines: 3,
    //                     style: TextStyle(
    //                       fontWeight: FontWeight.w600,
    //                       color: AppColors.black,
    //                     ),
    //                   ),
    //                   Row(
    //                     children: [
    //                       SvgPicture.asset(
    //                         AppIcons.calendar,
    //                         width: 16,
    //                         // color: AppColors.color,
    //                       ),
    //                       const SizedBox(
    //                         width: 5,
    //                       ),
    //                       const Text("10/10/2024 10:10"),
    //                       const SizedBox(
    //                         width: 10,
    //                       ),
    //                       SvgPicture.asset(
    //                         AppIcons.siteAlt,
    //                         width: 16,
    //                         // color: AppColors.color,
    //                       ),
    //                       const SizedBox(
    //                         width: 5,
    //                       ),
    //                       Text(newss.sourceStr),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //     separatorBuilder: (context, index) {
    //       return const SizedBox(
    //         height: 20,
    //       );
    //     },
    //     itemCount: news.length,
    //   ),
    // );
  }
}

class PlayerHighlightCard extends StatelessWidget {
  const PlayerHighlightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: CachedNetworkImageProvider(
                  scale: 2.5,
                  // 'https://lh3.googleusercontent.com/gps-cs-s/AB5caB_xM6ql3O50gDkC8Xzk-VYnE0gDSk5WJKT0n7k_eHjSWh6Bp-u8vsFjjly3bupWhkl5BvJ8xIgpc4WVeNU-KZovlL1YhHIbnYxGS2zKElZLvUa6wG-uKoOwdX_CV0sltZ2yvd3z=s1360-w1360-h1020',
                  // 'https://lh3.googleusercontent.com/gps-cs-s/AB5caB8inwH_KFKJm-45QElqe4RYAnwkGyWXDnPucd-VR3Y4b1rMeOpALAn3gtOjFdI-gYmdSwM1NIU2YdgQ7CI5yBvLfnDOoCVnzpxEK3WUeiUbkbUp8uvP6GPe_mg12WT2_rRJ2ZU=s1360-w1360-h1020'),
                  'https://lh3.googleusercontent.com/gps-cs-s/AB5caB9SGdNVDWSoYrRDpwCW8IC3wcBVfEafWXhfonttQOo1eFw5kDuC1f9PCAa6UzA41L46zEunc4G0DLmyIr_SP-Fj4CGltLmWLcCmbk7U2g0kljLeMUVKiiGj3T2Tu2U0LSPhz1Ne=s1360-w1360-h1020'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'NOVO',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.emoji_events, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'Jogador da semana 1',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MatchGroupCard extends StatelessWidget {
  final String team1;
  final String team2;
  final String group;

  const MatchGroupCard({
    super.key,
    required this.team1,
    required this.team2,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(.04),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: Colors.black12,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TeamRowHome(name: team1),
                    const SizedBox(height: 8),
                    TeamRowAway(name: team2),
                  ],
                ),
                Row(
                  children: [
                    const Column(
                      children: [
                        Text("-", style: TextStyle(fontSize: 18)),
                        SizedBox(height: 8),
                        Text("-", style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(width: 15),
                    SvgPicture.asset(
                      AppIcons.fileEdit,
                      color: Colors.blue.shade900,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 0, top: 4, bottom: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              group,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TeamRowHome extends StatelessWidget {
  final String name;

  const TeamRowHome({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppIcons.security),
        const SizedBox(width: 8),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class TeamRowAway extends StatelessWidget {
  final String name;

  const TeamRowAway({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppIcons.security),
        const SizedBox(width: 8),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class MatchModel {
  final String homeTeam;
  final String awayTeam;
  final int homeScore;
  final int awayScore;
  final int minute;
  final double homePossession; // 0.0 to 1.0
  final String homeLogo;
  final String awayLogo;

  MatchModel({
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    required this.minute,
    required this.homePossession,
    required this.homeLogo,
    required this.awayLogo,
  });
}

final List<Map<String, dynamic>> jsonData = [
  {
    "id": 42,
    "name": "Champions League",
    "localizedName": "Champions League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/42.png"
  },
  {
    "id": 73,
    "name": "Europa League",
    "localizedName": "Europa League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/73.png"
  },
  {
    "id": 9470,
    "name": "AFC Challenge League",
    "localizedName": "AFC Challenge League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9470.png"
  },
  {
    "id": 525,
    "name": "AFC Champions League Elite",
    "localizedName": "AFC Champions League Elite",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/525.png"
  },
  {
    "id": 10622,
    "name": "AFC Champions League Elite Qualification",
    "localizedName": "AFC Champions League Elite Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10622.png"
  },
  {
    "id": 9469,
    "name": "AFC Champions League Two",
    "localizedName": "AFC Champions League Two",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9469.png"
  },
  {
    "id": 10511,
    "name": "AFC Summer Olympics Qualification (Women)",
    "localizedName": "AFC Summer Olympics Qualification (Women)",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10511.png"
  },
  {
    "id": 9841,
    "name": "AFC U20 Asian Cup",
    "localizedName": "AFC U20 Asian Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9841.png"
  },
  {
    "id": 9265,
    "name": "AFF Championship",
    "localizedName": "AFF Championship",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9265.png"
  },
  {
    "id": 289,
    "name": "Africa Cup of Nations",
    "localizedName": "Africa Cup of Nations",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/289.png"
  },
  {
    "id": 10608,
    "name": "Africa Cup of Nations Qualification",
    "localizedName": "Africa Cup of Nations Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10608.png"
  },
  {
    "id": 10508,
    "name": "African Football League",
    "localizedName": "African Football League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10508.png"
  },
  {
    "id": 9428,
    "name": "African Nations Championship",
    "localizedName": "African Nations Championship",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9428.png"
  },
  {
    "id": 9579,
    "name": "Algarve Cup (W)",
    "localizedName": "Algarve Cup (W)",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9579.png"
  },
  {
    "id": 10474,
    "name": "Arab Club Champions Cup",
    "localizedName": "Arab Club Champions Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10474.png"
  },
  {
    "id": 290,
    "name": "Asian Cup",
    "localizedName": "Asian Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/290.png"
  },
  {
    "id": 10609,
    "name": "Asian Cup  Qualification Playoff",
    "localizedName": "Asian Cup  Qualification Playoff",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10609.png"
  },
  {
    "id": 9833,
    "name": "Asian Games",
    "localizedName": "Asian Games",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9833.png"
  },
  {
    "id": 10656,
    "name": "Beta Squad vs Amp Charity",
    "localizedName": "Beta Squad vs Amp Charity",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10656.png"
  },
  {
    "id": 526,
    "name": "CAF Champions League",
    "localizedName": "CAF Champions League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/526.png"
  },
  {
    "id": 10619,
    "name": "CAF Champions League Qualification",
    "localizedName": "CAF Champions League Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10619.png"
  },
  {
    "id": 9468,
    "name": "CAF Confed Cup",
    "localizedName": "CAF Confed Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9468.png"
  },
  {
    "id": 9467,
    "name": "CAF Super Cup",
    "localizedName": "CAF Super Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9467.png"
  },
  {
    "id": 9875,
    "name": "Campeones Cup",
    "localizedName": "Campeones Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9875.png"
  },
  {
    "id": 10611,
    "name": "Champions League Qualification",
    "localizedName": "Champions League Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10611.png"
  },
  {
    "id": 489,
    "name": "Club Friendlies",
    "localizedName": "Club Friendlies",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/489.png"
  },
  {
    "id": 9682,
    "name": "CONCACAF Central American Cup",
    "localizedName": "CONCACAF Central American Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9682.png"
  },
  {
    "id": 297,
    "name": "CONCACAF Champions Cup",
    "localizedName": "CONCACAF Champions Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/297.png"
  },
  {
    "id": 9656,
    "name": "CONCACAF Championship U20",
    "localizedName": "CONCACAF Championship U20",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9656.png"
  },
  {
    "id": 10621,
    "name": "CONCACAF Championship U20 Qualification",
    "localizedName": "CONCACAF Championship U20 Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10621.png"
  },
  {
    "id": 298,
    "name": "CONCACAF Gold Cup",
    "localizedName": "CONCACAF Gold Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/298.png"
  },
  {
    "id": 10603,
    "name": "CONCACAF Gold Cup Women",
    "localizedName": "CONCACAF Gold Cup Women",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10603.png"
  },
  {
    "id": 9821,
    "name": "CONCACAF Nations League",
    "localizedName": "CONCACAF Nations League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9821.png"
  },
  {
    "id": 10216,
    "name": "Conference League",
    "localizedName": "Conference League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10216.png"
  },
  {
    "id": 10615,
    "name": "Conference League Qualification",
    "localizedName": "Conference League Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10615.png"
  },
  {
    "id": 44,
    "name": "Copa America",
    "localizedName": "Copa America",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/44.png"
  },
  {
    "id": 10368,
    "name": "Copa America Femenina",
    "localizedName": "Copa America Femenina",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10368.png"
  },
  {
    "id": 45,
    "name": "Copa Libertadores",
    "localizedName": "Copa Libertadores",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/45.png"
  },
  {
    "id": 10618,
    "name": "Copa Libertadores Qualification",
    "localizedName": "Copa Libertadores Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10618.png"
  },
  {
    "id": 299,
    "name": "Copa Sudamericana",
    "localizedName": "Copa Sudamericana",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/299.png"
  },
  {
    "id": 10623,
    "name": "Copa Sudamericana Qualification",
    "localizedName": "Copa Sudamericana Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10623.png"
  },
  {
    "id": 300,
    "name": "East Asian Championship",
    "localizedName": "East Asian Championship",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/300.png"
  },
  {
    "id": 50,
    "name": "EURO",
    "localizedName": "EURO",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/50.png"
  },
  {
    "id": 10607,
    "name": "EURO Qualification",
    "localizedName": "EURO Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10607.png"
  },
  {
    "id": 287,
    "name": "EURO U19",
    "localizedName": "EURO U19",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/287.png"
  },
  {
    "id": 288,
    "name": "EURO U21",
    "localizedName": "EURO U21",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/288.png"
  },
  {
    "id": 10437,
    "name": "EURO U-21 Qualification",
    "localizedName": "EURO U-21 Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10437.png"
  },
  {
    "id": 10613,
    "name": "Europa League Qualification",
    "localizedName": "Europa League Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10613.png"
  },
  {
    "id": 301,
    "name": "European Championship U-17",
    "localizedName": "European Championship U-17",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/301.png"
  },
  {
    "id": 78,
    "name": "FIFA Club World Cup",
    "localizedName": "FIFA Club World Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/78.png"
  },
  {
    "id": 10703,
    "name": "FIFA Intercontinental Cup",
    "localizedName": "FIFA Intercontinental Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10703.png"
  },
  {
    "id": 10304,
    "name": "Finalissima",
    "localizedName": "Finalissima",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10304.png"
  },
  {
    "id": 114,
    "name": "Friendlies",
    "localizedName": "Friendlies",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/114.png"
  },
  {
    "id": 344,
    "name": "Friendlies U-21",
    "localizedName": "Friendlies U-21",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/344.png"
  },
  {
    "id": 329,
    "name": "Gulf Cup",
    "localizedName": "Gulf Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/329.png"
  },
  {
    "id": 10043,
    "name": "Leagues Cup",
    "localizedName": "Leagues Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10043.png"
  },
  {
    "id": 10649,
    "name": "NWSL x Liga MX",
    "localizedName": "NWSL x Liga MX",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10649.png"
  },
  {
    "id": 491,
    "name": "Recopa Sudamericana",
    "localizedName": "Recopa Sudamericana",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/491.png"
  },
  {
    "id": 9876,
    "name": "SAFF Championship",
    "localizedName": "SAFF Championship",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9876.png"
  },
  {
    "id": 9921,
    "name": "SheBelieves Cup (W)",
    "localizedName": "SheBelieves Cup (W)",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9921.png"
  },
  {
    "id": 10312,
    "name": "Sidemen Charity Match",
    "localizedName": "Sidemen Charity Match",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10312.png"
  },
  {
    "id": 9690,
    "name": "Southeast Asian Games",
    "localizedName": "Southeast Asian Games",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9690.png"
  },
  {
    "id": 66,
    "name": "Summer Olympics",
    "localizedName": "Summer Olympics",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/66.png"
  },
  {
    "id": 65,
    "name": "Summer Olympics (Women)",
    "localizedName": "Summer Olympics (Women)",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/65.png"
  },
  {
    "id": 10498,
    "name": "Summer Olympics Qualification CONCACAF (W)",
    "localizedName": "Summer Olympics Qualification CONCACAF (W)",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10498.png"
  },
  {
    "id": 9514,
    "name": "The Atlantic Cup",
    "localizedName": "The Atlantic Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9514.png"
  },
  {
    "id": 305,
    "name": "Toulon Tournament",
    "localizedName": "Toulon Tournament",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/305.png"
  },
  {
    "id": 9806,
    "name": "UEFA Nations League A",
    "localizedName": "UEFA Nations League A",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9806.png"
  },
  {
    "id": 10557,
    "name": "UEFA Nations League A Qualification",
    "localizedName": "UEFA Nations League A Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10557.png"
  },
  {
    "id": 10717,
    "name": "UEFA Nations League A Qualification",
    "localizedName": "UEFA Nations League A Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10717.png"
  },
  {
    "id": 9807,
    "name": "UEFA Nations League B",
    "localizedName": "UEFA Nations League B",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9807.png"
  },
  {
    "id": 10558,
    "name": "UEFA Nations League B Qualification",
    "localizedName": "UEFA Nations League B Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10558.png"
  },
  {
    "id": 10718,
    "name": "UEFA Nations League B Qualification",
    "localizedName": "UEFA Nations League B Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10718.png"
  },
  {
    "id": 10458,
    "name": "UEFA Nations League B Women",
    "localizedName": "UEFA Nations League B Women",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10458.png"
  },
  {
    "id": 9808,
    "name": "UEFA Nations League C",
    "localizedName": "UEFA Nations League C",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9808.png"
  },
  {
    "id": 10719,
    "name": "UEFA Nations League C Qualification",
    "localizedName": "UEFA Nations League C Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10719.png"
  },
  {
    "id": 10459,
    "name": "UEFA Nations League C Women",
    "localizedName": "UEFA Nations League C Women",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10459.png"
  },
  {
    "id": 9809,
    "name": "UEFA Nations League D",
    "localizedName": "UEFA Nations League D",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9809.png"
  },
  {
    "id": 74,
    "name": "UEFA Super Cup",
    "localizedName": "UEFA Super Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/74.png"
  },
  {
    "id": 10457,
    "name": "UEFA Women's Nations League",
    "localizedName": "UEFA Women's Nations League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10457.png"
  },
  {
    "id": 9741,
    "name": "UEFA Youth League",
    "localizedName": "UEFA Youth League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9741.png"
  },
  {
    "id": 10269,
    "name": "Womens Asian Cup",
    "localizedName": "Womens Asian Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10269.png"
  },
  {
    "id": 9375,
    "name": "Women's Champions League",
    "localizedName": "Women's Champions League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9375.png"
  },
  {
    "id": 10612,
    "name": "Women's Champions League Qualification",
    "localizedName": "Women's Champions League Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10612.png"
  },
  {
    "id": 292,
    "name": "Women's EURO Qualification",
    "localizedName": "Women's EURO Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/292.png"
  },
  {
    "id": 10640,
    "name": "Women's EURO Qualification League A",
    "localizedName": "Women's EURO Qualification League A",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10640.png"
  },
  {
    "id": 10641,
    "name": "Women's EURO Qualification League B",
    "localizedName": "Women's EURO Qualification League B",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10641.png"
  },
  {
    "id": 10642,
    "name": "Women's EURO Qualification League C",
    "localizedName": "Women's EURO Qualification League C",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10642.png"
  },
  {
    "id": 293,
    "name": "Women's Friendlies",
    "localizedName": "Women's Friendlies",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/293.png"
  },
  {
    "id": 76,
    "name": "Women's World Cup",
    "localizedName": "Women's World Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/76.png"
  },
  {
    "id": 77,
    "name": "World Cup",
    "localizedName": "FIFA World Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/77.png"
  },
  {
    "id": 10358,
    "name": "World Cup Qualification (W) CONCAFAF",
    "localizedName": "World Cup Qualification (W) CONCAFAF",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10358.png"
  },
  {
    "id": 10359,
    "name": "World Cup Qualification (W) Inter-Confederation",
    "localizedName": "World Cup Qualification (W) Inter-Confederation",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10359.png"
  },
  {
    "id": 10357,
    "name": "World Cup Qualification (W) UEFA",
    "localizedName": "World Cup Qualification (W) UEFA",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10357.png"
  },
  {
    "id": 10197,
    "name": "World Cup Qualification AFC",
    "localizedName": "World Cup Qualification AFC",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10197.png"
  },
  {
    "id": 10196,
    "name": "World Cup Qualification CAF",
    "localizedName": "World Cup Qualification CAF",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10196.png"
  },
  {
    "id": 10198,
    "name": "World Cup Qualification CONCACAF",
    "localizedName": "World Cup Qualification CONCACAF",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10198.png"
  },
  {
    "id": 10199,
    "name": "World Cup Qualification CONMEBOL",
    "localizedName": "World Cup Qualification CONMEBOL",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10199.png"
  },
  {
    "id": 10201,
    "name": "World Cup Qualification Inter-confederation",
    "localizedName": "World Cup Qualification Inter-confederation",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10201.png"
  },
  {
    "id": 10200,
    "name": "World Cup Qualification OFC",
    "localizedName": "World Cup Qualification OFC",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10200.png"
  },
  {
    "id": 10195,
    "name": "World Cup Qualification UEFA",
    "localizedName": "World Cup Qualification UEFA",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10195.png"
  },
  {
    "id": 306,
    "name": "World Cup U17",
    "localizedName": "World Cup U17",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/306.png"
  },
  {
    "id": 296,
    "name": "World Cup U20",
    "localizedName": "World Cup U20",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/296.png"
  }
];

final List<Map<String, dynamic>> news = [
  {
    "id": "ftbpro_01jfsmx4v7m4",
    "imageUrl":
        "https://images2.minutemediacdn.com/image/upload/c_crop,w_1915,h_1077,x_0,y_0/c_fill,w_912,h_516,f_auto,q_auto,g_auto/images/voltaxMediaLibrary/mmsport/90min_en_international_web/01jfsph4p9nxp3xdwzvy.jpg",
    "title":
        "Gary Neville: Why Man Utd's crushing loss to Bournemouth is 'massive positive' for Ruben Amorim",
    "gmtTime": "2024-12-23T13:00:00.000Z",
    "sourceStr": "90min",
    "sourceIconUrl": null,
    "page": {
      "url":
          "/embed/news/01jfsmx4v7m4/gary-neville-why-man-utds-crushing-loss-bournemouth-is-massive-positive-ruben-amorim"
    }
  },
  {
    "id": "ftbpro_01jfsrbs4wca",
    "imageUrl":
        "https://images2.minutemediacdn.com/image/upload/c_crop,w_3000,h_1687,x_0,y_153/c_fill,w_912,h_516,f_auto,q_auto,g_auto/images/GettyImages/mmsport/90min_en_international_web/01jfsrjsjxw962dwp8xp.jpg",
    "title":
        "Former Man Utd coach explains why Erik ten Hag overlooked Amad Diallo",
    "gmtTime": "2024-12-23T13:30:00.000Z",
    "sourceStr": "90min",
    "sourceIconUrl": null,
    "page": {
      "url":
          "/embed/news/01jfsrbs4wca/former-man-utd-coach-explains-why-erik-ten-hag-overlooked-amad-diallo"
    }
  },
  {
    "id": "ftbpro_01jfsha0v0m9",
    "imageUrl":
        "https://images2.minutemediacdn.com/image/upload/c_crop,w_1707,h_960,x_0,y_189/c_fill,w_912,h_516,f_auto,q_auto,g_auto/images/GettyImages/mmsport/90min_en_international_web/01jfshh5s4f6yt5p6vrf.jpg",
    "title": "Mohamed Salah provides short update on Liverpool contract saga",
    "gmtTime": "2024-12-23T12:00:02.000Z",
    "sourceStr": "90min",
    "sourceIconUrl": null,
    "page": {
      "url":
          "/embed/news/01jfsha0v0m9/mohamed-salah-provides-short-update-liverpool-contract-saga"
    }
  },
  {
    "id": "ftbpro_01jfsehnv9gm",
    "imageUrl":
        "https://images2.minutemediacdn.com/image/upload/c_crop,w_4000,h_2250,x_0,y_129/c_fill,w_912,h_516,f_auto,q_auto,g_auto/images/GettyImages/mmsport/90min_en_international_web/01jfsfhwbtts6czr0wqw.jpg",
    "title": "Barcelona take drastic measure to register Dani Olmo",
    "gmtTime": "2024-12-23T11:00:00.000Z",
    "sourceStr": "90min",
    "sourceIconUrl": null,
    "page": {
      "url":
          "/embed/news/01jfsehnv9gm/barcelona-take-drastic-measure-register-dani-olmo"
    }
  },
  {
    "id": "ftbpro_01jfspgcwry8",
    "imageUrl":
        "https://images2.minutemediacdn.com/image/upload/c_crop,w_3500,h_1968,x_0,y_115/c_fill,w_912,h_516,f_auto,q_auto,g_auto/images/GettyImages/mmsport/90min_en_international_web/01jfsq08z80ncj2h2vf8.jpg",
    "title":
        "Arne Slot sounds Liverpool warning while reacting to Chelsea draw",
    "gmtTime": "2024-12-23T14:00:01.000Z",
    "sourceStr": "90min",
    "sourceIconUrl": null,
    "page": {
      "url":
          "/embed/news/01jfspgcwry8/arne-slot-sounds-liverpool-warning-while-reacting-chelsea-draw"
    }
  }
];
