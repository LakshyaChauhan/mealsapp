import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal.dart';

class FavouriteMealNotifer extends StateNotifier<List<Meal>> {
  FavouriteMealNotifer() : super([]);

  bool toggleMealFavouriteStatus(Meal meal) {
    final mealIsFavourite = state.contains(meal);

    if (mealIsFavourite) {
      state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealProvider =
    StateNotifierProvider<FavouriteMealNotifer, List<Meal>>((ref) {
  return FavouriteMealNotifer();
});
