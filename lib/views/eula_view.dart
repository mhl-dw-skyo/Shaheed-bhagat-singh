import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../core.dart';

class EulaView extends GetView {
  EulaView({Key? key}) : super(key: key);
 late DateTime currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Get.theme.primaryColorDark, statusBarIconBrightness: Brightness.dark),
    );
    return Container(
      color: Get.theme.colorScheme.background,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Get.theme.primaryColorDark,
          appBar: AppBar(
            bottomOpacity: 0,
            shadowColor: Colors.transparent,
            backgroundColor: Get.theme.primaryColorDark,
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: "EULA".text.ellipsis.center.textStyle(Get.textTheme.headline1!.copyWith(color: Get.theme.colorScheme.primary)).make(),
          ),
          body: WillPopScope(
            onWillPop: () {
              DateTime now = DateTime.now();
              if (currentBackPressTime == null || now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
                currentBackPressTime = now;
                Fluttertoast.showToast(msg: "Tap again to exit an app.");
                return Future.value(false);
              }
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              return Future.value(true);
            },
            child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Get.theme.indicatorColor.withOpacity(0.2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: Get.width,
                            child: Html(
                              style: {
                                "*": Style(
                                  color: Get.theme.indicatorColor,
                                  fontSize: FontSize.large,
                                ),
                                // "b": Style(
                                //   color: Get.theme.splashColor,
                                // ),
                              },
                              shrinkWrap: true,
                              data: eula,
                            ),
                          ).pSymmetric(h: 15, v: 20),
                        ],
                      ),
                    ).pOnly(left: 15, right: 15, top: 15, bottom: 70).objectTopCenter(),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 65,
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: Get.theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Get.theme.colorScheme.primary,
                            width: 2,
                          )),
                      child: InkWell(
                        onTap: () async {
                          DashboardController dashboardController = Get.find();
                          dashboardController.fetchLabelData();
                          GetStorage().write('EULA_agree', true);
                          if (GetStorage().read('welcomeAudioPlayed') == null || GetStorage().read('welcomeAudioPlayed') == '') {
                            Helper.playWelcomeSound();
                          }
                          Get.toNamed('/login');
                        },
                        child: "Agree".text.ellipsis.center.textStyle(Get.textTheme.headline3!.copyWith(color: Get.theme.highlightColor)).make().centered(),
                      ).pSymmetric(h: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
