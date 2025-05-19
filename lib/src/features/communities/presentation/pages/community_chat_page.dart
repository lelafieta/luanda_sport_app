import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

import '../../../../config/themes/app_colors.dart';

class CommunityChatPage extends StatelessWidget {
  final String communityName;

  const CommunityChatPage({super.key, required this.communityName});

  @override
  Widget build(BuildContext context) {
    final messages = [
      {'text': 'Bem-vindo à comunidade $communityName!', 'isSender': false},
      {'text': 'Obrigado! Feliz por estar aqui.', 'isSender': true},
      {'text': 'Estamos organizando um torneio este mês!', 'isSender': false},
      {'text': 'Sério? Estou dentro!', 'isSender': true},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(communityName),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return msg['isSender'] == true
                    ? BubbleNormal(
                        text: msg['text'].toString(),
                        isSender: true,
                        color: AppColors.primary,
                        tail: true,
                        textStyle: const TextStyle(color: Colors.white),
                      )
                    : BubbleNormal(
                        text: msg['text'].toString(),
                        isSender: false,
                        color: Colors.grey[300]!,
                        tail: true,
                        textStyle: const TextStyle(color: Colors.black87),
                      );
              },
            ),
          ),
          MessageBar(
            onSend: (_) {
              // Aqui você pode adicionar lógica para enviar mensagem
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mensagem enviada!')),
              );
            },
          ),
        ],
      ),
    );
  }
}
