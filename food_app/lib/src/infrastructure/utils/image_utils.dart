import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  static Future<String?> xFileToBase64String(
      {required XFile imageXFile}) async {
    String? base64String;
    Uint8List bytes = await imageXFile.readAsBytes();
    base64String = base64.encode(bytes);
    return base64String;
  }

  static Widget base64StringToWidget({
    required String base64String,
    required Image Function(Uint8List imageBytes,) imageReturner,
  }) {
    Uint8List bytes = base64.decode(base64String);
    Image image = imageReturner(bytes);
    return image;
  }
}
