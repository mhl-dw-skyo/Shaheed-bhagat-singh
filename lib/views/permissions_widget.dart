import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:punjab_tourism/controllers/permmisions_controller.dart';
import 'package:punjab_tourism/services/common_service.dart';
import 'package:punjab_tourism/utils.dart';
import 'package:punjab_tourism/views/mk_button.dart';

class PermissionsWidget extends GetView<PermissionsController> {
  CommonService commonService = Get.find();
  PermissionsWidget({super.key}) {
    controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.all(12),
        child: Obx(() => Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      commonService
                          .labelData.value.data.grant_following_permissions,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          height: 1.7,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      commonService
                          .labelData.value.data.need_following_permissions,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          height: 1.7,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                commonService.labelData.value.data.geolocation,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    height: 1.7,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                commonService.labelData.value.data
                                    .tap_to_grant_permission,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    height: 1.7,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        MkButton(
                          width: 95,
                          borderRadius: 4,
                          padding: EdgeInsets.all(8),
                          textStyle: GoogleFonts.poppins(color: Colors.white),
                          onTap: () => controller.askForLocation(),
                          text: getStatus(controller.location.value),
                          color: getColor(controller.location.value),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                commonService.labelData.value.data.bluetooth,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    height: 1.7,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                commonService.labelData.value.data
                                    .tap_to_grant_permission,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    height: 1.7,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        MkButton(
                          width: 95,
                          borderRadius: 4,
                          padding: EdgeInsets.all(8),
                          textStyle: GoogleFonts.poppins(color: Colors.white),
                          onTap: () => controller.askForBluetoothScan(),
                          text: getStatus(controller.bleScan.value),
                          color: getColor(controller.bleScan.value),
                        ),
                      ],
                    ),
                    // SizedBox(height: 16),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             commonService.labelData.value.data.bluetooth,
                    //             textAlign: TextAlign.center,
                    //             style: GoogleFonts.poppins(
                    //                 fontSize: 16,
                    //                 height: 1.7,
                    //                 color: Colors.black,
                    //                 fontWeight: FontWeight.w500),
                    //           ),
                    //           Text(
                    //             commonService.labelData.value.data
                    //                 .tap_to_grant_permission,
                    //             textAlign: TextAlign.start,
                    //             style: GoogleFonts.poppins(
                    //                 fontSize: 12,
                    //                 height: 1.7,
                    //                 color: Colors.grey,
                    //                 fontWeight: FontWeight.normal),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     MkButton(
                    //       width: 95,
                    //       borderRadius: 4,
                    //       padding: EdgeInsets.all(8),
                    //       textStyle: GoogleFonts.poppins(color: Colors.white),
                    //       onTap: () => Platform.isAndroid
                    //           ? controller.askForBluetoothConnect()
                    //           : controller.askForBluetooth(),
                    //       text: Platform.isAndroid
                    //           ? getStatus(controller.bleConnect.value)
                    //           : getStatus(controller.ble.value),
                    //       color: Platform.isAndroid
                    //           ? getColor(controller.bleConnect.value)
                    //           : getColor(controller.ble.value),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 50),
                    MkButton(
                      borderRadius: 4,
                      color: Get.theme.colorScheme.primary,
                      padding: EdgeInsets.all(14),
                      onTap: () {
                        if (controller.granted()) {
                          Get.back(result: true);
                        } else {
                          commonService.labelData.value.data.permissions_require
                              .toast();
                        }
                      },
                      text: commonService.labelData.value.data.continuee,
                      textStyle: GoogleFonts.poppins(color: Colors.white),
                    )
                  ]),
            )));
  }

  String getStatus(PermissionStatus value) {
    if (value == PermissionStatus.granted) {
      return commonService.labelData.value.data.granted;
    } else if (value == PermissionStatus.denied) {
      return commonService.labelData.value.data.denied;
    } else {
      return commonService.labelData.value.data.grant;
    }
  }
}

Color getColor(PermissionStatus value) {
  if (value == PermissionStatus.granted) {
    return Colors.green;
  } else if (value == PermissionStatus.denied) {
    return Colors.red;
  } else if (value == PermissionStatus.denied ||
      value == PermissionStatus.permanentlyDenied) {
    return Colors.red;
  } else {
    return Get.theme.colorScheme.primary;
  }
}
