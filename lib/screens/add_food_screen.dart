
import 'package:flutter/material.dart';

import '../models/food_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _foodNameController =
      TextEditingController();

  final TextEditingController _calorieController =
      TextEditingController();

  void _addFood() {
    if (_formKey.currentState!.validate()) {
      final String foodName = _foodNameController.text.trim();

      final double calories =
          double.parse(_calorieController.text.trim());

      final FoodModel newFood = FoodModel(
        foodName: foodName,
        calories: calories,
      );

      Navigator.pop(context, newFood);
    }
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _calorieController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Food'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              const Text(
                'Add Your Food',
                style: AppStyles.appTitle,
              ),

              const SizedBox(height: 8),

              const Text(
                'Enter the food name and its calorie information.',
                style: AppStyles.bodyText,
              ),

              const SizedBox(height: 30),

              const Text(
                'Food Name',
                style: AppStyles.sectionTitle,
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: _foodNameController,

                decoration: const InputDecoration(
                  hintText: 'e.g. Rice, Chicken, Egg',
                  prefixIcon: Icon(Icons.restaurant),
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter food name';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 24),

              const Text(
                'Calorie Amount (kcal)',
                style: AppStyles.sectionTitle,
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: _calorieController,

                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),

                decoration: const InputDecoration(
                  hintText: 'e.g. 250',
                  prefixIcon: Icon(Icons.local_fire_department),
                  suffixText: 'kcal',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter calorie amount';
                  }

                  final double? calories =
                      double.tryParse(value.trim());

                  if (calories == null ||
                      !calories.isFinite ||
                      calories <= 0) {
                    return 'Enter a valid positive number';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton.icon(
                  onPressed: _addFood,

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
            ],
          ),
        ),
      ),
    );
  }
}
