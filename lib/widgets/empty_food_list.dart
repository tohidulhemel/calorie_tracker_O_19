
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class EmptyFoodList extends StatelessWidget {
  const EmptyFoodList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.no_food_outlined,
              size: 70,
              color: AppColors.secondaryTextColor.withOpacity(0.5),
            ),

            const SizedBox(height: 16),

            const Text(
              'No Food Added Yet!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Start tracking your daily calories by adding your first food item.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.secondaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
