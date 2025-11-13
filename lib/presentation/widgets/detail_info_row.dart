// lib/presentation/widgets/detail_info_row.dart

import 'package:flutter/material.dart';
import 'package:tixoo/core/constants/app_colors.dart';

class DetailInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const DetailInfoRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container (Off-white background with green icon)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primaryGreen),
          ),
          const SizedBox(width: 16),
          
          // Title and Subtitle Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.greyText,
                  ),
                ),
              ],
            ),
          ),
          
          // Forward Arrow Icon
          const Icon(
            Icons.arrow_forward,
            color: AppColors.greyText,
            size: 18,
          ),
        ],
      ),
    );
  }
}