import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';

class MealProvider with ChangeNotifier {
  var counter = 1;
  int total = 0;
  int sum = 0;

  void increment (){
    counter++;
    notifyListeners();
  }
  void decrement (){
    if(counter > 1) counter--;
    notifyListeners();
  }
  calcPrice(int price) {
    total = counter * price;
    notifyListeners();
  }

  ///

  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availableMeals = dummyMeals;
  List<Meal> favoriteMeals = [];
  List<String> prefsMealId = [];
  List<Category> availableCategory = [];

  List<Meal> requests = [];
  List<String> reqMealId = [];


  ///

  // save filter
  void setFilter() async {
    availableMeals = dummyMeals.where((meal) {
      if (filters['gluten']! && !meal.isGlutenFree) {
        return false;
      }
      if (filters['lactose']! && !meal.isLactoseFree) {
        return false;
      }
      if (filters['vegan']! && !meal.isVegan) {
        return false;
      }
      if (filters['vegetarian']! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    // to Filter Categories
    List<Category> ac = [];
    for (var meal in availableMeals) {
      for (var catId in meal.categories) {
        for (var cat in dummyCategories) {
          if (cat.id == catId) {
            if (!ac.any((cat) => cat.id == catId)) ac.add(cat);
          }
        }
      }
    }
    availableCategory = ac;

    notifyListeners();

    // Store Data to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("gluten", filters['gluten']!);
    prefs.setBool("lactose", filters['lactose']!);
    prefs.setBool("vegan", filters['vegan']!);
    prefs.setBool("vegetarian", filters['vegetarian']!);

  } // End setFilter

  ///

  // Function to change Favorite Icon
  bool isMealFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  } // End Function isMealFavorite

  ///

  // Function To Add And Remove Meal to favorite Screen
  toggleFavorite(String mealId) async {
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
      prefsMealId.remove(mealId);
    } else {
      favoriteMeals.add(dummyMeals.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('mealIdList', prefsMealId);
  } // End Function toggleFavorite

  ///

  // Function To Add And Remove Meal to cart Screen
  toggleCartRequest(String mId) async {
    final existingIndex = requests.indexWhere((meal) => meal.id == mId);
    if (existingIndex >= 0) {
      requests.removeAt(existingIndex);
      reqMealId.remove(mId);
    } else {
      requests.add(dummyMeals.firstWhere((meal) => meal.id == mId));
      reqMealId.add(mId);
    }
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('reqMealId', reqMealId);
  }

  ///

  // Function to change Favorite Icon
  bool isMealRequested(String id) {
    return requests.any((meal) => meal.id == id);
  } // End Function isMealFavorite

  ///

  // get data from SharedPreferences
  void getDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool('gluten') ?? false;
    filters['lactose'] = prefs.getBool('lactose') ?? false;
    filters['vegan'] = prefs.getBool('vegan') ?? false;
    filters['vegetarian'] = prefs.getBool('vegetarian') ?? false;

    setFilter();

    ///

    // prefsMealId
    prefsMealId = prefs.getStringList('mealIdList') ?? [];
    for (var mlId in prefsMealId) {
      final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mlId);
      if (existingIndex < 0) {
        favoriteMeals.add(dummyMeals.firstWhere((meal) => meal.id == mlId));
      }
    }// end prefsMealId

    ///

    // reqMealId
    reqMealId = prefs.getStringList('reqMealId') ?? [];
    for (var id in reqMealId) {
      final existingIndex = requests.indexWhere((meal) => meal.id == id);
      if (existingIndex < 0) {
        requests.add(dummyMeals.firstWhere((meal) => meal.id == id));
      }
    }// end reqMealId

    /// To filter favoriteMeals should be show
    List<Meal> fm = [];
    for(var favMeals in favoriteMeals) {
      for(var avaMeals in availableMeals) {
        if (favMeals.id == avaMeals.id) fm.add(favMeals);
      }
    }
    favoriteMeals = fm;
///
    List<Meal> rqm = [];
    for(var rqMeals in requests) {
      for(var avaMeals in availableMeals) {
        if (rqMeals.id == avaMeals.id) rqm.add(rqMeals);
      }
    }
    requests = rqm;

    notifyListeners();
  } // getDate


}
