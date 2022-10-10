import 'package:flutter/material.dart';
import 'package:food_app/src/infrastructure/commons/models/category_view_model.dart';

import '../../infrastructure/utils/image_utils.dart';
import '../../infrastructure/utils/utils.dart';

class CategoryListItem extends StatefulWidget {
  final CategoryViewModel _viewModel;

  const CategoryListItem({Key? key, required CategoryViewModel viewModel})
      : _viewModel = viewModel,
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
      child: Expanded(
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
                      imageReturner: (imageBytes, imageFile) {
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
            Text(widget._viewModel.title,style: Theme.of(context).textTheme.titleMedium,),
          ],
        ),
      ),
    );
  }
}
