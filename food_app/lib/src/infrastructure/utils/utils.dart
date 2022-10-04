import 'package:flutter/cupertino.dart';

class Utils {
  static const double tinySpace = 4;
  static const double smallSpace = 8;
  static const double mediumSpace = 16;
  static const double largeSpace = 24;
  static const double giantSpace = 32;

  static const SizedBox tinyVerticalSpace =
  SizedBox(height: Utils.tinySpace);
  static const SizedBox smallVerticalSpace =
  SizedBox(height: Utils.smallSpace);
  static const SizedBox mediumVerticalSpace =
  SizedBox(height: Utils.mediumSpace);
  static const SizedBox largeVerticalSpace =
  SizedBox(height: Utils.largeSpace);
  static const SizedBox giantVerticalSpace =
  SizedBox(height: Utils.giantSpace);

  static const SizedBox tinyHorizontalSpace =
  SizedBox(width: Utils.tinySpace);
  static const SizedBox smallHorizontalSpace =
  SizedBox(width: Utils.smallSpace);
  static const SizedBox mediumHorizontalSpace =
  SizedBox(width: Utils.mediumSpace);
  static const SizedBox largeHorizontalSpace =
  SizedBox(width: Utils.largeSpace);
  static const SizedBox giantHorizontalSpace =
  SizedBox(width: Utils.giantSpace);

  static const SizedBox mereSizedBox = SizedBox();
}

class TextFormFieldUtils {
  static const TextStyle textStyleSize20 = TextStyle(
    fontSize: 20,
  );
  static const TextStyle textStyleSize15 = TextStyle(
    fontSize: 15,
  );
}
