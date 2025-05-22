import 'package:flutter/material.dart';

class PlayerTeamDropdownSkeleton extends StatelessWidget {
  const PlayerTeamDropdownSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 15,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
