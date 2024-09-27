import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../core.dart';

class VerifyOTPView extends GetView<AuthController> {
  VerifyOTPView({Key? key}) : super(key: key);
  CommonService commonService = Get.find();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Get.theme.primaryColor, statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      backgroundColor: Get.theme.primaryColorDark,
      appBar: AppBar(
        bottomOpacity: 0,
        shadowColor: Colors.transparent,
        foregroundColor: Get.theme.colorScheme.primary,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: false,
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login-bg.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonService.labelData.value.data.verifyOtp.text
                .textStyle(Get.theme.textTheme.headline1!.copyWith(
                  color: Get.theme.indicatorColor,
                  fontSize: 35,
                ))
                .make()
                .pOnly(bottom: 10),
            commonService.labelData.value.data.verifyOtpDesc.text
                .textStyle(Get.theme.textTheme.bodyText1!.copyWith(
                  fontSize: 17,
                  color: Get.theme.indicatorColor.withOpacity(0.5),
                ))
                .make()
                .pOnly(bottom: 20),
            PinCodeTextField(
              appContext: context,
              length: 5,
              obscureText: false,
              animationType: AnimationType.fade,
              enablePinAutofill: true,
              enabled: true,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                inactiveColor: Get.theme.colorScheme.primary,
                errorBorderColor: Get.theme.errorColor,
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 50,
                activeFillColor: Get.theme.colorScheme.primary,
                activeColor: Get.theme.colorScheme.primary,
                inactiveFillColor: Get.theme.highlightColor,
                selectedColor: Get.theme.colorScheme.primary,
                selectedFillColor: Get.theme.highlightColor,
              ),
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              // errorAnimationController:
              //     controller.errorController,
              // controller: controller.otpController,
              onCompleted: (v) {
                controller.otp.value = v;
              },
              onChanged: (value) {
                controller.otp.value = value;
              },
              beforeTextPaste: (text) {
                controller.otp.value = text!;
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ).pOnly(bottom: 10),
            InkWell(
              onTap: () {
                if (controller.otp.value.isNotEmpty && controller.otp.value.length == 5) {
                  controller.verifyOtp();
                } else {
                  Fluttertoast.showToast(
                    msg: commonService.labelData.value.data.otpValidation,
                    backgroundColor: Get.theme.errorColor,
                    gravity: ToastGravity.TOP,
                  );
                }
              },
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
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: commonService.labelData.value.data.verify.text.uppercase
                    .textStyle(
                      Get.textTheme.headline2!.copyWith(
                        color: Get.theme.highlightColor,
                      ),
                    )
                    .make()
                    .pSymmetric(h: 20, v: 15),
              ),
            ).objectCenterLeft().pOnly(bottom: 20),
            Obx(
              () => !controller.bHideTimer.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        commonService.labelData.value.data.didntRecvOtp.text.center.textStyle(Get.textTheme.bodyText1!.copyWith(color: Get.theme.indicatorColor.withOpacity(0.8))).make(),
                        const SizedBox(width: 10),
                        commonService.labelData.value.data.resendOtp.text.center.textStyle(Get.textTheme.headline3!.copyWith(color: Get.theme.indicatorColor.withOpacity(0.8))).make().onInkTap(() {
                          if (!controller.bHideTimer.value) {
                            controller.sendOtpToEmail(false);
                            controller.startTimer();
                          }
                        })
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 75,
                          child: commonService.labelData.value.data.resendIn.text.textStyle(Get.textTheme.bodyText1!.copyWith(fontSize: 16, color: Get.theme.indicatorColor.withOpacity(0.8))).center.make(),
                        ),
                        SizedBox(
                          width: 50,
                          child: "${controller.countTimer.value}s".text.textStyle(Get.textTheme.headline1!.copyWith(color: Get.theme.indicatorColor.withOpacity(0.8))).center.make().objectCenterRight(),
                        ),
                      ],
                    ),
            )
          ],
        ).pSymmetric(h: 30),
      ),
    );
  }
}
