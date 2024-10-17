import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:punjab_tourism/utils.dart';

import '../core.dart';

class LoginView extends GetView<AuthController> {
  LoginView({Key? key}) : super(key: key);
  CommonService commonService = Get.find();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

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
            key: loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonService.labelData.value.data.login.text
                    .textStyle(headline1().copyWith(
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
                              String? hint = await controller.autoFillSMS.hint;
                              if (hint != null && hint != '') {
                                controller.checkMobileNumber(hint);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 12, bottom: 12),
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
                              child: Text(
                                commonService
                                    .labelData.value.data.verifyMobileNo,
                                style:
                                    TextStyle(color: Get.theme.highlightColor),
                              ),
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
                                  .textStyle(headline1().copyWith(
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
                      validator: (String? input) {
                        if (input != null && input.isEmpty) {
                          return commonService
                              .labelData.value.data.emailFieldValidation;
                        } else if (!GetUtils.isEmail(input!)) {
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
                        hintStyle: bodyText1.copyWith(
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
                            borderSide:
                                BorderSide(width: 1, color: errorColor)),
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
                        if (loginFormKey.currentState!.validate()) {
                          controller.sendOtpToEmail();
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 12, bottom: 12),
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
                          child: Text(
                            commonService.labelData.value.data.sendOtp,
                            style: TextStyle(color: Get.theme.highlightColor),
                          )),
                    ).objectCenterRight(),
                  ],
                ).pOnly(bottom: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Helper.launchURL(
                            "https://bhagatsm.dwgroup.in/policies");
                      },
                      child: "Privacy Policy"
                          .text
                          .textStyle(Get.theme.textTheme.bodyMedium!.copyWith(
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
                          .textStyle(Get.theme.textTheme.bodyMedium!.copyWith(
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
