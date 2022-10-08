import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseHomePageController extends GetxController{
  abstract final List<BottomNavigationBarItem> bottomNavigationBarItems;
  abstract RxInt bottomNavigationBarCurrentIndex;
  abstract final bool showAppbarShoppingCard;
  abstract RxInt? shoppingCartNumber;
  abstract final List<Widget> bodyPagesList;
}