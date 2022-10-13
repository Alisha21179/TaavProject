import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../components/category_page_components/category_list_view_item.dart';
import '../../../../../../../components/search_box.dart';
import '../../../../../../../infrastructure/utils/utils.dart';
import '../controllers/admin_pages_base_controller.dart';

class AdminPagesView<T extends AdminPagesBaseController> extends StatelessWidget {
  AdminPagesView({
    Key? key,
    required T getXController,
  })  : _controller = Get.put(getXController),
        super(key: key);
  final T _controller;

  @override
  Widget build(BuildContext context) {
    // if (T is AdminCategoryPageController) {
    //   _controller = Get.put(AdminCategoryPageController());
    // } else if (T is AdminRestaurantPageController) {
    //   _controller = Get.put(AdminRestaurantPageController());
    // } else if (T is AdminFoodPageController) {
    //   _controller = Get.put(AdminFoodPageController());
    // }
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.4),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        child: const Icon(Icons.add),
        onPressed: () async {
          await _controller.fABOnTap(context);
        },
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _controller.getPageItemList();
      },
      child: Obx(
        () => Column(
          children: [
            Utils.tinyVerticalSpace,
            customSearchBox(
              context,
              advancedButtonOnTap: () {},
              searchBoxValidator: (value) {},
              searchBoxController: _controller.searchBoxController,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(
                  Utils.smallSpace,
                ),
                itemCount: _controller.categoryList.value.length,
                itemBuilder: (context, index) {
                  return CategoryListItem(
                    viewModel: _controller.categoryList.value[index],
                    deleteButtonOnTap: (categoryId) async {
                      await _controller.deleteButtonOnTap(categoryId);
                    },
                    editButtonOnTap: (int categoryId) async {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
