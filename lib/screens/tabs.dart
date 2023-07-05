import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/providers/favourite_provider.dart';
import 'package:mealsapp/providers/meals_provider.dart';
import 'package:mealsapp/screens/categories.dart';
import 'package:mealsapp/screens/filters.dart';
import 'package:mealsapp/screens/meals.dart';
import 'package:mealsapp/widgets/main_drawer.dart';
import 'package:mealsapp/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.gluttenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      await Navigator.push<Map<Filter, bool>>(
          context, MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final actveFilters = ref.watch(filtersProvider);
    final availableMeals = meals.where((meal) {
      if (actveFilters[Filter.gluttenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (actveFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (actveFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (actveFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoryScreen(
      availabeMeals: availableMeals,
    );
    String activePagetitle = 'Categories';
    if (_selectedPageIndex == 1) {
      final favouriteMeal = ref.watch(favouriteMealProvider);
      activePage = MealsScreen(
        meals: favouriteMeal,
      );
      activePagetitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePagetitle),
      ),
      body: activePage,
      drawer: MainDrawer(onSelectScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
          onTap: selectPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
          ]),
    );
  }
}
