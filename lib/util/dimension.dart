import 'package:get/get.dart';

class Dimension {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // PIXEL 6 PRO API 30
  // height 843.4285714285714
  // width 411.42857142857144

  static double outtercontainerh = screenHeight / (screenHeight / 350);
  static double outtercontainerw = screenWidth / (screenWidth / 350);

  static double innerpictureh = screenHeight / (screenHeight / 330);
  static double innerpicturew = screenWidth / (screenWidth / 330);

  // height
  static double page8h = screenHeight / (screenHeight / 8);
  static double page10h = screenHeight / (screenHeight / 10);
  static double page12h = screenHeight / (screenHeight / 12);
  static double page15h = screenHeight / (screenHeight / 15);
  static double page20h = screenHeight / (screenHeight / 20);
  static double page35h = screenHeight / (screenHeight / 35);
  static double page40h = screenHeight / (screenHeight / 40);
  static double page50h = screenHeight / (screenHeight / 50);
  static double page70h = screenHeight / (screenHeight / 70);
  static double page150h = screenHeight / (screenHeight / 150);
  static double page170h = screenHeight / (screenHeight / 170);

  // width
  static double page2w = screenWidth / (screenWidth / 2);
  static double page13w = screenWidth / (screenWidth / 13);
  static double page8w = screenWidth / (screenWidth / 8);
  static double page16_8w = screenWidth / (screenWidth / 16.8);
  static double page20w = screenWidth / (screenWidth / 20);
  static double page30w = screenWidth / (screenWidth / 30);
  static double page50w = screenWidth / (screenWidth / 50);
  static double page140w = screenWidth / (screenWidth / 140);
  static double page200w = screenWidth / (screenWidth / 200);

  static double page10r = screenHeight / (screenHeight / 10);
  static double page25r = screenHeight / (screenHeight / 25);
}
