
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/food_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../widgets/calorie_summary_card.dart';
import '../widgets/food_item_card.dart';
import '../widgets/empty_food_list.dart';
import 'add_food_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Daily calorie goal
  final double dailyGoal = 2000;

  // Local list to store food items
  final List<FoodModel> foodList = [];

  // Calculate total calories
  double get totalCalories {
    return foodList.fold(
      0,
      (sum, food) => sum + food.calories,
    );
  }

  // Calculate remaining calories
  double get remainingCalories {
    return (dailyGoal - totalCalories).clamp(0.0, double.infinity);
  }

  // Display today's date
  String get todayDate {
    return DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now());
  }

  // Navigate to Add Food Screen
  Future<void> _navigateToAddFood() async {
    final FoodModel? newFood = await Navigator.push<FoodModel>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddFoodScreen(),
      ),
    );

    if (newFood != null) {
      setState(() {
        foodList.add(newFood);
      });
    }
  }

  // Delete food item
  void _deleteFood(int index) {
    setState(() {
      foodList.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Food item deleted successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calorie Tracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // Main scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Today's date
                    Text(
                      todayDate,
                      style: AppStyles.bodyText,
                    ),

                    const SizedBox(height: 24),

                    // Calorie Summary Heading
                    const Text(
                      'Calorie Summary',
                      style: AppStyles.appTitle,
                    ),

                    const SizedBox(height: 16),

                    // Summary Cards
                    Row(
                      children: [
                        Expanded(
                          child: CalorieSummaryCard(
                            title: 'Total Calories',
                            value: totalCalories.toStringAsFixed(0),
                            subtitle: 'Consumed',
                            icon: Icons.local_fire_department,
                            color: AppColors.primaryColor,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: CalorieSummaryCard(
                            title: 'Daily Goal',
                            value: dailyGoal.toStringAsFixed(0),
                            subtitle: 'Target',
                            icon: Icons.flag,
                            color: AppColors.warningColor,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    CalorieSummaryCard(
                      title: 'Remaining Calories',
                      value: remainingCalories.toStringAsFixed(0),
                      subtitle: totalCalories > dailyGoal
                          ? 'Daily goal exceeded'
                          : 'Calories left today',
                      icon: Icons.track_changes,
                      color: remainingCalories == 0
                          ? AppColors.deleteColor
                          : AppColors.successColor,
                    ),

                    const SizedBox(height: 28),

                    // Food List Heading
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Food Items',
                          style: AppStyles.appTitle,
                        ),

                        Text(
                          '${foodList.length} items',
                          style: AppStyles.bodyText,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Food List
                    if (foodList.isEmpty)
                      const SizedBox(
                        height: 200,
                        child: EmptyFoodList(),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: foodList.length,

                        itemBuilder: (context, index) {
                          return FoodItemCard(
                            food: foodList[index],
                            onDelete: () => _deleteFood(index),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),

            // Add Food Button
            Padding(
              padding: const EdgeInsets.all(16),

              child: SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton.icon(
                  onPressed: _navigateToAddFood,

                  icon: const Icon(Icons.add),

                  label: const Text(
                    'Add Food',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
