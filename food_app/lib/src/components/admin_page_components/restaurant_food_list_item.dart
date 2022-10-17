import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../infrastructure/commons/models/admin_pages_models/food_view_model.dart';
import '../../infrastructure/utils/utils.dart';

class RestaurantFoodListItem extends StatefulWidget {
  TextEditingController price;
  final GlobalKey<FormState> mainFormKey = GlobalKey<FormState>();
  final FoodViewModel foodViewModel;
  bool foodExistsInTheViewModelList;

  RestaurantFoodListItem({
    Key? key,
    required this.foodViewModel,
    required this.foodExistsInTheViewModelList,
    TextEditingController? priceController,
  })  : price = priceController ?? TextEditingController(),
        super(key: key);

  @override
  State<RestaurantFoodListItem> createState() => _FoodListItemState();
}

class _FoodListItemState extends State<RestaurantFoodListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(71, 1, 1, 1),
            offset: Offset(0, 0),
            blurRadius: 10,
          ),
        ],
      ),
      height: 150,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      child: widget.foodViewModel.imageBase64String != null
                          ? Image.memory(
                              base64Decode(
                                  widget.foodViewModel.imageBase64String!),
                              fit: BoxFit.fitWidth,
                            )
                          : Icon(
                              Icons.broken_image_outlined,
                              size: 50,
                              color: Theme.of(context).primaryColor,
                            ),
                    ),
                    Utils.smallHorizontalSpace,
                    Text(widget.foodViewModel.title),
                    const Expanded(child: Utils.mereSizedBox),
                    Checkbox(
                      value: widget.foodExistsInTheViewModelList,
                      onChanged: (value) {
                        widget.foodExistsInTheViewModelList =
                            !widget.foodExistsInTheViewModelList;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                Form(
                  key: widget.mainFormKey,
                  child: TextFormField(
                    controller: widget.price,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (widget.foodExistsInTheViewModelList) {
                        if (widget.price.text.trim().isEmpty) {
                          return 'قیمت برای غذای انتخاب شده الزامی میباشد';
                        }
                        if (widget.price.text.trim().length < 3) {
                          return 'قیمت به نا معقول میباشد';
                        }
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'قیمت(تومان)',
                        labelStyle: TextStyle(fontSize: 15),
                        isDense: true),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
