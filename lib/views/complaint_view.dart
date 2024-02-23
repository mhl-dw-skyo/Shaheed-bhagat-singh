import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../core.dart';

class ComplaintView extends GetView<DashboardController> {
  ComplaintView({Key key}) : super(key: key);
  GlobalKey<ScaffoldState> scaffoldDashboardKey =
      GlobalKey<ScaffoldState>(debugLabel: '_scaffoldDashboardKey');
  CommonService commonService = Get.find();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
    );
    return Container(
      color: Get.theme.primaryColor,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: false,
          key: scaffoldDashboardKey,
          backgroundColor: Get.theme.primaryColor,
          appBar: AppBar(
            bottomOpacity: 0,
            shadowColor: Colors.transparent,
            foregroundColor: Get.theme.indicatorColor,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back,
                  color: Get.theme.indicatorColor,
                  size: 25,
                )),
            centerTitle: false,
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
          body: SingleChildScrollView(
            child: Form(
              key: controller.complaintFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  commonService.labelData.value.data.feedback.text
                      .textStyle(
                        Get.textTheme.headline1.copyWith(
                          color: Get.theme.indicatorColor,
                          fontSize: 28,
                        ),
                      )
                      .make()
                      .centered(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(
                        color: Get.theme.indicatorColor,
                        fontWeight: FontWeight.w300),
                    keyboardType: TextInputType.text,
                    validator: (String input) {
                      if (input.isEmpty) {
                        return commonService
                            .labelData.value.data.nameFieldValidation;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (input) {
                      controller.name.value = input;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText:
                          commonService.labelData.value.data.enterYourName,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 0),
                      prefixIcon: Align(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: Icon(
                          Icons.person,
                          size: 20,
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                      errorStyle: const TextStyle(fontSize: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Get.theme.indicatorColor.withOpacity(0.5))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Get.theme.indicatorColor.withOpacity(0.5))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Get.theme.indicatorColor.withOpacity(0.5))),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1, color: Get.theme.errorColor)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Get.theme.indicatorColor.withOpacity(0.5))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(
                        color: Get.theme.indicatorColor,
                        fontWeight: FontWeight.w300),
                    keyboardType: TextInputType.text,
                    validator: (String input) {
                      if (input.isEmpty) {
                        return commonService
                            .labelData.value.data.phoneFieldValidation;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (input) {
                      controller.phoneNo.value = input;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText:
                          commonService.labelData.value.data.enterPhoneNo,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 0),
                      prefixIcon: Align(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: Icon(
                          Icons.phone_android,
                          size: 20,
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                      errorStyle: const TextStyle(fontSize: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Get.theme.indicatorColor.withOpacity(0.5))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Get.theme.indicatorColor.withOpacity(0.5))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Get.theme.indicatorColor.withOpacity(0.5))),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1, color: Get.theme.errorColor)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Get.theme.indicatorColor.withOpacity(0.5))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(
                        color: Get.theme.indicatorColor,
                        fontWeight: FontWeight.w300),
                    keyboardType: TextInputType.text,
                    validator: (String input) {
                      if (input.isEmpty) {
                        return commonService
                            .labelData.value.data.titleFieldValidation;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (input) {
                      controller.title.value = input;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: commonService.labelData.value.data.enterTitle,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 0),
                      prefixIcon: Align(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: Icon(
                          Icons.title,
                          size: 20,
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                      errorStyle: const TextStyle(fontSize: 15),
                      hintStyle: Get.theme.textTheme.bodyText1.copyWith(
                          color: Get.theme.indicatorColor.withOpacity(0.3)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Get.theme.indicatorColor.withOpacity(0.5))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Get.theme.indicatorColor.withOpacity(0.5))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Get.theme.indicatorColor.withOpacity(0.5))),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1, color: Get.theme.errorColor)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Get.theme.indicatorColor.withOpacity(0.5))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(
                        color: Get.theme.indicatorColor,
                        fontWeight: FontWeight.w300),
                    keyboardType: TextInputType.text,
                    validator: (String input) {
                      if (input.isEmpty) {
                        return commonService
                            .labelData.value.data.messageFieldValidation;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (input) {
                      controller.message.value = input;
                    },
                    maxLines: 6,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText:
                          commonService.labelData.value.data.enterMessage,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 0),
                      prefixIcon: Align(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: Icon(
                          Icons.message,
                          size: 20,
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                      errorStyle: const TextStyle(fontSize: 15),
                      hintStyle: Get.theme.textTheme.bodyText1.copyWith(
                          color: Get.theme.indicatorColor.withOpacity(0.3)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Get.theme.indicatorColor.withOpacity(0.5))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Get.theme.indicatorColor.withOpacity(0.5))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Get.theme.indicatorColor.withOpacity(0.5))),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1, color: Get.theme.errorColor)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Get.theme.indicatorColor.withOpacity(0.5))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      if (controller.complaintFormKey.currentState.validate()) {
                        controller.submitComplaint();
                      }
                    },
                    child: Container(
                      width: 150,
                      height: 60,
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
                      child: commonService.labelData.value.data.submit.text
                          .textStyle(
                            Get.textTheme.headline3.copyWith(
                              color: Get.theme.highlightColor,
                            ),
                          )
                          .make()
                          .centered(),
                    ),
                  ).centered(),
                ],
              ).pOnly(bottom: 60, left: 20, right: 20),
            ),
          ),
          bottomNavigationBar: BottomNavWidget(
            onTap: (int index) {
              Helper.onBottomBarClick(null, index);
            },
          ),
          floatingActionButton: SpeedDialWidget(),
        ),
      ),
    );
  }
}
