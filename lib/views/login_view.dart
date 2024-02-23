import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../core.dart';

class LoginView extends GetView<AuthController> {
  LoginView({Key key}) : super(key: key);
  CommonService commonService = Get.find();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Get.theme.primaryColor,
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
        backgroundColor: Get.theme.primaryColorDark,
        body:
            // SingleChildScrollView(
            //   child:

            Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login-bg.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonService.labelData.value.data.login.text
                    .textStyle(Get.theme.textTheme.headline1.copyWith(
                      color: Get.theme.indicatorColor,
                      fontSize: 35,
                    ))
                    .make()
                    .centered()
                    .pOnly(bottom: 20),
                Column(
                  children: [
                    Platform.isAndroid
                        ? InkWell(
                            onTap: () async {
                              String hint = await controller.autoFillSMS.hint;
                              if (hint != null && hint != '') {
                                controller.checkMobileNumber(hint);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
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
                              child: commonService
                                  .labelData.value.data.verifyMobileNo.text
                                  .textStyle(
                                    Get.textTheme.headline3.copyWith(
                                      color: Get.theme.highlightColor,
                                    ),
                                  )
                                  .make()
                                  .pSymmetric(h: 25, v: 25),
                            ),
                          )
                            .pOnly(bottom: Platform.isAndroid ? 30 : 0)
                            .centered()
                        : SizedBox(),
                    Platform.isAndroid
                        ? Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: Get.width,
                                  color: Get.theme.colorScheme.secondary,
                                  height: 2,
                                ),
                              ),
                              commonService.labelData.value.data.or.text
                                  .textStyle(
                                      Get.theme.textTheme.headline1.copyWith(
                                    color: Get.theme.indicatorColor,
                                  ))
                                  .make()
                                  .pSymmetric(h: 10),
                              Expanded(
                                child: Container(
                                  width: Get.width,
                                  color: Get.theme.colorScheme.secondary,
                                  height: 2,
                                ),
                              ),
                            ],
                          ).pOnly(bottom: 20)
                        : SizedBox(),
                    TextFormField(
                      style: TextStyle(
                          color: Get.theme.indicatorColor,
                          fontWeight: FontWeight.w300),
                      keyboardType: TextInputType.emailAddress,
                      validator: (String input) {
                        if (input.isEmpty) {
                          return commonService
                              .labelData.value.data.emailFieldValidation;
                        } else if (!GetUtils.isEmail(input)) {
                          return commonService
                              .labelData.value.data.emailNotValid;
                        } else {
                          return null;
                        }
                      },
                      onChanged: (input) {
                        controller.email.value = input;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: commonService
                            .labelData.value.data.enterEmailAddress,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 0),
                        prefixIcon: Align(
                          widthFactor: 1,
                          heightFactor: 1,
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.email,
                              size: 20, color: Get.theme.colorScheme.primary),
                        ),
                        errorStyle: const TextStyle(fontSize: 15),
                        hintStyle: Get.theme.textTheme.bodyText1.copyWith(
                            color: Get.theme.indicatorColor.withOpacity(0.3)),
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(
                                width: 1,
                                color:
                                    Get.theme.indicatorColor.withOpacity(0.5))),
                        focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(
                                width: 1,
                                color:
                                    Get.theme.indicatorColor.withOpacity(0.5))),
                        enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(
                                width: 1,
                                color:
                                    Get.theme.indicatorColor.withOpacity(0.5))),
                        errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(
                                width: 1, color: Get.theme.errorColor)),
                        focusedErrorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(
                                width: 1,
                                color:
                                    Get.theme.indicatorColor.withOpacity(0.5))),
                      ),
                    ).pOnly(bottom: 20),
                    InkWell(
                      onTap: () {
                        if (controller.loginFormKey.currentState.validate()) {
                          controller.sendOtpToEmail();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
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
                        child: commonService.labelData.value.data.sendOtp.text
                            .textStyle(
                              Get.textTheme.headline2.copyWith(
                                color: Get.theme.highlightColor,
                              ),
                            )
                            .make()
                            .pSymmetric(h: 20, v: 15),
                      ),
                    ).objectCenterRight(),
                  ],
                ).pOnly(bottom: 30),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: Get.width,
                        color: Get.theme.colorScheme.secondary,
                        height: 2,
                      ),
                    ),
                    commonService.labelData.value.data.or.text
                        .textStyle(Get.theme.textTheme.headline1.copyWith(
                          color: Get.theme.indicatorColor,
                        ))
                        .make()
                        .pSymmetric(h: 10),
                    Expanded(
                      child: Container(
                        width: Get.width,
                        color: Get.theme.colorScheme.secondary,
                        height: 2,
                      ),
                    ),
                  ],
                ).pOnly(bottom: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => controller.loginWithGoogle(),
                      child: Image.asset(
                        "assets/images/g-logo.png",
                        width: 35,
                        height: 35,
                      ),
                    ),
                    // InkWell(
                    //   onTap: () => controller.loginWithFB(),
                    //   child: Image.asset(
                    //     "assets/images/f-logo.png",
                    //     width: 35,
                    //     height: 35,
                    //   ),
                    // ),
                    if (Platform.isIOS)
                      InkWell(
                        onTap: () => controller.loginWithApple(),
                        child: Image.asset(
                          "assets/images/apple.png",
                          width: 40,
                          height: 40,
                        ),
                      )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Helper.launchURL("https://bhagatsm.dwgroup.in/policies");
                      },
                      child: "Privacy Policy"
                          .text
                          .textStyle(Get.theme.textTheme.bodyMedium.copyWith(
                            color: Get.theme.indicatorColor,
                          ))
                          .make(),
                    ),
                    Container(
                      color: Colors.black,
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
                            color: Get.theme.indicatorColor,
                          ))
                          .make(),
                    )
                  ],
                )
              ],
            ).pSymmetric(h: 30),
          ),
          // ),
        ));
  }
}
