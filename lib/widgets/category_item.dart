import 'package:flutter/material.dart';
import 'package:meal_app/screens/category_meal_screen.dart';
import 'package:provider/provider.dart';

import '../provider/language_provider.dart';
import '../provider/theme_provider.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  //final String title;
  final Color color;

  const CategoryItem(
      this.id,
      //this.title,
      this.color, {super.key});

  void onClicked(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealScreen.routeName,
      arguments: {
        'id': id,
        //'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    LanguageProvider lang = Provider.of<LanguageProvider>(context);
    return InkWell(
      onTap: () => onClicked(context),
      //splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 110,
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
              colors: [
                color,
                color.withOpacity(0.4),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Center(
          child: Text(
            lang.getTexts('cat-$id'),
            style: Provider.of<ThemeProvider>(context).titleSmall,
          ),
        ),
      ),
    );
  }
}
