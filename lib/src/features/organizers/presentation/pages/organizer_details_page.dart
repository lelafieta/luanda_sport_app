import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:luanda_sport_app/src/config/routes/app_routes.dart';
import 'package:luanda_sport_app/src/core/strings/app_strings.dart';

import '../../../../config/themes/app_colors.dart';

class OrganizerDetailsPage extends StatefulWidget {
  const OrganizerDetailsPage({super.key});

  @override
  State<OrganizerDetailsPage> createState() => _OrganizerDetailsPageState();
}

class _OrganizerDetailsPageState extends State<OrganizerDetailsPage> {
  final String backgroundUrl =
      'https://scontent.flad5-1.fna.fbcdn.net/v/t39.30808-6/481972096_1207928134015658_4427683262273356979_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=zV_8X74IuyoQ7kNvwFNQ4ob&_nc_oc=AdkuSLXzaRPCkaG4Rk49w94sTBmd8Fhxnz2QazxYg2iIpuENHNFuCjDX0VJn-DIsKu_tpPTIOY-QLCN9VE_o77Vv&_nc_zt=23&_nc_ht=scontent.flad5-1.fna&_nc_gid=6g5SEc_mHR1ryf38jcOikw&oh=00_AfHwiN08xuDHuwgUxbjxBUvvfo7y6kwFlL6d0wj-XXV6kA&oe=68047308';
  final String profileUrl =
      'https://scontent.flad5-1.fna.fbcdn.net/v/t39.30808-6/468946321_1143394810468991_6731165110528390324_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=wSrOeJxvDDEQ7kNvwEbvT6L&_nc_oc=AdlTqHYlCPFGfrAGQlDwBDoWGWHzOtYBQvPLz5DFEahZRV2c0WoBBuSIrcQrBKYO_91fpJuk6Y9c1v6oU_Uldije&_nc_zt=23&_nc_ht=scontent.flad5-1.fna&_nc_gid=bu1cwd0CKmhmqZJFsKvxIg&oh=00_AfHS3wRkCA00310Cb6BF1t2f-b46KjsWZzhIrcgxTejGig&oe=68048141';
  final String team1Logo =
      'https://scontent.flad5-1.fna.fbcdn.net/v/t39.30808-1/449761244_1062646795218211_4139834764378388664_n.jpg?stp=c196.196.1199.1199a_dst-jpg_s200x200_tt6&_nc_cat=1&ccb=1-7&_nc_sid=2d3e12&_nc_ohc=2PIv9d0zbT4Q7kNvwFrDdyl&_nc_oc=Adnbea-uBG6-Yjz-swaIok52lxeGLlxbFYlST90cK4dm1KdQveMu-MleJfCBBy4zbgL6PbCyY77uA-Jx-87CXmsf&_nc_zt=24&_nc_ht=scontent.flad5-1.fna&_nc_gid=b_6-6aTZFayQsgqhCcyxhQ&oh=00_AfE78XoqOuYLsaL3vLfGnPlltyuw8ZA_dK-vkLTcnXYkEA&oe=68047744';
  final String team2Logo =
      'https://scontent.flad5-1.fna.fbcdn.net/v/t39.30808-1/273144602_10152602977424953_1955203260619408476_n.jpg?stp=dst-jpg_s200x200_tt6&_nc_cat=1&ccb=1-7&_nc_sid=2d3e12&_nc_ohc=q-W_7Ofx0GIQ7kNvwGEJVrU&_nc_oc=Adnh-RBMtZE6Kr9ubdATmRiKH6NAEiVO92HwxQXcJXb10vyt6hqv1nhkO14Pimi4X05KqocWeD2Q83HP7vsW3Xw6&_nc_zt=24&_nc_ht=scontent.flad5-1.fna&_nc_gid=tINtmFSQ5O2qx6UrzJ1Xjg&oh=00_AfFWaHkb26Gz6qnHdeiku917wrHIZY8eRqAgYFACd31o-Q&oe=68047B4B';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
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
                      left: 16,
                      top: 10,
                      child: SafeArea(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            padding: const EdgeInsets.all(8.0),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: AppColors.black,
                            ),
                            onPressed: () {
                              // Navigator.of(context).pop();
                            },
                          ),
                        ),
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
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(Icons.verified,
                                  color: Colors.blue, size: 22),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                    height: 70), // ajustado para o novo tamanho do escudo
                // Nome do time + selo de verificação
                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Text(
                        'Fieta Organizador',
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
                SizedBox(height: 4),
                // Informações adicionais
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: AppStrings.fontFamily,
                    ),
                    children: [
                      TextSpan(
                        text: '3,1 M',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' Torneios • ',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      TextSpan(
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
            const SizedBox(height: 10),
            const TabBar(
              labelColor: Color(0xFF04764E),
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: 'Torneios'),
                Tab(text: 'Notícias'),
                // Tab(text: 'Squad'),
                // Tab(text: 'Matches'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildOverview(team1Logo, team2Logo),
                  const Center(child: Text('Table Content')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOverview(String team1, String team2) {
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            width: 40,
            height: 40,
            child: CachedNetworkImage(
              imageUrl: team2Logo,
            ),
          ),
          title: const Text(
            'Campeonado das escolas',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          subtitle: Text('Aqui vai alguma descrição sobre o campeonato'),
          // trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.competionDetails);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.black12,
        );
      },
    );
  }

  Widget _buildTeamColumn(String imageUrl, String name) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          height: 40,
          width: 40,
        ),
        const SizedBox(height: 5),
        Text(name),
      ],
    );
  }
}
