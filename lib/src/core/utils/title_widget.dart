import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final VoidCallback? callbackAction;

  const TitleWidget({
    super.key,
    required this.title,
    this.callbackAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              // color: AppColors.black,
            ),
          ),
          const Text(
            "Ver todos",
            style: TextStyle(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
