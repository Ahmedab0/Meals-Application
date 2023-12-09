import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/provider/language_provider.dart';
import 'package:meal_app/provider/meal_provider.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class MealDetails extends StatelessWidget {
  static const routeName = 'MealDetailsScreen';

  const MealDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ///
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    LanguageProvider lang = Provider.of<LanguageProvider>(context);
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dh = MediaQuery.of(context).size.height;
    ///
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final mealId = routeArgs['id'];
    final price = routeArgs['price'];
    //final imageUrl = routeArgs['imageUrl'];

    final selectedMeal = dummyMeals.firstWhere((element) => element.id == mealId);

    ListView liIngredients = ListView.builder(
      itemBuilder: (BuildContext context, index) => Card(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            lang.getTexts('ingredients-$mealId')[index],
            style: Provider.of<ThemeProvider>(context).bodyMedium,
          ),
        ),
      ),
      itemCount: lang.getTexts('ingredients-$mealId').length,
    );
    ListView liSteps = ListView.builder(
      itemBuilder: (BuildContext context, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Text('#${index + 1}'), //${index+1}
            ),
            title: Text(
              lang.getTexts('steps-$mealId')[index],
              style: Provider.of<ThemeProvider>(context).bodyMedium,
            ),
          ),
          const Divider(color: Colors.grey),
        ],
      ),
      itemCount: lang.getTexts('steps-$mealId').length,
    );

    return Directionality(
      textDirection: lang.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).colorScheme.primary,
            statusBarBrightness: Brightness.light),
        child: Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  //snap: true,
                  //floating: true,
                  pinned: true,
                  expandedHeight: isLandScape ? dh * 0.5 : dh * 0.36,
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  //centerTitle: true,
                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 1.3,
                    title: Text(
                      lang.getTexts('meal-$mealId'),
                      //textDirection: lang.isEn? TextDirection.ltr : TextDirection.rtl,
                      style: Provider.of<ThemeProvider>(context)
                          .titleSmall
                          .copyWith(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Section Image
                    background: Hero(
                      tag: mealId,
                      child: InteractiveViewer(
                        child: FadeInImage(
                          placeholder: const AssetImage('assets/img/a2.png'),
                          fit: BoxFit.cover,
                          image: NetworkImage(selectedMeal.imageUrl),
                        ),
                      ),
                    ),
                  ),
                  // Start favorite button
                  actions: [
                    IconButton(
                      onPressed: () =>
                          Provider.of<MealProvider>(context, listen: false)
                              .toggleFavorite(mealId),
                      icon: Icon(
                        shadows: [
                          Shadow(
                              color: Colors.black54,
                              offset: lang.isEn
                                  ? const Offset(-3, 3)
                                  : const Offset(3, 3),
                              blurRadius: 0.3),
                        ],
                        Provider.of<MealProvider>(context)
                                .isMealFavorite(mealId)
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      //padding: const EdgeInsets.all(12),
                      iconSize: 35,
                      color: Theme.of(context).colorScheme.secondary,
                    )
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    if (isLandScape)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              // Header Section
                              Header(lang.getTexts('Ingredients')),
                              // Ingredient & Steps Section
                              Section(child: liIngredients),
                            ],
                          ),
                          Column(
                            children: [
                              //  Steps Section
                              Header(lang.getTexts('Steps')),
                              Section(child: liSteps),
                            ],
                          ),
                        ],
                      ),
                    // Header Section
                    if (!isLandScape) Header(lang.getTexts('Ingredients')),
                    // Ingredient & Steps Section
                    if (!isLandScape) Section(child: liIngredients),
                    //  Steps Section
                    if (!isLandScape) Header(lang.getTexts('Steps')),
                    if (!isLandScape) Section(child: liSteps),

                    // Add to cart section
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // price
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:
                                    Theme.of(context).colorScheme.secondary,
                              ),
                              child: Text(
                                '$price \$',
                                style: theme.subHeader
                                    .copyWith(color: Colors.black87),
                              )),

                          // Add to cart btn
                          Builder(
                            builder: (ctx) {
                              return ElevatedButton.icon(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 19)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).colorScheme.primary),
                                  foregroundColor: MaterialStateProperty.all(
                                      Colors.white.withOpacity(0.9)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6))),
                                ),
                                onPressed: () => Provider.of<MealProvider>(context, listen: false)
                                    .toggleCartRequest(mealId),
                                icon: Icon(
                                  Provider.of<MealProvider>(context)
                                      .isMealRequested(mealId)
                                      ? Icons.shopping_cart
                                      : Icons.shopping_cart_outlined,
                                ),
                                label: Text(Provider.of<MealProvider>(context)
                                    .isMealRequested(mealId) ? lang.getTexts('remove_cart').toString() : lang.getTexts('add_cart').toString(), style: theme.titleSmall),
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )

                  ]),
                ),
              ],
            ),
          ),
          /*floatingActionButton: FloatingActionButton(
            onPressed:  () => Provider.of<MealProvider>(context, listen: false)
                    .toggleCartRequest(mealId),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: Icon(
            Provider.of<MealProvider>(context)
            .isMealRequested(mealId)
            ? Icons.shopping_cart
            : Icons.shopping_cart_outlined,
      ),
          ),*/
        ),
      ),
    );
  }
}

// Header Class
class Header extends StatelessWidget {
  final String header;

  const Header(this.header, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        header,
        style: Provider.of<ThemeProvider>(context).subHeader,
        textAlign: TextAlign.center,
      ),
    );
  }
}

// Section Class
class Section extends StatelessWidget {
  final Widget child;

  const Section({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      width: isLandScape ? dw * 0.45 : dw * 0.75,
      height: isLandScape ? dh * 0.5 : dh * 0.23,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: child,
    );
  }
}
