
import 'package:flutter/material.dart';

import '../models/food_model.dart';
import '../utils/app_colors.dart';

class FoodItemCard extends StatelessWidget {
  final FoodModel food;
  final VoidCallback onDelete;

  const FoodItemCard({
    super.key,
    required this.food,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),

        leading: CircleAvatar(
          backgroundColor: AppColors.secondaryColor.withOpacity(0.2),
          child: const Icon(
            Icons.restaurant,
            color: AppColors.primaryColor,
          ),
        ),

        title: Text(
          food.foodName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        subtitle: Text(
          '${food.calories.toStringAsFixed(0)} kcal',
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.secondaryTextColor,
          ),
        ),

        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(
            Icons.delete_outline,
            color: AppColors.deleteColor,
          ),
          tooltip: 'Delete food',
        ),
      ),
    );
  }
}
