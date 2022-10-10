import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../infrastructure/commons/models/category_view_model.dart';
import '../../../../../../../infrastructure/utils/image_utils.dart';
import '../models/category_insert_dto.dart';
import '../repositories/category_page_repository.dart';

class CategoriesPageController extends GetxController {
  TextEditingController addCategoryDialogTitleTextField =
      TextEditingController();
  TextEditingController searchBoxController = TextEditingController();
  final CategoryPageRepository repository = CategoryPageRepository();
  final ImagePicker imagePicker = ImagePicker();
  String? categoryListServerProblem;
  String? imageBase64String;
  Rx<List<CategoryViewModel>> categoryList = Rx([]);


  @override
  void onInit() {
    getCategoryList();
    super.onInit();
  }

  Future<void> getCategoryList() async {
    Either<String, List<CategoryViewModel>> result =
        await repository.getCategoryList();
    result.fold(
      (l) {
        categoryListServerProblem = 'مشکل در ارتباط با سرور';
      },
      (r) {
        categoryList.value = r;
        categoryListServerProblem=null;
      },
    );
  }

  Future<bool> addCategoryToServer(
      {required CategoryInsertDTO insertDTO}) async {
    bool addedSuccessFully = false;
    Either<String, bool> result =
        await repository.createNewCategory(insertDTO: insertDTO);
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
          addedSuccessFully = true;
          Get.showSnackbar(
            const GetSnackBar(
              message: 'با موفقیت اضافه شد',
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
    return addedSuccessFully;
  }

  Future<void> addImageInkwellOnTap(
      {required void Function(Uint8List imageBytes) imageBytesHandler}) async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageBase64String = await ImageUtils.xFileToBase64String(
        imageXFile: image,
      );
    } else {
      imageBase64String = null;
    }
  }

  Future<void> dialogSubmitButton(BuildContext context) async {
    bool addedSuccessFully = false;
    if (addCategoryDialogTitleTextField.text.isNotEmpty) {
      CategoryInsertDTO insertDTO = CategoryInsertDTO(
        foodList: [],
        title: addCategoryDialogTitleTextField.text,
        imageBase64String: imageBase64String,
      );
      addedSuccessFully = await addCategoryToServer(insertDTO: insertDTO);
      if(addedSuccessFully){
        getCategoryList();
        Navigator.pop(context);
      }
    }
  }

  String? dialogTitleFieldValidator(String? value){
    if(value == null|| value.trim().isEmpty){
      return 'بدون ورودی چیزی اضافه نمی‌شود';
    }
    if(value.trim().length<3){
      return 'بیشتر از سه حرف وارد کنید';
    }
    return null;
  }
}
