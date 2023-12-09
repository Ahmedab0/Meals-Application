import 'package:flutter/material.dart';
import 'package:meal_app/provider/language_provider.dart';
import 'package:provider/provider.dart';

import 'package:meal_app/provider/meal_provider.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item.dart';

import '../provider/theme_provider.dart';

class CategoryMealScreen extends StatefulWidget {
  static const String routeName = 'CategoryMealScreen';

  const CategoryMealScreen({super.key});

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  //String? categoryTitle;
  List<Meal>? displayedMeals;
  String? categoryId;

  @override
  void didChangeDependencies() {
    List<Meal> availableMeals = Provider.of<MealProvider>(context).availableMeals;

    Map routArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    categoryId = routArguments['id'] ?? '';
    //categoryTitle = routArguments['title'];
    displayedMeals = availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var lang = Provider.of<LanguageProvider>(context);
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dw =MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: lang.isEn? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text( lang.getTexts('cat-$categoryId'),
            style: Provider.of<ThemeProvider>(context).titleLarge,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
        ),
        body: SafeArea(
          child: isLandScape? GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: dw * 0.5,
              childAspectRatio: dw >= 800 ? 1 / 0.68 : 1 / 0.8,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
            ),
            itemBuilder: (BuildContext context, int index) => MealItem(
              id: displayedMeals![index].id,
              //title: displayedMeals![index].title,
              imageUrl: displayedMeals![index].imageUrl,
              duration: displayedMeals![index].duration,
              complexity: displayedMeals![index].complexity,
              affordability: displayedMeals![index].affordability, price: displayedMeals![index].price,
            ),
            itemCount: displayedMeals!.length,
          ): ListView.builder(
            itemBuilder: (BuildContext context, int index) => MealItem(
              id: displayedMeals![index].id,
              //title: displayedMeals![index].title,
              imageUrl: displayedMeals![index].imageUrl,
              duration: displayedMeals![index].duration,
              complexity: displayedMeals![index].complexity,
              affordability: displayedMeals![index].affordability, price: displayedMeals![index].price,
            ),
            itemCount: displayedMeals!.length,
          ),
        ),
      ),
    );
  }
}
