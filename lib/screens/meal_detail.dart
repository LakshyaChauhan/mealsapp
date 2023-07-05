import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/providers/favourite_provider.dart';

import '../models/meal.dart';

class MealDetailScreeen extends ConsumerWidget {
  const MealDetailScreeen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeal = ref.watch(favouriteMealProvider);
    final isFavourite = favouriteMeal.contains(meal);

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  final wasAdded = ref
                      .read(favouriteMealProvider.notifier)
                      .toggleMealFavouriteStatus(meal);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(wasAdded
                          ? 'Meal added as faourite'
                          : 'Meal removed from favourite.')));
                },
                icon:  Icon(isFavourite ? Icons.star : Icons.star_border)   )
          ],
          title: Text(meal.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 16,
              ),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              const SizedBox(height: 18),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 16,
              ),
              for (final steps in meal.steps)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Text(
                    steps,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
            ],
          ),
        ));
  }
}
