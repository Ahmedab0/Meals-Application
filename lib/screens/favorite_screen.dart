import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../models/meal.dart';
import '../provider/meal_provider.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var dw = MediaQuery.of(context).size.width;
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    final List<Meal> favoriteMeals = Provider.of<MealProvider>(context).favoriteMeals;

    if (favoriteMeals.isEmpty) {
      return const Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    } else {
      return isLandScape? GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: (dw * 0.5),
          childAspectRatio: dw >= 800 ? 1 / 0.68 : 1 / 0.8,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        ),
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            //title: favoriteMeals[index].title,
            imageUrl: favoriteMeals[index].imageUrl,
            duration: favoriteMeals[index].duration,
            affordability: favoriteMeals[index].affordability,
            complexity: favoriteMeals[index].complexity, price: favoriteMeals[index].price,
          );
        },
        itemCount: favoriteMeals.length,
      ) :
    ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            //title: favoriteMeals[index].title,
            imageUrl: favoriteMeals[index].imageUrl,
            duration: favoriteMeals[index].duration,
            affordability: favoriteMeals[index].affordability,
            complexity: favoriteMeals[index].complexity, price: favoriteMeals[index].price,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
