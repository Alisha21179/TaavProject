import 'package:flutter/material.dart';
import 'package:food_app/src/components/admin_page_components/restaurant_food_list_item.dart';

import '../../infrastructure/utils/utils.dart';

class EditRestaurantFoodListDialog extends StatefulWidget {
  final String title;
  final List<RestaurantFoodListItem> children;
  final Future<void> Function(List<RestaurantFoodListItem> foodListItemList)
  submitButtonOnPressed;

  const EditRestaurantFoodListDialog({
    Key? key,
    required this.title,
    required this.children,
    required this.submitButtonOnPressed,
  }) : super(key: key);

  @override
  State<EditRestaurantFoodListDialog> createState() => _EditFoodListDialogState();
}

class _EditFoodListDialogState extends State<EditRestaurantFoodListDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
      children: [
        SizedBox(
          height: 500,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(children: widget.children),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  await widget.submitButtonOnPressed(widget.children);
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
        )
      ],
    );
  }
}
