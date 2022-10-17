import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../components/admin_page_components/admin_page_list_view_item.dart';
import '../../../../../../../components/search_box.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/admin_pages_view_models.dart';
import '../../../../../../../infrastructure/utils/utils.dart';
import '../controllers/admin_pages_base_controller.dart';

class AdminPagesView<T extends AdminPagesBaseController>
    extends StatelessWidget {
  AdminPagesView({
    Key? key,
    required T getXController,
  })  : _controller = Get.put(getXController),
        super(key: key);
  final T _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.4),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        child: const Icon(Icons.add),
        onPressed: () async {
          await _controller.fABOnTapAddNewItem(context);
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
                itemCount: _controller.itemList.value.length,
                itemBuilder: (context, index) {
                  return AdminPageListItem(
                    viewModel: _controller.itemList.value[index],
                    deleteButtonOnTap: (viewModelId) async {
                      await Get.dialog(
                        await _deleteItemAlertDialog(
                          context,
                          viewModelId: viewModelId,
                        ),
                      );
                    },
                    editButtonOnTap: (AdminPagesItemViewModel viewModel) async {
                      await _controller.editOnTap(context,
                          viewModel: viewModel);
                    },
                    infoLines: _controller.infoLines,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Widget> _deleteItemAlertDialog(BuildContext context,
      {required int viewModelId}) async {
    return AlertDialog(
      title: Text(
        'از حذف این مورد اطمینان دارید؟',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(08),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    await _controller.deleteButtonOnTap(viewModelId);
                    Get.back();
                    _controller.getPageItemList();
                  },
                  child: const Text('بله'),
                ),
              ),
              Utils.smallHorizontalSpace,
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('خیر'),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
