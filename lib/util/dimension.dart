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
  static double page30h = screenHeight / (screenHeight / 30);
  static double page35h = screenHeight / (screenHeight / 35);
  static double page40h = screenHeight / (screenHeight / 40);
  static double page50h = screenHeight / (screenHeight / 50);
  static double page60h = screenHeight / (screenHeight / 60);
  static double page70h = screenHeight / (screenHeight / 70);
  static double page90h = screenHeight / (screenHeight / 90);
  static double page100h = screenHeight / (screenHeight / 100);
  static double page150h = screenHeight / (screenHeight / 150);
  static double page170h = screenHeight / (screenHeight / 170);
  static double page180h = screenHeight / (screenHeight / 180);
  static double page300h = screenHeight / (screenHeight / 300);
  static double page490h = screenHeight / (screenHeight / 490);
  static double page550h = screenHeight / (screenHeight / 550);

  // width
  static double page1w = screenWidth / (screenWidth / 1);
  static double page2w = screenWidth / (screenWidth / 2);
  static double page10w = screenWidth / (screenWidth / 10);
  static double page13w = screenWidth / (screenWidth / 13);
  static double page8w = screenWidth / (screenWidth / 8);
  static double page16_8w = screenWidth / (screenWidth / 16.8);
  static double page20w = screenWidth / (screenWidth / 20);
  static double page30w = screenWidth / (screenWidth / 30);
  static double page50w = screenWidth / (screenWidth / 50);
  static double page80w = screenWidth / (screenWidth / 80);
  static double page90w = screenWidth / (screenWidth / 90);
  static double page140w = screenWidth / (screenWidth / 140);
  static double page200w = screenWidth / (screenWidth / 200);
  static double page300w = screenWidth / (screenWidth / 300);
  static double page310w = screenWidth / (screenWidth / 310);

  static double page10r = screenHeight / (screenHeight / 10);
  static double page20r = screenHeight / (screenHeight / 20);
  static double page25r = screenHeight / (screenHeight / 25);

  //sizing
  static double size18 = screenHeight / (screenHeight / 18);
  static double size31 = screenHeight / (screenHeight / 31);
  static double size35 = screenHeight / (screenHeight / 35);
  static double size170 = screenHeight / (screenHeight / 170);
}
