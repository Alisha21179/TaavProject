import 'package:flutter/material.dart';
import 'package:food_app/src/pages/home_page/base_home_page/views/admin_home_page_pages/category_page/controllers/food_page_controller.dart';
import 'package:food_app/src/pages/home_page/base_home_page/views/admin_home_page_pages/category_page/controllers/restaurants_page_controller.dart';
import 'package:get/get.dart';

import '../views/admin_home_page_pages/category_page/controllers/admin_pages_base_controller.dart';
import '../views/admin_home_page_pages/category_page/controllers/category_page_controller.dart';
import '../views/admin_home_page_pages/category_page/views/admin_pages_view.dart';
import 'homepage_base_controller.dart';

class AdminHomePageController extends BaseHomePageController {
  @override
  RxInt bottomNavigationBarCurrentIndex = 0.obs;

  @override
  RxInt? shoppingCartNumber;

  @override
  final bool showAppbarShoppingCard = false;

  @override
  final List<Widget> bodyPagesList = [
    AdminPagesView<AdminCategoryPageController>(
      getXController: AdminCategoryPageController(),
    ),
    AdminPagesView<AdminRestaurantPageController>(
      getXController: AdminRestaurantPageController(),
    ),
    AdminPagesView<AdminFoodPageController>(
      getXController: AdminFoodPageController(),
    ),
  ];

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
