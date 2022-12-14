import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:food_app/food_app.dart';
import 'package:get/get.dart';

import '../../../../../../../components/admin_page_components/edit_food_list_dialog.dart';
import '../../../../../../../components/admin_page_components/food_list_item.dart';
import '../../../../../../../components/text_form_field.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/admin_pages_view_models.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/category_view_model.dart';
import '../../../../../../../infrastructure/commons/models/admin_pages_models/food_view_model.dart';
import '../../../../../../../infrastructure/utils/utils.dart';
import '../models/admin_page_base_insert_dto.dart';
import '../models/category_page_models/category_edit_dto.dart';
import '../models/category_page_models/category_insert_dto.dart';
import '../repositories/admin_page_base_repository.dart';
import '../repositories/category_page_repository.dart';
import '../repositories/food_page_repository.dart';
import 'admin_pages_base_controller.dart';

class AdminCategoryPageController extends AdminPagesBaseController {
  @override
  TextEditingController searchBoxController = TextEditingController();

  @override
  AdminPagesBaseRepository repository = CategoryPageRepository();

  final FoodPageRepository _foodPageRepository = FoodPageRepository();

  @override
  List<Widget> Function(AdminPagesItemViewModel viewModel) infoLines =
      (viewModel) {
    viewModel as CategoryViewModel;
    return [
      Text(
        viewModel.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
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
    CategoryInsertDTO insideInsertDTO = insertDTO as CategoryInsertDTO;
    if (insertDTO.title.trim().isNotEmpty) {
      addedSuccessFully = await addItemToServer(insertDTO: insideInsertDTO);
      if (addedSuccessFully) {
        getPageItemList();
        // Navigator.pop(context);
        await Get.offNamedUntil(
            FoodAppPageRoutes.adminHomePage, (route) => true);
      }
    }
  }

  @override
  Future<void> fABOnTapAddNewItem(BuildContext context) async {
    TextEditingController insideAddItemDialogTitleTextFieldController=TextEditingController();
    List<Map<String, dynamic>> insideAddCategoryDialogFoodList = [];
    RxnString insideImageBase64String = RxnString(null);
    customShowDialog(
      context,
      title: const Text('???????????? ???????????????????'),
      children: [
        customTextFormField(
          labelText: '?????????? ???????? ????????',
          textInputAction: TextInputAction.done,
          controller: insideAddItemDialogTitleTextFieldController,
          validator: dialogTitleFieldValidator,
          autoValidateMode: AutovalidateMode.onUserInteraction,
        ),
        Utils.smallVerticalSpace,
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              List<FoodViewModel> myList = await editFoodListButtonOnTap();
              insideAddCategoryDialogFoodList =
                  myList.map((e) => e.toJson()).toList();
            },
            child: const Text('???????????? ???????? ??????'),
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
                  '???????????? ?????????? ???????????????????',
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
                    insertDTO: CategoryInsertDTO(
                      foodList: insideAddCategoryDialogFoodList,
                      title: insideAddItemDialogTitleTextFieldController.text,
                      imageBase64String: insideImageBase64String.value,
                    ),
                  );
                },
                child: const Text('????????????'),
              ),
            ),
            Utils.mediumHorizontalSpace,
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('??????'),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Future<void> editOnTap(
    BuildContext context, {
    required AdminPagesItemViewModel viewModel,
  }) async {
    CategoryViewModel categoryViewModel = viewModel as CategoryViewModel;
    TextEditingController editItemDialogTitleController =
        TextEditingController(text: categoryViewModel.title);
    Rxn<String> editDialogImageBase64 =
        Rxn(categoryViewModel.imageBase64String);
    List<dynamic> editDialogFoodList = categoryViewModel.foodList;
    customShowDialog(
      context,
      title: const Text('???????????? ??????????????????? '),
      children: [
        customTextFormField(
          labelText: '?????????? ???????? ????????',
          textInputAction: TextInputAction.done,
          controller: editItemDialogTitleController,
          validator: dialogTitleFieldValidator,
          autoValidateMode: AutovalidateMode.onUserInteraction,
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
                  '???????????? ?????????? ???????????????????',
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
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              List<FoodViewModel> myList =
                  await editFoodListButtonOnTap(categoryViewModel);
              editDialogFoodList = myList.map((e) => e.toJson()).toList();
            },
            child: const Text('???????????? ???????? ??????'),
          ),
        ),
        Utils.mediumVerticalSpace,
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  CategoryEditDTO editDTO = CategoryEditDTO(
                    foodList: editDialogFoodList,
                    title: editItemDialogTitleController.text,
                    imageBase64String: editDialogImageBase64.value,
                  );
                  await editDialogSubmitButtonOnTap(
                    categoryId: categoryViewModel.id,
                    editDTO: editDTO,
                  );
                  await getPageItemList();
                  Navigator.pop(context);
                },
                child: const Text('??????'),
              ),
            ),
            Utils.mediumHorizontalSpace,
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('??????'),
              ),
            )
          ],
        ),
      ],
    );
  }

  Future<void> editDialogSubmitButtonOnTap(
      {required int categoryId, required CategoryEditDTO editDTO}) async {
    Either<String, bool> result = await repository.editAdminItemInServer(
      adminItemId: categoryId,
      editDTO: editDTO,
    );
    result.fold(
      (l) {
        Get.showSnackbar(
          const GetSnackBar(
            message: '???????? ???? ???????????? ???? ???????????? ????????',
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
              message: '???? ???????????? ?????? ????',
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          Get.showSnackbar(
            const GetSnackBar(
              message: '???? ???????? ?????????? ????',
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
    );
  }

  Future<List<FoodViewModel>> editFoodListButtonOnTap(
      [CategoryViewModel? viewModel]) async {
    List<FoodViewModel> foodList = await getFoodList();
    List<FoodViewModel> categoryMapFoodList = viewModel != null
        ? viewModel.foodList.map(
            (e) {
              return FoodViewModel.fromJson(json: e);
            },
          ).toList()
        : [];
    /*wholeFoodList = */
    categoryMapFoodList = await Get.dialog(
      EditFoodListDialog(
        title: '???????????? ???????? ??????',
        children: List.generate(
          foodList.length,
          (index) {
            bool foodExistsInTheCategoryList = false;
            if (categoryMapFoodList
                .map(
                  (e) {
                    return e.title;
                  },
                )
                .toList()
                .contains(
                  foodList[index].title,
                )) {
              foodExistsInTheCategoryList = true;
            }
            return FoodListItem(
              foodViewModel: foodList[index],
              foodExistsInTheViewModelList: foodExistsInTheCategoryList,
            );
          },
        ),
        submitButtonOnPressed: (List<FoodListItem> foodListItemList) async {
          List<FoodViewModel> returningFoodListItemList =
              listOfSelected(foodListItemList);
          Get.back(result: returningFoodListItemList);
        },
      ),
    );
    return categoryMapFoodList;
  }

  List<FoodViewModel> listOfSelected(
    List<FoodListItem> foodListItemList,
  ) {
    List<FoodViewModel> returningFoodListItemList = [];
    for (FoodListItem item in foodListItemList) {
      if (item.foodExistsInTheViewModelList) {
        returningFoodListItemList.add(item.foodViewModel);
      }
    }
    return returningFoodListItemList;
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
}
