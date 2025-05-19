import 'package:flutter/material.dart';
import 'package:luanda_sport_app/src/features/communities/presentation/pages/community_chat_page.dart';
import 'package:get/get.dart';

class Community {
  final String id;
  final String name;
  final String imageUrl;
  final int members;

  Community({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.members,
  });
}

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  // Simulando dados locais
  List<Community> get userCommunities => [
        Community(
          id: '1',
          name: 'Benfica Oficial',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/pt/4/4b/SL_Benfica_logo.svg',
          members: 32000,
        ),
        Community(
          id: '2',
          name: 'Torcida Jovem Angola',
          imageUrl: 'https://cdn-icons-png.flaticon.com/512/847/847969.png',
          members: 1240,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: userCommunities.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final community = userCommunities[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(community.imageUrl),
            ),
            title: Text(
              community.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              '${community.members} membros',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Get.to(
                CommunityChatPage(communityName: "Adeptos do Real Madrid"),
              );
            },
          );
        },
      ),
    );
  }
}
