import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/providers/meals_provider.dart';

enum Filter { gluttenFree, lactoseFree, vegetarian, vegan }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.gluttenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
        (ref) => FilterNotifier());

final filteredMealsProvider = Provider((ref) {
  final activeFilters = ref.watch(filtersProvider);
  final meal = ref.watch(mealsProvider);
  return meal.where((meal) {
      if (activeFilters[Filter.gluttenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
});
