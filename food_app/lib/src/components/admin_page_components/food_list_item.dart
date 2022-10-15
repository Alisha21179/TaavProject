import 'dart:convert';

import 'package:flutter/material.dart';

import '../../infrastructure/commons/models/admin_pages_models/food_view_model.dart';
import '../../infrastructure/utils/utils.dart';

class FoodListItem extends StatefulWidget {
  final FoodViewModel foodViewModel;
  bool foodExistsInTheCategoryList = false;

  FoodListItem({
    Key? key,
    required this.foodViewModel,
    required this.foodExistsInTheCategoryList,
  }) : super(key: key);

  @override
  State<FoodListItem> createState() => _FoodListItemState();
}

class _FoodListItemState extends State<FoodListItem> {
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
      height: 70,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 60,
                child: widget.foodViewModel.imageBase64String != null
                    ? Image.memory(
                        base64Decode(widget.foodViewModel.imageBase64String!),
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
                value: widget.foodExistsInTheCategoryList,
                onChanged: (value) {
                  widget.foodExistsInTheCategoryList =
                      !widget.foodExistsInTheCategoryList;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
