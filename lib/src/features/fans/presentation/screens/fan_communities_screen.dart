import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FanComunidadesScreen extends StatefulWidget {
  const FanComunidadesScreen({super.key});

  @override
  State<FanComunidadesScreen> createState() => _FanComunidadesScreenState();
}

class _FanComunidadesScreenState extends State<FanComunidadesScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildCommunityTile(
          name: 'Fã Clube Petro de Luanda',
          imageUrl:
              'https://template.canva.com/EAGKu-hsYTQ/1/0/1600w-7mhFVtg5C6I.jpg',
          lastMessage: 'Boa sorte no próximo jogo!',
          messageTime: 'Hoje • 10:45',
        ),
        _buildCommunityTile(
          name: 'Clack de Benguela',
          imageUrl:
              'https://template.canva.com/EAF65EWbuV0/5/0/1600w-U8nr-F4C1Ys.jpg',
          lastMessage: 'Treino às 18h na quadra.',
          messageTime: 'Ontem • 21:13',
        ),
      ],
    );
  }

  Widget _buildCommunityTile({
    required String name,
    required String imageUrl,
    required String lastMessage,
    required String messageTime,
  }) {
    return ListTile(
      leading: ClipOval(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(name),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            messageTime,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      onTap: () {
        // Ação ao tocar na comunidade
      },
    );
  }
}
