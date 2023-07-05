import 'package:flutter/material.dart';
import 'package:mealsapp/data/dummy_data.dart';
import 'package:mealsapp/models/category.dart';
import 'package:mealsapp/screens/meals.dart';
import 'package:mealsapp/widgets/categorygriditem.dart';
import '../models/meal.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.availabeMeals});

  
  final List<Meal> availabeMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredList =
        availabeMeals.where((meal) => meal.categories.contains(category.id));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MealsScreen(
                  title: category.title,
                  meals: filteredList.toList(),
                )));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: availableCategories
          .map((category) => CategoryGridItem(
                category: category,
                onSelectedCategory: () {
                  _selectCategory(context, category);
                },
              ))
          .toList(),
    );
  }
}
