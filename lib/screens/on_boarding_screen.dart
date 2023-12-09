import 'package:flutter/material.dart';
import 'package:meal_app/screens/filter_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/language_provider.dart';
import '../provider/theme_provider.dart';
import 'tab_bar_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeNamed = 'OnBoardingScreen';

  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    LanguageProvider lang = Provider.of<LanguageProvider>(context);
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Directionality(
      textDirection: lang.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              children: [
                Container(
                  // image
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage(
                      'assets/img/image.jpg',
                    ),
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Start App title
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          child: Text(
                            lang.getTexts('drawer_name'),
                            style: theme.displayLarge,
                          ),
                        ),
                      ),
                      // Start Settings Section
                      Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              /// lang
                              Text(
                                lang.getTexts('drawer_switch_title'),
                                style: theme.displayLarge,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      lang.getTexts('drawer_switch_item2'),
                                      style: theme.subHeader.copyWith(color: Colors.white),
                                    ),
                                  ),
                                  Switch(
                                    inactiveThumbColor: Colors.grey,
                                    trackOutlineColor: MaterialStateProperty.all(lang.isEn
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.grey),
                                    inactiveTrackColor: Theme.of(context).colorScheme.background,
                                    //lang.isEn? Theme.of(context).colorScheme.primary : Colors.grey,
                                    value: lang.isEn,
                                    onChanged: (newLan) =>
                                        Provider.of<LanguageProvider>(context, listen: false)
                                            .changeLan(newLan),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      lang.getTexts('drawer_switch_item1'),
                                      style: theme.subHeader.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),

                              ///Divider
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: isLandScape? Container() : const Divider(thickness: 2,color: Colors.white70),
                              ),

                              /// theme
                              isLandScape? Container() : Text(
                                lang.getTexts('theme_appBar_title'),
                                style: theme.displayLarge,
                              ),
                              isLandScape? Container() : const SizedBox(height: 10),
                              isLandScape? Container() : Row(
                                children: [
                                  Expanded(
                                    child: buildRadioListTile(
                                        ThemeMode.light, lang.getTexts('light_theme'), context),
                                  ),
                                  Container(
                                    width: 2,
                                    height: 25,
                                    color: Colors.white70,
                                  ),
                                  Expanded(
                                    child: buildRadioListTile(
                                        ThemeMode.dark, lang.getTexts('dark_theme'), context),
                                  ),
                                ],
                              )

                              ///SizedBox(height: isLandScape ? 80: 0,),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                //const LogScreen(),
                const Filter(onBoarding: true),
              ],
              onPageChanged: (newIndex) {
                setState(() {
                  currentIndex = newIndex;
                });
              },
            ),
            // Start Indicator Section
            Align(
              alignment: Alignment(0, isLandScape? 0.70 : 0.83),
              child: Indicator(index: currentIndex),
            ),
            // Start Button
            Align(
              alignment: const Alignment(0, 0.96),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context)
                        .pushReplacementNamed(TabBarScreen.routeNamed);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('started', true);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                  ),
                  child: Text(
                    lang.getTexts('start'),
                    style: theme.titleSmall,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ThemeMode RadioListTile
  RadioListTile<ThemeMode> buildRadioListTile(
      ThemeMode themeVal, String txt, BuildContext context) {
    return RadioListTile(
      activeColor: greenClr,
      title: Text(txt,
          style: Provider.of<ThemeProvider>(context)
              .subHeader
              .copyWith(color: Colors.white, fontSize: 18)),
      value: themeVal,
      groupValue: Provider.of<ThemeProvider>(context).tm,
      onChanged: (newTheme) {
        Provider.of<ThemeProvider>(context, listen: false)
            .changeTheme(newTheme);
      },
    );
  }
}

/// Page View Indicator Class
class Indicator extends StatelessWidget {
  final int index;

  const Indicator({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        circularIndicator(context, 0),
        circularIndicator(context, 1),
        circularIndicator(context, 2),
      ],
    );
  }

  Container circularIndicator(BuildContext context, int i) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: index == i ? 12 : 8,
      height: index == i ? 12 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == i
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
