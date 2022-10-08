import 'package:flutter/material.dart';
import 'package:food_app/src/components/background_stack.dart';
import 'package:get/get.dart';

import '../controllers/homepage_base_controller.dart';

class BaseHomePageView<T extends BaseHomePageController> extends GetView<T> {
  const BaseHomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BackgroundStack(
        appbar: _appBar(),
        widgetList: [
          _bodyList(),
        ],
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    );
  }

  Widget _bodyList() {
    return IndexedStack(
          index: controller.bottomNavigationBarCurrentIndex.value,
          children: controller.bodyPagesList,
        );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      actions: controller.showAppbarShoppingCard
          ? [
              _appBarShoppingCart(),
            ]
          : null,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_back_ios_rounded),
      ),
    );
  }

  Widget _appBarShoppingCart() {
    return Obx(
      () => Row(
        children: [
          Text('${controller.shoppingCartNumber}'),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_rounded),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      backgroundColor: Colors.red,
      selectedItemColor: Colors.white,
      showUnselectedLabels: false,
      currentIndex: controller.bottomNavigationBarCurrentIndex.value,
      items: controller.bottomNavigationBarItems,
      onTap: (value) {
        controller.bottomNavigationBarCurrentIndex.value = value;
      },
    );
  }
}
