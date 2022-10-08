import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/categories_page_controller.dart';

class CategoriesPageView extends StatelessWidget {
  CategoriesPageView({Key? key}) : super(key: key);

  final CategoriesPageController _controller = Get.put(
    CategoriesPageController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.4),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
