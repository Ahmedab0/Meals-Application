import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/language_provider.dart';
import '../provider/theme_provider.dart';
import '../screens/meal_details_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  //final String title;
  final int price;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealItem({
    super.key,
    required this.id,
    //required this.title,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability, required this.price,
  });
/*
  String get complexityText {
    switch (complexity) {
      case Complexity.simple:
        return 'Simple';
      case Complexity.challenging:
        return 'Challenging';
      case Complexity.hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.pricey:
        return 'Pricey';
      case Affordability.luxurious:
        return 'Luxurious';
      case Affordability.affordable:
        return 'Affordable';
      default:
        return 'Unknown';
    }
  }*/

  void mealSelected(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(MealDetails.routeName, arguments: {'id': id, 'price': price, 'imageUrl' : imageUrl});
      // testing
/*        .then(
          (mealId) {
        //if (mealId != null) removeMeal(mealId);
      },
    );*/
  }

  @override
  Widget build(BuildContext context) {
    var lang = Provider.of<LanguageProvider>(context);
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.primary,
        onTap: () => mealSelected(context),
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  child: Hero(
                    tag: id,
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/img/a2.png'),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                      image: NetworkImage(imageUrl),),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    //width: 240,
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                    ),
                    child: Text(
                      lang.getTexts('meal-$id'),
                      style: Provider.of<ThemeProvider>(context).titleSmall,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule),
                      const SizedBox(width: 6),
                      Text('$duration ${lang.getTexts('min')}'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.work),
                      const SizedBox(width: 6),
                      Text(lang.getTexts('$complexity')),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.attach_money),
                      const SizedBox(width: 6),
                      Text(lang.getTexts('$affordability')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
