import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/admin_home_page_pages/category_page/views/categories_page_view.dart';
import 'homepage_base_controller.dart';

class AdminHomePageController extends BaseHomePageController {
  @override
  RxInt bottomNavigationBarCurrentIndex = 0.obs;

  @override
  RxInt? shoppingCartNumber;

  @override
  final bool showAppbarShoppingCard = false;

  @override
  final List<Widget> bodyPagesList = [CategoriesPageView()];

  @override
  final List<BottomNavigationBarItem> bottomNavigationBarItems =
      const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'دسته‌بندی‌ها',
      backgroundColor: Colors.red,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.restaurant_menu),
      label: 'رستوران‌ها',
      backgroundColor: Colors.red,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.restaurant),
      label: 'غذاها',
      backgroundColor: Colors.red,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'حساب‌من',
      backgroundColor: Colors.red,
    ),
  ];
}
