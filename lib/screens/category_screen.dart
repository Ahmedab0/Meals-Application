import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/category_item.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../provider/language_provider.dart';
import '../provider/meal_provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Meal> img = Provider.of<MealProvider>(context).availableMeals;
    var lang = Provider.of<LanguageProvider>(context);
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var ds = MediaQuery.of(context).size;
    return Directionality(
      textDirection: lang.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Column(
        children: [
          // Section Carousel slider
          if (isLandScape)
            Container()
          else
            Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                height: ds.height * 0.28,
                color: Theme.of(context).colorScheme.primary,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: ds.height * 0.27,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: img.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: FadeInImage(
                              placeholder:
                                  const AssetImage('assets/img/a2.png'),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: ds.height * 0.25,
                              image: NetworkImage(i.imageUrl),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                )),

          Expanded(
            child: isLandScape
                ? GridView(
                    padding: const EdgeInsets.all(15.0),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          MediaQuery.of(context).size.width * 0.5,
                      childAspectRatio: 1.5 / 0.5,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                    ),
                    children: Provider.of<MealProvider>(context)
                        .availableCategory
                        .map(
                          (item) => CategoryItem(item.id, item.color),
                        )
                        .toList(),
                  )
                : ListWheelScrollView(
                    itemExtent: 110.0,
                    children: Provider.of<MealProvider>(context, listen: true)
                        .availableCategory
                        .map(
                          (item) => CategoryItem(item.id, item.color),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}

/// Testing
/*Expanded(
              child: GridView(
                padding: const EdgeInsets.all(15.0),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                children: Provider
                    .of<MealProvider>(context)
                    .availableCategory
                    .map(
                      (item) => CategoryItem(item.id, item.title, item.color),
                )
                    .toList(),
              ),
            ),*/
