import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../core.dart';

class ThankYouView extends GetView {
  ThankYouView({Key key}) : super(key: key);
  DateTime currentBackPressTime;
  GlobalKey<ScaffoldState> scaffoldDashboardKey =
      GlobalKey<ScaffoldState>(debugLabel: '_scaffoldDashboardKey');
  CommonService commonService = Get.find();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Get.theme.primaryColor,
          statusBarIconBrightness: Brightness.dark),
    );
    return Container(
      color: Get.theme.primaryColor,
      child: SafeArea(
        child: Scaffold(
          key: scaffoldDashboardKey,
          backgroundColor: Get.theme.primaryColor,
          appBar: AppBar(
            bottomOpacity: 0,
            shadowColor: Colors.transparent,
            backgroundColor: Get.theme.primaryColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: commonService.labelData.value.data.punjabTourism.text
                .textStyle(
                  Get.textTheme.headline1.copyWith(
                    color: Get.theme.indicatorColor,
                  ),
                )
                .make(),
            actions: [
              InkWell(
                onTap: () {
                  scaffoldDashboardKey.currentState.openEndDrawer();
                },
                child: SvgPicture.asset(
                  "assets/images/menu.svg",
                  color: Get.theme.indicatorColor,
                ),
              ).pOnly(right: 20)
            ],
          ),
          endDrawer: DrawerWidget(),
          body: Container(
            width: Get.width,
            height: Get.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/thank_you.svg",
                  width: Get.width * 0.6,
                  color: Colors.red,
                ).pOnly(bottom: 20),
                commonService.labelData.value.data.thankYou.text.center
                    .textStyle(
                      Get.textTheme.headline1.copyWith(
                        color: Get.theme.indicatorColor,
                      ),
                    )
                    .make()
                    .centered()
              ],
            ),
          ),
          bottomNavigationBar: BottomNavWidget(
            onTap: (int index) {
              Helper.onBottomBarClick(controller, index);
            },
          ),
          floatingActionButton: SpeedDialWidget(),
        ),
      ),
    );
  }
}
