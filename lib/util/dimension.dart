import 'package:get/get.dart';

class Dimension {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // PIXEL 6 PRO API 30
  // height 843.4285714285714
  // width 411.42857142857144

  static double page70h = screenWidth / (screenWidth / 70);
}
