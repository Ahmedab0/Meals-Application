import 'package:flutter/material.dart';
import 'package:meal_app/provider/meal_provider.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String imgUrl;
  final String title;
  final int price;
  final int counter;

  const CartItem(
      {super.key,
      required this.id,
      required this.imgUrl,
      required this.title,
      required this.price,
      required this.counter});

  @override
  Widget build(BuildContext context) {
    var dw = MediaQuery.of(context).size.width;
    var theme = Provider.of<ThemeProvider>(context);
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Dismissible(
      key: Key(id),
      onDismissed: (DismissDirection dir){},
      background: Container(
        color: Colors.redAccent,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.delete,color: Colors.white70,size: 30,),
            SizedBox(width: 16,),
            Text('Delete',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white70),),
          ],
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        //color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              //section Image
              SizedBox(
                width: isLandScape? dw * 0.18: dw * 0.35,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                    width: isLandScape? dw * 0.18: dw * 0.35,
                    height: isLandScape? dw * 0.18 : dw * 0.25,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),

              //section Title
              SizedBox(
                width: isLandScape? dw * 0.20: dw * 0.43,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.subHeader,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$price \$',
                        style: theme.subHeader,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),

              //section Counter
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 22,
                      height: 22,
                      child: Consumer<MealProvider>(
                        builder: (context, value, child) => IconButton(
                          onPressed: () => value.decrement(),
                          icon: const Icon(
                            Icons.remove,
                            size: 22,
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(0)),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).colorScheme.secondary),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)))),
                        ),
                      ),
                    ),
                    // Counter
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 2),
                      child: Consumer<MealProvider>(
                        builder: (context, value, child) => Text(
                          value.counter.toString(),
                          textAlign: TextAlign.center,
                          style:
                              theme.titleSmall.copyWith(color: (theme.tm == ThemeMode.dark)? Colors.white70: Colors.black54),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 22,
                      height: 22,
                      child: Builder(builder: (ctx) {
                        return IconButton(
                          key: Key(id),
                          onPressed: () => ctx.read<MealProvider>().increment(),
                          icon: const Icon(
                            Icons.add,
                            size: 22,
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(0)),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(ctx).colorScheme.secondary),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),),),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
