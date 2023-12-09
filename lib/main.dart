
import 'package:flutter/material.dart';
import 'package:meal_app/provider/language_provider.dart';
import 'package:meal_app/provider/theme_provider.dart';
import 'package:meal_app/screens/on_boarding_screen.dart';
import 'package:meal_app/screens/cart_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/category_meal_screen.dart';
import '../screens/filter_screen.dart';
import '../screens/meal_details_screen.dart';
import '../screens/tab_bar_screen.dart';
import '../widgets/drawer.dart';
import './provider/meal_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool started = prefs.getBool('started') ?? false;

  Widget decision = started? const TabBarScreen() : const OnBoardingScreen();


  //prefs.clear();
  //log('started: $started');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (ctx) => MealProvider()),
      ChangeNotifierProvider(create: (ctx) => ThemeProvider()),
      ChangeNotifierProvider(create: (ctx) => LanguageProvider()),
    ],
    child: MyApp(decision),
  ));
}

class MyApp extends StatelessWidget {
  final Widget decision;

  const MyApp(this.decision, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeMode tm = Provider.of<ThemeProvider>(context).tm;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: tm,
      theme: Themes.light,
      darkTheme: Themes.dark,
      //home: decision,
      initialRoute: '/',
      routes: {
        '/' : (context) => decision,
        OnBoardingScreen.routeNamed: (context) => const OnBoardingScreen(),
        TabBarScreen.routeNamed : (context) => const TabBarScreen(),
        CategoryMealScreen.routeName : (context) => const CategoryMealScreen(),
        MealDetails.routeName : (context) => const MealDetails(),
        Filter.routeName : (context) => const Filter(),
        MainDrawer.routeName : (context) => const MainDrawer(),
        CartScreen.routeNamed : (context) => const CartScreen(),
      },
    );
  }
}
