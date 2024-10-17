import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punjab_tourism/utils.dart';
import '../core.dart';

class SplashView extends GetView<SplashController> {
  SplashView({Key? key}) : super(key: key);
  SplashController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/splash.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                colors: [
                  Get.theme.colorScheme.primary,
                  Get.theme.colorScheme.secondary,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: SizedBox()
        ),
      ),
    );
  }
}
