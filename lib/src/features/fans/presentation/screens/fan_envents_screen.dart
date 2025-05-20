import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/resources/app_icons.dart';

class FanEventsScreen extends StatefulWidget {
  const FanEventsScreen({super.key});

  @override
  State<FanEventsScreen> createState() => _FanEventsScreenState();
}

class _FanEventsScreenState extends State<FanEventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            leading: ClipOval(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CachedNetworkImage(
                  imageUrl:
                      'https://template.canva.com/EAGKu-hsYTQ/1/0/1600w-7mhFVtg5C6I.jpg',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            title: const Text('Torneio Tic Tok'),
            subtitle: Row(
              children: [
                // SvgPicture.asset(
                //   AppIcons.marker,
                //   color: Colors.grey,
                //   width: 15,
                // ),
                const SizedBox(width: 5),
                const Text('3 Competições'),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            leading: ClipOval(
              child: Container(
                width: 50,
                height: 50,
                child: CachedNetworkImage(
                  imageUrl:
                      'https://template.canva.com/EAF65EWbuV0/5/0/1600w-U8nr-F4C1Ys.jpg',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            title: Text('Brinca na Aréia'),
            subtitle: Row(
              children: [
                // SvgPicture.asset(
                //   AppIcons.marker,
                //   color: Colors.grey,
                //   width: 15,
                // ),
                const SizedBox(width: 5),
                Text('2 Competições'),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
