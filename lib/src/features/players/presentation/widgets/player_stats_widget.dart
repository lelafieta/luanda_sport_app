import 'package:cached_network_image/cached_network_image.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luanda_sport_app/src/core/resources/app_icons.dart';

import '../../../../config/themes/app_colors.dart';
import 'my_profile_widget.dart';

class PlayerStatsWidget extends StatefulWidget {
  const PlayerStatsWidget({super.key});

  @override
  State<PlayerStatsWidget> createState() => _PlayerStatsWidgetState();
}

class _PlayerStatsWidgetState extends State<PlayerStatsWidget> {
  final dropDownKey = GlobalKey<DropdownSearchState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          DropdownSearch<String>(
            key: dropDownKey,
            selectedItem: "Menu",
            items: const [
              "Menu",
              "Dialog",
              "Modal",
              "BottomSheet",
              "Dialog",
            ],
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            popupProps: PopupProps.dialog(
              showSearchBox: false,
              title: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Center(
                  child: Text(
                    "Equipes de Passagem",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              itemBuilder: (context, item, isSelected) {
                return ListTile(
                  leading: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://template.canva.com/EAGP4Vom1pY/1/0/1600w-IOa8p4GmFqQ.jpg',
                      width: 40,
                      height: 40,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text("Dourada FC"),
                  subtitle: const Text('Subtitle'),
                  selected: isSelected,
                );
              },
              dialogProps: const DialogProps(
                  // Removido shape e backgroundColor para herdar o padrão do sistema
                  // Isso usa a borda padrão do sistema automaticamente
                  ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: SvgPicture.asset(
                    AppIcons.footballBall,
                    width: 25,
                  ),
                  title: const Text('Gols'),
                  trailing: const Text(
                    '12',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: SvgPicture.asset(
                    AppIcons.footballShoesShoe,
                    width: 25,
                  ),
                  title: const Text('Assistências'),
                  trailing: const Text(
                    '5',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: SvgPicture.asset(
                    AppIcons.footballJersey,
                    width: 25,
                  ),
                  title: const Text('Partidas'),
                  trailing: const Text(
                    '21',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const Text('Derrotas'),
                            const SizedBox(height: 10),
                            SvgPicture.asset(
                              AppIcons.cross,
                              width: 25,
                              color: Colors.red.shade600,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '2',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const Text('Victórias'),
                            const SizedBox(height: 10),
                            SvgPicture.asset(
                              AppIcons.medal,
                              width: 25,
                              color: Colors.green.shade600,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '6',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const Text('Empates'),
                            const SizedBox(height: 10),
                            SvgPicture.asset(
                              AppIcons.minus,
                              width: 25,
                              color: Colors.orange.shade600,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '3',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Amarelos',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            SvgPicture.asset(
                              AppIcons.yellowSquare,
                              width: 25,
                              // color: Colors.yellow.shade600,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '2',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Vermelhos',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            SvgPicture.asset(
                              AppIcons.redSquare,
                              width: 25,
                              // color: Colors.yellow.shade600,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '0',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }
}
