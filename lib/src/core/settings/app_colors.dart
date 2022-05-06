import 'package:flutter/material.dart';

class AppColors {
  /// Primary Color(0xff00d9b5)
  static const Color primary = Color(0xff00d9b5);

  /// Color(0xffFF1720)
  static const Color pRed = Color(0xffFF1720);

  /// Colors.black
  static const Color pBlack = Colors.black;

  /// Color(0xFF707070)
  static const Color pGray = Color(0xFF707070);

  /// Colors.white
  static const Color pBackground = Colors.white;

  /// Color(0xffF5F5F5)
  static const Color sBackground = Color(0xffF5F5F5);

  /// Color(0xFF0D4DFF)
  static const Color blue = Color(0xFF0D4DFF);

  /// Color(0xFF0892DD)
  static const Color blueOne = Color(0xFF0892DD);

  /// Color(0xFF5D5D5D)
  static const Color grey = Color(0xFF5D5D5D);

  /// Color(0xFFDBDBDB) #F5F5F5
  static const Color greyTwo = Color(0xFFDBDBDB);

  /// Color(0xFF757575)
  static const Color greyThree = Color(0xFF757575);
  /// Color(0xFF5F5F5)
  static  Color greyPage = const Color(0xffF5F5F5);

  /// Color(0xFFFD3C65)
  static const Color red = Color(0xFFFD3C65);

  /// Color(0xFFFF612B)
  static const Color orange = Color(0xFFFF612B);

  /// Color(0xFFFF792E)
  static const Color orangeOne = Color(0xFFFF792E);

  /// Color(0xFF5F2B)
  static const Color orangeTwo = Color(0xFF5F2B);

  /// Color(0xFF32FFAD)
  static const Color green = Color(0xFF32FFAD);

  /// Color(0xFF03D6BC)
  static const Color greenOne = Color(0xFF03D6BC);

  /// Color(0xFF9508EB)
  static const Color purple = Color(0xFF9508EB);

  /// Color(0xFFD6017B)
  static const Color fuchsia = Color(0xFFD6017B);

  /// Color(0xFFF5F5F5)
  static const Color closeModal = Color(0xFFF5F5F5);

  /// Color(0xFF03D6BC)
  static const Color degradeOne = Color(0xFF03D6BC);

  /// Color(0xFF0D4DFF)
  static const Color degradeTwo = Color(0xFF0D4DFF);

  /// Color(0xFFFF9D32)
  static const Color degradeThree = Color(0xFFFF9D32);

  /// Color(0xFFFF2525)
  static const Color degradeFour = Color(0xFFFF2525);

  /// Color(0xFFFC006D)
  static const Color degradeFive = Color(0xFFFC006D);

  /// Color(0xFFB20289)
  static const Color degradeSix = Color(0xFFB20289);

  /// Color(0xFFD603D6)
  static const Color degradeSeven = Color(0xFFD603D6);

  /// Color(0xFF550DFF)
  static const Color degradeEigth = Color(0xFF550DFF);

  /// Color(0xFFFF327F)
  static const Color degradeNine = Color(0xFFFF327F);

  /// Color(0xFFFF2534)
  static const Color degradeTen = Color(0xFFFF2534);

  /// Color(0xffF8F9FF)
  static const Color emptylistColor = Color(0xffDBDBDB);

  /// Color(0xffFAFAFA)
  static const Color emptylistBackground = Color(0xffFAFAFA);

  /// Color(0xffFAFAFA)
  static const Color yellow = Color(0xffFF8B32);

  /// Color(0xFFFF9D32)
  static const Color gold = Color(0xFFFF9D32);

  /// Color(0xFF28D07B)
  static const Color accentsGreen = Color(0xFF28D07B);




  /// Colors.black
  static const pText = Colors.black;

  /// Color(0xff868686)
  static const sText = Color(0xff868686);

  static const pTextDisabled = Colors.grey; // pendiente por confirmar

  /// Colors.black
  static const sTextButton = sText;

  /// Colors.white
  static const pTextButton = Colors.white;

  /// Color(0xff2196F3)
  static const pTextLink = Color(0xff2196F3);

  /// Color(0xffDBDBDB)
  static const pTextPlaceholder = Color(0xffDBDBDB);

  /// Color(0xff868686)
  static const pIconsInput = Color(0xff868686);

  /// Color(0xffDBDBDB)
  static const pBorder = Color(0xffDBDBDB);

  /// Colors.black.withOpacity(0.29)
  static final pShadow = Colors.black.withOpacity(0.29);

  /// Colors.black
  static const sButton = Colors.black;

  /// Colors.white
  static const tButton = Colors.white;

  /// Color(0xffDBDBDB);
  static const fButton = Color(0xffDBDBDB);

  /// Color(0xfff5f5f5)
  static const pCardText = Color(0xfff5f5f5);

  /// Color(0xff93EDCF);
  static const success = Color(0xff93EDCF);

  /// Color(0xffFFD54F)
  static const warning = Color(0xffFFD54F);

  /// Color(0xffFFB2C2)
  static const danger = Color(0xffFFB2C2);

  /// Color(0xffDBDBDB)
  static const neutral = Color(0xffDBDBDB);

  /// Colors.black
  static const end = Colors.black;

  static Color notificationType2Color(int type) {
    switch (type) {
      case 211:
      case 213:
        return const Color(0XFF0D4DFF);
      case 214:
        return const Color(0xffFF612B);
      default:
        return const Color(0XFF0D4DFF);
    }
  }
}
