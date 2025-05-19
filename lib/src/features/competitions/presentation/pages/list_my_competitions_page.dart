import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luanda_sport_app/src/config/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_icons.dart';

class ListMyCompetitionsPage extends StatelessWidget {
  const ListMyCompetitionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Minhas Competições"),
      ),
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  Container(
                    color: AppColors.primary,
                    child: TabBar(
                      labelColor: AppColors.white,
                      unselectedLabelColor: Colors.white60,
                      indicatorColor: AppColors.white,
                      isScrollable: true,
                      padding: EdgeInsets.zero,
                      tabAlignment: TabAlignment.center,
                      tabs: [
                        const Tab(text: "Todos"),
                        Tab(
                          child: Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.red,
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
                              const SizedBox(
                                width: 6,
                              ),
                              const Text("Notificações"),
                            ],
                          ),
                        ),
                        Tab(text: "Rascunho"),
                        Tab(text: "Mídia"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildAllCompetitions(),
                        Center(child: Text("Torneios ativos")),
                        Center(child: Text("Torneios encerrados")),
                        Center(child: Text("Torneios favoritos")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllCompetitions() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: 10, // Replace with the actual number of competitions
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Get.offAndToNamed(AppRoutes.luandaSport, arguments: 0);
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
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
                    'Brinca na Areia',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.marker,
                          width: 16,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Angola, Luanda, Luanda"),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        AppIcons.link,
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        // Add share functionality here
                      },
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        AppIcons.facebook,
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        // Add Facebook share functionality here
                      },
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        AppIcons.whatsapp,
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        // Add WhatsApp share functionality here
                      },
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        AppIcons.instagram,
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        // Add copy link functionality here
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '12',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Equipes',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '8',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Jogos',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '24',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Golos',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.calendar,
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Início: 01/01/2023",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.calendarBold,
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Término: 31/12/2023",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
