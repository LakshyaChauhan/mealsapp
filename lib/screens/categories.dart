import 'package:flutter/material.dart';
import 'package:mealsapp/data/dummy_data.dart';
import 'package:mealsapp/models/category.dart';
import 'package:mealsapp/screens/meals.dart';
import 'package:mealsapp/widgets/categorygriditem.dart';
import '../models/meal.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.availabeMeals});

  final List<Meal> availabeMeals;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 0,
        upperBound: 1,
        duration: const Duration(milliseconds: 300));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredList = widget.availabeMeals
        .where((meal) => meal.categories.contains(category.id));
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
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.1),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear)),
        child: child,
      ),
      child: GridView(
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
      ),
    );
  }
}
