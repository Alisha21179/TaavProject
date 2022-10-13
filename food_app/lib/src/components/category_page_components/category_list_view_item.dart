import 'package:flutter/material.dart';
import 'package:food_app/src/infrastructure/commons/models/admin_pages_models/category_view_model.dart';

import '../../infrastructure/utils/image_utils.dart';
import '../../infrastructure/utils/utils.dart';

class CategoryListItem extends StatefulWidget {
  final CategoryViewModel _viewModel;
  final Future<void> Function(int categoryId) _deleteButtonOnTap;
  final Future<void> Function(int categoryId) _editButtonOnTap;

  const CategoryListItem({
    Key? key,
    required CategoryViewModel viewModel,
    required Future<void> Function(int categoryId) deleteButtonOnTap,
    required Future<void> Function(int categoryId) editButtonOnTap,
  })  : _viewModel = viewModel,
        _deleteButtonOnTap = deleteButtonOnTap,
        _editButtonOnTap = editButtonOnTap,
        super(key: key);

  @override
  State<CategoryListItem> createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<CategoryListItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        top: Utils.smallSpace,
        left: Utils.smallSpace,
        right: Utils.smallSpace,
      ),
      child: Row(
        children: [
          widget._viewModel.imageBase64String != null
              ? Container(
                  padding: const EdgeInsets.all(Utils.tinySpace),
                  height: 100,
                  width: 120,
                  child: ImageUtils.base64StringToWidget(
                    base64String: widget._viewModel.imageBase64String!,
                    imageName: widget._viewModel.title,
                    imageReturner: (imageBytes) {
                      return Image.memory(
                        imageBytes,
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(Utils.tinySpace),
                  child: const Icon(
                    Icons.broken_image_outlined,
                    size: 120,
                  ),
                ),
          Utils.smallHorizontalSpace,
          Expanded(
            child: Text(
              widget._viewModel.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await widget._deleteButtonOnTap(widget._viewModel.id);
                  },
                  child: const Icon(Icons.delete_outline),
                ),
                ElevatedButton(
                  onPressed: () async{
                    await widget._editButtonOnTap(widget._viewModel.id);
                  },
                  child: const Icon(Icons.edit),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
