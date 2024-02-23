import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core.dart';

class DrawerWidget extends GetView {
  DrawerWidget({Key key}) : super(key: key);
  CommonService commonService = Get.find();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Get.theme.colorScheme.primary,
                Get.theme.colorScheme.secondary,
              ],
              begin: const FractionalOffset(1.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: const [0.0, 0.0],
              tileMode: TileMode.clamp),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Get.theme.colorScheme.primary,
                            Get.theme.colorScheme.secondary,
                          ],
                          begin: const FractionalOffset(1.0, 0.0),
                          end: const FractionalOffset(0.0, 1.0),
                          stops: const [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    accountName: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          GetStorage().read('name') ?? 'Guest',
                          style: Get.theme.textTheme.headline1.copyWith(color: Get.theme.highlightColor),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          GetStorage().read('username') ?? '',
                          style: Get.theme.textTheme.bodyMedium.copyWith(color: Get.theme.highlightColor),
                        ),
                      ],
                    ),
                    currentAccountPicture: CircleAvatar(
                      maxRadius: 100,
                      backgroundColor: Get.theme.highlightColor,
                      backgroundImage: const AssetImage(
                        "assets/images/default-user.png",
                      ),
                    ),
                    accountEmail: null,
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      onTap: () {
                        Get.back();
                        if (GetStorage().read('user_type') != "U") {
                          if (Get.currentRoute != "/emp_dashboard") {
                            Get.toNamed('/emp_dashboard');
                          }
                        } else {
                          if (Get.currentRoute != "/dashboard") {
                            Get.toNamed('/dashboard');
                          }
                        }
                      },
                      dense: true,
                      leading: SvgPicture.asset(
                        "assets/images/home2.svg",
                        width: 20,
                        height: 20,
                        color: Get.theme.highlightColor,
                      ),
                      title: commonService.labelData.value.data.home.text.textStyle(Get.textTheme.headline2.copyWith(color: Get.theme.highlightColor)).make(),
                    ),
                    ListTile(
                      onTap: () async {
                        await GetStorage().write('isBackToHomeLangPage', '1');
                        Get.back();
                        Get.toNamed('/language');
                      },
                      dense: true,
                      leading: SvgPicture.asset(
                        "assets/images/language.svg",
                        width: 20,
                        height: 20,
                        color: Get.theme.highlightColor,
                      ),
                      title: commonService.labelData.value.data.contentLanguage.text.textStyle(Get.textTheme.headline2.copyWith(color: Get.theme.highlightColor)).make(),
                    ),
                    ListTile(
                      onTap: () async {
                        await GetStorage().write('isBackToHomeLangPage', '1');
                        Get.back();
                        Get.toNamed('/complaint');
                      },
                      dense: true,
                      leading: SvgPicture.asset(
                        "assets/images/feedback.svg",
                        width: 20,
                        height: 20,
                        color: Get.theme.highlightColor,
                      ),
                      title: commonService.labelData.value.data.feedback.text.textStyle(Get.textTheme.headline2.copyWith(color: Get.theme.highlightColor)).make(),
                    ),
                    // ListTile(
                    //   onTap: () async {
                    //     Helper.logoutConfirmation();
                    //   },
                    //   dense: true,
                    //   leading: SvgPicture.asset(
                    //     "assets/images/logout.svg",
                    //     width: 20,
                    //     height: 20,
                    //     color: Get.theme.highlightColor,
                    //   ),
                    //   title: commonService.labelData.value.data.logout.text.textStyle(Get.textTheme.headline2.copyWith(color: Get.theme.highlightColor)).make(),
                    // ),
                    // ListTile(
                    //   onTap: () async {
                    //     Helper.deleteAccountConfirmation();
                    //   },
                    //   dense: true,
                    //   leading: SvgPicture.asset(
                    //     "assets/images/delete-person.svg",
                    //     width: 20,
                    //     height: 20,
                    //     color: Get.theme.highlightColor,
                    //   ),
                    //   title: commonService.labelData.value.data.deleteAccount.text.textStyle(Get.textTheme.headline2.copyWith(color: Get.theme.highlightColor)).make(),
                    // )
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Helper.launchURL("https://bhagatsm.dwgroup.in/policies");
                    },
                    child: "Privacy Policy"
                        .text
                        .textStyle(Get.theme.textTheme.bodyMedium.copyWith(
                          color: Get.theme.highlightColor,
                        ))
                        .make(),
                  ),
                  Container(
                    color: Colors.white,
                    height: 15,
                    width: 1,
                  ).pSymmetric(h: 10),
                  InkWell(
                    onTap: () {
                      Helper.launchURL("https://bhagatsm.dwgroup.in/terms");
                    },
                    child: "Terms & Conditions"
                        .text
                        .textStyle(Get.theme.textTheme.bodyMedium.copyWith(
                          color: Get.theme.highlightColor,
                        ))
                        .make(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
