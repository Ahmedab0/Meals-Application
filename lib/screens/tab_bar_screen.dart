import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:meal_app/provider/language_provider.dart';
import 'package:meal_app/provider/meal_provider.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
import './category_screen.dart';
import './favorite_screen.dart';
import './cart_screen.dart';
import '../widgets/drawer.dart';

class TabBarScreen extends StatefulWidget {
  static const routeNamed = 'TabBarScreen';
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {


  int currentIndex = 1;
  List pages = [];

@override
  void initState() {
   Provider.of<MealProvider>(context,listen: false).getDate();
    Provider.of<ThemeProvider>(context,listen: false).getThemeMode();
    Provider.of<LanguageProvider>(context,listen: false).getLan();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    LanguageProvider lang = Provider.of<LanguageProvider>(context);
    pages = [
      {
        'page': const FavoriteScreen(),
        'title': lang.getTexts('your_favorites'),
      },
      {'page': const CategoryScreen(), 'title': lang.getTexts('categories')},

      {'page': const CartScreen(), 'title': lang.getTexts('requests')},

    ];
    // AppBar
    var appBar = AppBar(
      foregroundColor: Colors.white,
      title: Text(pages[currentIndex]['title'],
          style: Provider.of<ThemeProvider>(context).titleLarge),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
    );

    //double deviceHeight = MediaQuery.of(context).size.height;
    double appBarHeight = appBar.preferredSize.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    //double scaffoldHeight = deviceHeight - appBarHeight - statusBarHeight;

    return Directionality(
      textDirection: lang.isEn? TextDirection.ltr: TextDirection.rtl,
      child: Scaffold(
        extendBody: true,
        appBar: appBar,
        body: pages[currentIndex]['page'],
        bottomNavigationBar: CurvedNavigationBar(
            color: Theme.of(context).colorScheme.primary,
            buttonBackgroundColor: Theme.of(context).colorScheme.secondary,
            backgroundColor: Colors.transparent,
            index: currentIndex,
            items: const [
              Icon(Icons.favorite, size: 30, color: Colors.white, semanticLabel: 'favorite'),
              Icon(Icons.category, size: 30, color: Colors.white, semanticLabel: 'category'),
              Icon(Icons.shopping_cart_sharp, size: 30, color: Colors.white, semanticLabel: 'cart'),
            ],
            onTap: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        drawer: Padding(
          padding: EdgeInsets.only(top: (appBarHeight + statusBarHeight)),
          child: const MainDrawer(),
        ),
      ),
    );
  }
}
