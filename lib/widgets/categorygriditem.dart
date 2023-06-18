import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mealsapp/screens/categories.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return const CategoryScreen();
  }
}
