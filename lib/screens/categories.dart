import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mealsapp/data/dummy_data.dart';
import 'package:mealsapp/models/category.dart';
import 'package:mealsapp/screens/meals.dart';
import 'package:mealsapp/widgets/categorygriditem.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {
    final filteredList =
        dummyMeals.where((meal) => meal.categories.contains(category.id));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MealsScreen(
                title: category.title, meals: filteredList.toList())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          titleTextStyle: GoogleFonts.aldrich(fontSize: 20),
          title: const Text('Pick your Category'),
        ),
        body: GridView(
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
        ));
  }
}
