import 'package:flutter/material.dart';
import 'package:meal_app/provider/language_provider.dart';
import 'package:meal_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../screens/filter_screen.dart';
import '../screens/tab_bar_screen.dart';

/// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MainDrawer extends StatefulWidget {
  static const routeName = 'MainDrawer';

  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return buildDrawer(context);
  }
  Directionality buildDrawer(BuildContext context) {
    LanguageProvider lang = Provider.of<LanguageProvider>(context);
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Directionality(
      textDirection: lang.isEn? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        width: isLandScape
            ? MediaQuery.of(context).size.width * 0.4
            : MediaQuery.of(context).size.width * 0.7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        backgroundColor: Theme.of(context).colorScheme.background,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(14),
                width: double.infinity,
                color: Theme.of(context).colorScheme.secondary,
                child: Row(
                  children: [
                    const Icon(
                      Icons.fastfood,
                      size: 30,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      lang.getTexts('drawer_name'),
                      style: Provider.of<ThemeProvider>(context).displayLarge,
                    ),
                  ],
                ),
              ),
              // Links
              // Start CateGory Meals
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(TabBarScreen.routeNamed);
                },
                leading: const Icon(
                  Icons.restaurant,
                  size: 22,
                  //color: Theme.of(context).iconTheme.color,
                ),
                title: Text(
                  lang.getTexts('drawer_item1'),
                  style: Provider.of<ThemeProvider>(context).subHeader,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 22,
                  //color: Theme.of(context).iconTheme.color,
                ),
                //contentPadding: const EdgeInsets.all(6),
              ),
              const Divider(
                color: Colors.grey,
              ),
              // Start App Filter
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(Filter.routeName);
                },
                leading: const Icon(
                  Icons.filter_alt,
                  size: 22,
                  //color: Theme.of(context).iconTheme.color,
                ),
                title: Text(
                  lang.getTexts('drawer_item2'),
                  style: Provider.of<ThemeProvider>(context).subHeader,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 22,
                  //color: Theme.of(context).iconTheme.color,
                ),
                //contentPadding: const EdgeInsets.all(6),
              ),
              const Divider(
                color: Colors.grey,
              ),
              // Start App Theme
              ListTile(
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      barrierColor: Colors.black.withOpacity(0.9),
                      context: context,
                      builder: (_) => Directionality(
                        textDirection: lang.isEn? TextDirection.ltr : TextDirection.rtl,
                        child: AlertDialog(
                          title: Text(
                            lang.getTexts('theme_appBar_title'),
                            style: Provider.of<ThemeProvider>(context).subHeader,
                          ),
                          content: isLandScape
                              ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                  child: buildRadioListTile(
                                      ThemeMode.system, lang.getTexts("System_default_theme"), context)),
                              Expanded(
                                  child: buildRadioListTile(
                                      ThemeMode.light, lang.getTexts("light_theme"), context)),
                              Expanded(
                                  child: buildRadioListTile(
                                      ThemeMode.dark, lang.getTexts("dark_theme"), context)),
                            ],
                          )
                              : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildRadioListTile(ThemeMode.system, lang.getTexts("System_default_theme"), context),
                              buildRadioListTile(ThemeMode.light, lang.getTexts("light_theme"), context),
                              buildRadioListTile(ThemeMode.dark, lang.getTexts("dark_theme"), context),
                            ],
                          ),
                          actions: [
                            TextButton.icon(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(Icons.close,size: 20,color: Colors.redAccent,),
                                label: Text(lang.getTexts('btn_close'),style: const TextStyle(color: Colors.redAccent,fontSize: 18),),
                            ),
                          ],
                        ),
                      ));

                },
                leading: const Icon(
                  Icons.color_lens,
                  size: 22,
                  //color: Theme.of(context).iconTheme.color,
                ),
                title: Text(
                  lang.getTexts('drawer_item3'),
                  style: Provider.of<ThemeProvider>(context).subHeader,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 22,
                  //color: Theme.of(context).iconTheme.color,
                ),
                //contentPadding: const EdgeInsets.all(6),
              ),
              const Divider(
                color: Colors.grey,
              ),

              // Start App Language
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 17),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.language,
                          size: 22
                          //color: Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(width: 18,),
                        Text(
                          lang.getTexts('drawer_switch_title'),
                          style: Provider.of<ThemeProvider>(context).subHeader,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(lang.getTexts('drawer_switch_item2'),style: Provider.of<ThemeProvider>(context).subHeader,),
                      Switch(
                        //trackColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                        value: Provider.of<LanguageProvider>(context).isEn,
                        onChanged: (newLan) => Provider.of<LanguageProvider>(context,listen: false).changeLan(newLan),
                      ),
                      Text(lang.getTexts('drawer_switch_item1'),style: Provider.of<ThemeProvider>(context).subHeader,),
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  // Theme showDialog
  Future<dynamic> themeDialog(BuildContext context) {
    var lang = Provider.of<LanguageProvider>(context,listen: false);
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.9),
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                lang.getTexts('theme_appBar_title'),
                style: Provider.of<ThemeProvider>(context).subHeader,
              ),
              content: isLandScape
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: buildRadioListTile(
                                ThemeMode.system, lang.getTexts("System_default_theme"), context)),
                        Expanded(
                            child: buildRadioListTile(
                                ThemeMode.light, lang.getTexts("light_theme"), context)),
                        Expanded(
                            child: buildRadioListTile(
                                ThemeMode.dark, lang.getTexts("dark_theme"), context)),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildRadioListTile(ThemeMode.system, 'System', context),
                        buildRadioListTile(ThemeMode.light, 'Light', context),
                        buildRadioListTile(ThemeMode.dark, 'Dark', context),
                      ],
                    ),
            ));
  }

  /// Language showDialog Testing
  RadioListTile<bool> langRadioListTile(
      BuildContext context, String txt, bool isEng) {
    return RadioListTile(
      activeColor: greenClr,
      title: Text(txt, style: Provider.of<ThemeProvider>(context).subHeader),
      value: isEng,
      groupValue: isEng,
      onChanged: (newLan) {
        Provider.of<LanguageProvider>(context, listen: false)
            .changeLan(newLan!);
      },
    );
  }
  // ThemeMode RadioListTile
  RadioListTile<ThemeMode> buildRadioListTile(
      ThemeMode themeVal, String txt, BuildContext context) {
    return RadioListTile(
      activeColor: greenClr,
      title: Text(txt, style: Provider.of<ThemeProvider>(context).subHeader),
      value: themeVal,
      groupValue: Provider.of<ThemeProvider>(context).tm,
      onChanged: (newTheme) {
        Provider.of<ThemeProvider>(context, listen: false)
            .changeTheme(newTheme);
        Navigator.of(context).pop();
      },
    );
  }

}


/// Testing
class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.icon1,
    required this.icon2,
    required this.text,
    required this.fun,
  });

  final Function fun;
  final IconData icon1;
  final IconData icon2;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: fun(),
      leading: Icon(
        icon1,
        size: 25,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        text,
        style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed'),
      ),
      trailing: Icon(
        icon2,
        size: 25,
        color: Theme.of(context).colorScheme.secondary,
      ),
      contentPadding: const EdgeInsets.all(6),
    );
  }
}
