import 'package:flutter/material.dart';
import 'package:food_app/food_app.dart' as food_app;
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('fa','IR'),
      theme: food_app.mainTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: food_app.FoodAppPageRoutes.splashPage,
      getPages: food_app.pages,
    );
  }
}
