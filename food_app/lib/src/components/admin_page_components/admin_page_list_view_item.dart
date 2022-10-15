import 'package:flutter/material.dart';

import '../../infrastructure/commons/models/admin_pages_models/admin_pages_view_models.dart';
import '../../infrastructure/utils/image_utils.dart';
import '../../infrastructure/utils/utils.dart';

class AdminPageListItem<T extends AdminPagesItemViewModel>
    extends StatefulWidget {
  final T _viewModel;
  final Future<void> Function(int viewModelId) _deleteButtonOnTap;
  final Future<void> Function(AdminPagesItemViewModel viewModel) _editButtonOnTap;
  final List<Widget> Function(T viewModel) infoLines;

  const AdminPageListItem({
    Key? key,
    required T viewModel,
    required Future<void> Function(int viewModelId) deleteButtonOnTap,
    required Future<void> Function(AdminPagesItemViewModel viewModel) editButtonOnTap,
    required this.infoLines,
  })  : _viewModel = viewModel,
        _deleteButtonOnTap = deleteButtonOnTap,
        _editButtonOnTap = editButtonOnTap,
        super(key: key);

  @override
  State<AdminPageListItem> createState() => _AdminPageListItemState();
}

class _AdminPageListItemState extends State<AdminPageListItem> {
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.infoLines(widget._viewModel),
              ),
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
                  onPressed: () async {
                    await widget._editButtonOnTap(widget._viewModel);
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
