import 'package:flutter/material.dart';
import 'package:food_app/src/pages/home_page/base_home_page/views/admin_home_page_pages/category_page/models/restaurant_page_models/restaurant_insert_dto.dart';
import 'package:food_app/src/pages/home_page/base_home_page/views/admin_home_page_pages/category_page/repositories/admin_page_base_repository.dart';
import 'package:food_app/src/pages/home_page/base_home_page/views/admin_home_page_pages/category_page/repositories/restaurant_page_repository.dart';
import 'package:get/get.dart';

import '../../../../../../../components/text_form_field.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/admin_pages_view_models.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/restaurant_view_model.dart';
import '../../../../../../../infrastructure/utils/utils.dart';
import 'admin_pages_base_controller.dart';

class AdminRestaurantPageController extends AdminPagesBaseController {
  @override
  TextEditingController searchBoxController = TextEditingController();
  TextEditingController dialogAddressController = TextEditingController();
  TextEditingController dialogOwnerController = TextEditingController();

  @override
  AdminPagesBaseRepository repository = RestaurantPageRepository();

  @override
  List<Widget> Function(AdminPagesItemViewModel viewModel) infoLines =
      (viewModel) {
    viewModel as RestaurantViewModel;
    return [
      Text(
        viewModel.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      Utils.smallVerticalSpace,
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const Text('مدیریت: '),
            Text(viewModel.restaurantOwnerName),
          ],
        ),
      ),
      Utils.smallVerticalSpace,
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const Text('آدرس: '),
            Text(viewModel.restaurantAddress),
          ],
        ),
      ),
    ];
  };

  @override
  Future<void> dialogSubmitButton(BuildContext context) async {
    bool addedSuccessFully = false;
    if (addItemDialogTitleTextFieldController.text.trim().isNotEmpty &&
        dialogAddressController.text.trim().isNotEmpty &&
        dialogOwnerController.text.trim().isNotEmpty) {
      RestaurantInsertDTO insertDTO = RestaurantInsertDTO(
        title: addItemDialogTitleTextFieldController.text,
        restaurantBase64Image: imageBase64String,
        restaurantAddress: dialogAddressController.text,
        restaurantOwnerName: dialogOwnerController.text,
        restaurantFoodList: [],
      );
      addedSuccessFully = await addItemToServer(insertDTO: insertDTO);
      if (addedSuccessFully) {
        getPageItemList();
        Navigator.pop(context);
      }
    }
  }

  @override
  Future<void> fABOnTap(BuildContext context) async {
    imageBase64String = null;
    customShowDialog(
      context,
      beforeCallingDialog: () {
        addItemDialogTitleTextFieldController.text = '';
        dialogAddressController.text = '';
        dialogOwnerController.text = '';
      },
      title: const Text('افزودن رستوران'),
      children: [
        customTextFormField(
          labelText: 'نام رستوران',
          textInputAction: TextInputAction.done,
          controller: addItemDialogTitleTextFieldController,
          validator: dialogTitleFieldValidator,
          autoValidateMode: AutovalidateMode.onUserInteraction,
        ),
        Utils.smallVerticalSpace,
        customTextFormField(
          labelText: 'نام صاحب رستوران',
          textInputAction: TextInputAction.done,
          controller: dialogOwnerController,
          validator: dialogTitleFieldValidator,
          autoValidateMode: AutovalidateMode.onUserInteraction,
        ),
        Utils.smallVerticalSpace,
        customTextFormField(
          labelText: 'آدرس رستوران',
          textInputAction: TextInputAction.done,
          controller: dialogAddressController,
          validator: dialogTitleFieldValidator,
          autoValidateMode: AutovalidateMode.onUserInteraction,
        ),
        Utils.smallVerticalSpace,
        InkWell(
          splashColor: Theme.of(context).primaryColor,
          onTap: () async {
            await addImageInkwellOnTap(
              imageBytesHandler: (imageBytes) {},
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.image,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
              Utils.smallHorizontalSpace,
              const Text(
                'افزودن تصویر رستوران',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
        ),
        Utils.mediumVerticalSpace,
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  await dialogSubmitButton(context);
                },
                child: const Text('افزودن'),
              ),
            ),
            Utils.mediumHorizontalSpace,
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('لغو'),
              ),
            )
          ],
        ),
      ],
    );
  }
}
