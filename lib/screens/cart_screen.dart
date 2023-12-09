import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/provider/meal_provider.dart';
import 'package:meal_app/provider/theme_provider.dart';
import 'package:meal_app/widgets/cart_item.dart';
import 'package:provider/provider.dart';

import '../provider/language_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeNamed = 'CartScreen';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageProvider lang = Provider.of<LanguageProvider>(context);
    var counter = Provider.of<MealProvider>(context).counter;
    List<Meal> requests = Provider.of<MealProvider>(context).requests;
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    if (requests.isEmpty) {
      return const Center(
        child: Text('You have no meals yet - start adding some!'),
      );
    } else {
      return Stack(
        children: [
          isLandScape? GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent:
              MediaQuery.of(context).size.width * 0.5,
              childAspectRatio: 1.5 / 0.5,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,

            ),
            children: requests.map((r) => CartItem(
              id: r.id,
              imgUrl: r.imageUrl,
              title: lang.getTexts('meal-${r.id}'),
              price: r.price,
              counter: counter,
            )).toList(),
          )
              : ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) => CartItem(
              id: requests[index].id,
              imgUrl: requests[index].imageUrl,
              title: lang.getTexts('meal-${requests[index].id}'),
              price: requests[index].price,
              counter: counter,
            ),
          ),
          // Start Button
          Align(
            alignment: isLandScape?  const Alignment(0, 0.3) : const Alignment(0, 0.69),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(8),
                  backgroundColor: MaterialStateProperty.all(
                    //Color(0xffDB4437)
                    Theme.of(context).colorScheme.primary,
                  ),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 5)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6))),
                ),
                child: Text(
                  lang.getTexts('checkout'),
                  style: Provider.of<ThemeProvider>(context).titleSmall,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}

