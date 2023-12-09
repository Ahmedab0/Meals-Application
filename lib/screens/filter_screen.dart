import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/language_provider.dart';
import '../provider/meal_provider.dart';
import '../widgets/drawer.dart';
import '../provider/theme_provider.dart';

class Filter extends StatefulWidget {
  static const routeName = 'FilterScreen';

  final bool onBoarding;

  const Filter({super.key, this.onBoarding = false});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    ///
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    LanguageProvider lang = Provider.of<LanguageProvider>(context);
    ///
    AppBar appBar = AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Theme.of(context).colorScheme.primary,
      centerTitle: true,
      title: Text(
        lang.getTexts('filters_appBar_title'),
        style: Provider.of<ThemeProvider>(context).titleLarge,
      ),
      actions: [
        IconButton(
          onPressed: () {
            Provider.of<MealProvider>(context,listen: false).setFilter();
          },
          icon: const Icon(
            Icons.save_outlined,
            size: 27,
            color: Colors.white,
          ),
        ),
      ],
    );
    AppBar appBarBoarding = AppBar(
      elevation: 0,
        scrolledUnderElevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      actions: [
      IconButton(
        onPressed: () {
          Provider.of<MealProvider>(context,listen: false).setFilter();
        },
        icon: Icon(
          Icons.save_outlined,
          size: 27,
          color: (theme.tm == ThemeMode.dark)? Colors.white70 : Colors.grey,
        ),
      ),
    ],);
    double appBarHeight = appBar.preferredSize.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    final Map<String, bool> filter = Provider.of<MealProvider>(context).filters;

    return Directionality(
      textDirection: lang.isEn? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: !widget.onBoarding ? appBar : appBarBoarding,
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  lang.getTexts('filters_screen_title'),
                  textAlign: TextAlign.center,
                  style: Provider.of<ThemeProvider>(context).titleMedium,
                ),
              ),
              buildSwitchListTile(
                lang.getTexts('Gluten-free'),
                lang.getTexts('Gluten-free-sub'),
                filter['gluten']!,
                    (newValue) {
                  setState(() => filter['gluten'] = newValue);
                  //Provider.of<MealProvider>(context,listen: false).setFilter();
                },
              ),
              const Divider(color: Colors.grey),
              buildSwitchListTile(
                lang.getTexts('Lactose-free'),
                lang.getTexts('Lactose-free_sub'),
                filter['lactose']!,
                    (newValue) {
                  setState(() => filter['lactose'] = newValue);
                  //Provider.of<MealProvider>(context, listen: false).setFilter();
                },
              ),
              const Divider(color: Colors.grey),
              buildSwitchListTile(
                lang.getTexts('Vegetarian'),
                lang.getTexts('Vegetarian-sub'),
                filter['vegan']!,
                    (newValue) {
                  setState(() => filter['vegan'] = newValue);
                  //Provider.of<MealProvider>(context, listen: false).setFilter();
                },
              ),
              const Divider(color: Colors.grey),
              buildSwitchListTile(
                lang.getTexts('Vegan'),
                lang.getTexts('Vegan-sub'),
                filter['vegetarian']!,
                    (newValue) {
                  setState(() => filter['vegetarian'] = newValue);
                  //Provider.of<MealProvider>(context, listen: false).setFilter();
                },
              ),
              const Divider(color: Colors.grey),

              SizedBox(height: widget.onBoarding? 80 : 0,)
            ],
          ),
        ),
        drawer: widget.onBoarding ? null : Padding(
          padding: EdgeInsets.only(top: (appBarHeight + statusBarHeight)),
          child: const MainDrawer(),
        ),
      ),
    );
  }

// SwitchListTile Method
  Widget buildSwitchListTile(
      String title, String subtitle, bool value, Function(bool) change) {
    return SwitchListTile(
      //activeColor: Theme.of(context).colorScheme.primary,
      trackOutlineColor: value ? MaterialStateProperty.all(Theme.of(context).primaryColor) : MaterialStateProperty.all(Colors.grey[600]),
      inactiveThumbColor: Colors.grey[600],
      inactiveTrackColor: Colors.grey[300],
      //activeTrackColor: Colors.black45,
      title: Text(
        title,
        style: Provider.of<ThemeProvider>(context).subHeader,
      ),
      subtitle: Text(
        subtitle,
        style: Provider.of<ThemeProvider>(context).bodySmall,
      ),
      value: value,
      onChanged: change,
    );
  }
}
