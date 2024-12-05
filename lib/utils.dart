import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:punjab_tourism/services/config_service.dart';
import 'package:punjab_tourism/shared/helper.dart';

var errorColor = const Color(0xffF6534C);

TextStyle headline6() => GoogleFonts.poppins().copyWith(
    fontSize: 10,
    color: Helper.parseColorCode(
        Get.find<ConfigService>().configData.value.textColorLight),
    fontWeight: FontWeight.bold,
    fontFamily: 'Gilroy');
TextStyle headline5() => GoogleFonts.poppins().copyWith(
    fontSize: 12,
    color: Helper.parseColorCode(
        Get.find<ConfigService>().configData.value.textColorLight),
    fontWeight: FontWeight.bold,
    fontFamily: 'Gilroy');
TextStyle headline4() => GoogleFonts.poppins().copyWith(
    fontSize: 14,
    color: Helper.parseColorCode(
        Get.find<ConfigService>().configData.value.textColorLight),
    fontWeight: FontWeight.bold,
    fontFamily: 'Gilroy');
TextStyle headline3() => GoogleFonts.poppins().copyWith(
    fontSize: 16,
    color: Helper.parseColorCode(
        Get.find<ConfigService>().configData.value.textColorLight),
    fontWeight: FontWeight.bold,
    fontFamily: 'Gilroy');
TextStyle headline2() => GoogleFonts.poppins().copyWith(
    fontSize: 18,
    color: Helper.parseColorCode(
        Get.find<ConfigService>().configData.value.textColorLight),
    fontWeight: FontWeight.bold,
    fontFamily: 'Gilroy');
TextStyle headline1() => GoogleFonts.poppins().copyWith(
    fontSize: 20,
    color: Helper.parseColorCode(
        Get.find<ConfigService>().configData.value.textColorLight),
    fontWeight: FontWeight.bold,
    fontFamily: 'Gilroy');
TextStyle subtitle1() => GoogleFonts.poppins();
TextStyle get bodyText1 => GoogleFonts.poppins().copyWith(
    fontSize: 15,
    color: Helper.parseColorCode(
        Get.find<ConfigService>().configData.value.textColorLight),
    fontWeight: FontWeight.w400,
    fontFamily: 'Gilroy');
TextStyle get bodyText2 => GoogleFonts.poppins().copyWith(
    fontSize: 14,
    color: Helper.parseColorCode(
        Get.find<ConfigService>().configData.value.textColorLight),
    fontWeight: FontWeight.w400,
    fontFamily: 'Gilroy');

double get screenWidth => Get.width;
double get screenHeight => Get.height;

extension Util on String {
  toast() {
    return Fluttertoast.showToast(
      msg: this,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,);
  }
}