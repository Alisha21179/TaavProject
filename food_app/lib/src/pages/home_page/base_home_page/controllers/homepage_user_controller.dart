import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'homepage_base_controller.dart';

class UserHomePageController extends BaseHomePageController {
  @override
  RxInt bottomNavigationBarCurrentIndex = 1.obs;

  @override
  RxInt? shoppingCartNumber = 0.obs;

  @override
  bool showAppbarShoppingCard = true;

  @override
  final List<Widget> bodyPagesList = [];

  @override
  final List<BottomNavigationBarItem> bottomNavigationBarItems =
      const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_rounded),
      label: 'سفارشات',
      backgroundColor: Colors.red,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'خانه',
      backgroundColor: Colors.red,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'حساب‌من',
      backgroundColor: Colors.red,
    ),
  ];
}
