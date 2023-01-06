import 'package:get/get.dart';

class Dimension {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // PIXEL 6 PRO API 30
  // height 843.4285714285714
  // width 411.42857142857144

  static double page20h = screenHeight / (screenHeight / 20);
  static double page40h = screenHeight / (screenHeight / 40);
  static double page50h = screenHeight / (screenHeight / 50);
  static double page70h = screenHeight / (screenHeight / 70);

  static double page8w = screenWidth / (screenWidth / 8);
  static double page20w = screenWidth / (screenWidth / 20);
  static double page50w = screenWidth / (screenWidth / 50);
}
