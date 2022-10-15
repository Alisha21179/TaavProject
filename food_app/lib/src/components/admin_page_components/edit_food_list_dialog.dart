import 'package:flutter/material.dart';

import '../../infrastructure/utils/utils.dart';
import 'food_list_item.dart';

class EditFoodListDialog extends StatefulWidget {
  final String title;
  final List<FoodListItem> children;
  final Future<void> Function(List<FoodListItem> foodListItemList) submitButtonOnPressed;

  const EditFoodListDialog({
    Key? key,
    required this.title,
    required this.children,
    required this.submitButtonOnPressed,
  }) : super(key: key);

  @override
  State<EditFoodListDialog> createState() => _EditFoodListDialogState();
}

class _EditFoodListDialogState extends State<EditFoodListDialog> {
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
                onPressed: () async{
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
