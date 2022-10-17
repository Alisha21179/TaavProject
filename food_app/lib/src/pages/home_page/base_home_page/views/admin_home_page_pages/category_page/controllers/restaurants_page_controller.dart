import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:food_app/src/pages/home_page/base_home_page/views/admin_home_page_pages/category_page/models/restaurant_page_models/restaurant_edit_dto.dart';
import 'package:food_app/src/pages/home_page/base_home_page/views/admin_home_page_pages/category_page/models/restaurant_page_models/restaurant_food_view_model.dart';
import 'package:get/get.dart';

import '../../../../../../../components/admin_page_components/edit_food_list_dialog.dart';
import '../../../../../../../components/admin_page_components/edit_restaurant_food_list_dialog.dart';
import '../../../../../../../components/admin_page_components/food_list_item.dart';
import '../../../../../../../components/admin_page_components/restaurant_food_list_item.dart';
import '../../../../../../../components/text_form_field.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/admin_pages_view_models.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/food_view_model.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/restaurant_view_model.dart';
import '../../../../../../../infrastructure/utils/utils.dart';
import '../models/admin_page_base_insert_dto.dart';
import '../models/restaurant_page_models/restaurant_insert_dto.dart';
import '../repositories/admin_page_base_repository.dart';
import '../repositories/food_page_repository.dart';
import '../repositories/restaurant_page_repository.dart';
import 'admin_pages_base_controller.dart';

class AdminRestaurantPageController extends AdminPagesBaseController {
  @override
  TextEditingController searchBoxController = TextEditingController();

  @override
  AdminPagesBaseRepository repository = RestaurantPageRepository();

  final FoodPageRepository _foodPageRepository = FoodPageRepository();

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
  Future<void> addNewItemDialogSubmitButton(
    BuildContext context, {
    required AdminPageBaseInsertDTO insertDTO,
  }) async {
    bool addedSuccessFully = false;
    RestaurantInsertDTO restaurantInsertDTO = insertDTO as RestaurantInsertDTO;
    if (restaurantInsertDTO.title.trim().isNotEmpty &&
        restaurantInsertDTO.restaurantAddress.trim().isNotEmpty &&
        restaurantInsertDTO.restaurantOwnerName.trim().isNotEmpty) {
      addedSuccessFully = await addItemToServer(
        insertDTO: restaurantInsertDTO,
      );
      if (addedSuccessFully) {
        getPageItemList();
        Navigator.pop(context);
      }
    }
  }

  @override
  Future<void> fABOnTapAddNewItem(BuildContext context) async {
    TextEditingController insideAddItemDialogTitleTextFieldController =
        TextEditingController();
    TextEditingController dialogAddressController = TextEditingController();
    TextEditingController dialogOwnerController = TextEditingController();
    List<Map<String, dynamic>> insideAddRestaurantDialogFoodList = [];
    RxnString insideImageBase64String = RxnString(null);
    customShowDialog(
      context,
      title: const Text('افزودن رستوران'),
      children: [
        customTextFormField(
          labelText: 'نام رستوران',
          textInputAction: TextInputAction.done,
          controller: insideAddItemDialogTitleTextFieldController,
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
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              List<RestaurantFoodViewModel> myList =
                  await editFoodListButtonOnTap();
              insideAddRestaurantDialogFoodList =
                  myList.map((e) => e.toJson()).toList();
            },
            child: const Text('مدیریت لیست غذا'),
          ),
        ),
        Utils.smallVerticalSpace,
        Obx(
          () => InkWell(
            splashColor: Theme.of(context).primaryColor,
            onTap: () async {
              insideImageBase64String.value = await addImageInkwellOnTap();
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
                  'افزودن تصویر دسته‌بندی',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const Expanded(child: Utils.mereSizedBox),
                SizedBox(
                  height: 40,
                  child: insideImageBase64String.value != null
                      ? Image.memory(
                          base64Decode(insideImageBase64String.value!),
                          fit: BoxFit.fitHeight,
                        )
                      : Icon(
                          Icons.broken_image_outlined,
                          size: 40,
                          color: Theme.of(context).primaryColor,
                        ),
                ),
              ],
            ),
          ),
        ),
        Utils.mediumVerticalSpace,
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  await addNewItemDialogSubmitButton(
                    context,
                    insertDTO: RestaurantInsertDTO(
                      title: insideAddItemDialogTitleTextFieldController.text,
                      restaurantAddress: dialogAddressController.text,
                      restaurantOwnerName: dialogOwnerController.text,
                      restaurantFoodList: insideAddRestaurantDialogFoodList,
                      restaurantBase64Image: insideImageBase64String.value,
                    ),
                  );
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

  Future<List<RestaurantFoodViewModel>> editFoodListButtonOnTap(
      [RestaurantViewModel? viewModel]) async {
    List<FoodViewModel> foodList = await getFoodList();
    List<RestaurantFoodViewModel> restaurantMapFoodList = viewModel != null
        ? viewModel.foodList.map(
            (e) {
              return RestaurantFoodViewModel.fromJson(json: e);
            },
          ).toList()
        : [];
    List<RestaurantFoodViewModel> returningRestaurantMapFoodList =
        await Get.dialog(
      EditRestaurantFoodListDialog(
        title: 'مدیریت لیست غذا',
        submitButtonOnPressed:
            (List<RestaurantFoodListItem> foodListItemList) async {
          List<RestaurantFoodViewModel> returningFoodListItemList =
              listOfValidatedSelected(foodListItemList);
          Get.back(result: returningFoodListItemList);
        },
        children: List<RestaurantFoodListItem>.generate(
          foodList.length,
          (index) {
            bool foodExistsInTheRestaurantFoodList = false;
            String? foodPrice;
            for (RestaurantFoodViewModel item in restaurantMapFoodList) {
              if (foodList[index].title == item.title) {
                foodExistsInTheRestaurantFoodList = true;
                foodPrice = item.foodPrice;
                break;
              }
            }
            return RestaurantFoodListItem(
              foodViewModel: foodList[index],
              foodExistsInTheViewModelList: foodExistsInTheRestaurantFoodList,
              priceController: foodExistsInTheRestaurantFoodList
                  ? TextEditingController(text: foodPrice)
                  : null,
            );
          },
        ),
      ),
    );
    return returningRestaurantMapFoodList;
  }

  Future<List<FoodViewModel>> getFoodList() async {
    List<FoodViewModel> foodList = [];
    Either<String, List<AdminPagesItemViewModel>> result =
        await _foodPageRepository.getItemList();
    result.fold(
      (l) => null,
      (r) {
        r as List<FoodViewModel>;
        foodList = r;
        itemListServerProblem = null;
      },
    );
    return foodList;
  }

  List<RestaurantFoodViewModel> listOfValidatedSelected(
    List<RestaurantFoodListItem> foodListItemList,
  ) {
    List<RestaurantFoodViewModel> returningFoodListItemList = [];
    for (RestaurantFoodListItem item in foodListItemList) {
      if (item.foodExistsInTheViewModelList &&
          item.mainFormKey.currentState!.validate()) {
        RestaurantFoodViewModel restaurantFood2ViewModel =
            RestaurantFoodViewModel(
          foodName: item.foodViewModel.title,
          foodIngredient: item.foodViewModel.foodIngredient,
          foodPrice: item.price.text,
          foodBase64Image: item.foodViewModel.imageBase64String,
        );
        returningFoodListItemList.add(restaurantFood2ViewModel);
      }
    }
    return returningFoodListItemList;
  }

  @override
  Future<void> editOnTap(
    BuildContext context, {
    required AdminPagesItemViewModel viewModel,
  }) async {
    RestaurantViewModel restaurantViewModel = viewModel as RestaurantViewModel;
    TextEditingController editItemDialogTitleController =
        TextEditingController(text: restaurantViewModel.title);
    TextEditingController editAddressController =
        TextEditingController(text: restaurantViewModel.restaurantAddress);
    TextEditingController editOwnerNameController =
        TextEditingController(text: restaurantViewModel.restaurantOwnerName);
    Rxn<String> editDialogImageBase64 =
        Rxn(restaurantViewModel.imageBase64String);
    List<dynamic> editDialogFoodList = restaurantViewModel.foodList;
    customShowDialog(
      context,
      title: const Text('افزودن رستوران'),
      children: [
        customTextFormField(
          labelText: 'نام رستوران',
          textInputAction: TextInputAction.done,
          controller: editItemDialogTitleController,
          validator: dialogTitleFieldValidator,
          autoValidateMode: AutovalidateMode.onUserInteraction,
        ),
        Utils.smallVerticalSpace,
        customTextFormField(
          labelText: 'نام صاحب رستوران',
          textInputAction: TextInputAction.done,
          controller: editOwnerNameController,
          validator: dialogTitleFieldValidator,
          autoValidateMode: AutovalidateMode.onUserInteraction,
        ),
        Utils.smallVerticalSpace,
        customTextFormField(
          labelText: 'آدرس رستوران',
          textInputAction: TextInputAction.done,
          controller: editAddressController,
          validator: dialogTitleFieldValidator,
          autoValidateMode: AutovalidateMode.onUserInteraction,
        ),
        Utils.smallVerticalSpace,
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              List<RestaurantFoodViewModel> myList =
                  await editFoodListButtonOnTap(restaurantViewModel);
              editDialogFoodList = myList.map((e) => e.toJson()).toList();
            },
            child: const Text('مدیریت لیست غذا'),
          ),
        ),
        Utils.smallVerticalSpace,
        Obx(
          () => InkWell(
            splashColor: Theme.of(context).primaryColor,
            onTap: () async {
              String? chosenImageBase64;
              chosenImageBase64 = await addImageInkwellOnTap();
              if (chosenImageBase64 != null) {
                editDialogImageBase64.value = chosenImageBase64;
              }
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
                  'ویرایش تصویر دسته‌بندی',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const Expanded(child: Utils.mereSizedBox),
                SizedBox(
                  height: 40,
                  child: editDialogImageBase64.value != null
                      ? Image.memory(
                          base64Decode(editDialogImageBase64.value!),
                          fit: BoxFit.fitHeight,
                        )
                      : Icon(
                          Icons.broken_image_outlined,
                          size: 40,
                          color: Theme.of(context).primaryColor,
                        ),
                ),
              ],
            ),
          ),
        ),
        Utils.mediumVerticalSpace,
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  RestaurantEditDTO restaurantEditDTO = RestaurantEditDTO(
                    restaurantOwnerName: editOwnerNameController.text,
                    restaurantAddress: editAddressController.text,
                    foodList: editDialogFoodList,
                    title: editItemDialogTitleController.text,
                    imageBase64String: editDialogImageBase64.value,
                  );
                  await editDialogSubmitButtonOnTap(
                    restaurantId: restaurantViewModel.id,
                    editDTO: restaurantEditDTO,
                  );
                  await getPageItemList();
                  Navigator.pop(context);
                },
                child: const Text('ثبت'),
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

  Future<void> editDialogSubmitButtonOnTap({
    required int restaurantId,
    required RestaurantEditDTO editDTO,
  }) async {
    Either<String, bool> result = await repository.editAdminItemInServer(
      adminItemId: restaurantId,
      editDTO: editDTO,
    );
    result.fold(
      (l) {
        Get.showSnackbar(
          const GetSnackBar(
            message: 'مشکل در افزودن در پایگاه داده',
            duration: Duration(seconds: 2),
            backgroundGradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.redAccent,
                Colors.deepOrange,
                Colors.deepOrangeAccent,
                Colors.orange,
                Colors.amber,
              ],
            ),
          ),
        );
      },
      (r) {
        if (r) {
          Get.showSnackbar(
            const GetSnackBar(
              message: 'با موفقیت ثبت شد',
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          Get.showSnackbar(
            const GetSnackBar(
              message: 'با مشکل مواجه شد',
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
    );
  }
}
