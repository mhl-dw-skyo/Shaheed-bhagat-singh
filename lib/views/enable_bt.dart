import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:get/get.dart';
import 'package:punjab_tourism/utils.dart';
import 'package:punjab_tourism/views/mk_button.dart';
import 'package:url_launcher/url_launcher.dart';

class EnableBt extends StatelessWidget {
  const EnableBt({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(16),
      child: SizedBox(
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            'assets/images/bt.png',
                            width: 140,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: ()=>Get.back(),
                        child: Transform.rotate(
                            angle: -95 ,
                            child: Icon(Icons.add_circle,size: 30,)),
                      )
                    ],
                  ),
                  SizedBox(height: 34),
                  Text(
                    "Enable Bluetooth",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "To improve Bluetooth accuracy, please enable Bluetooth on your device.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.6,
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                "Steps to turn on Bluetooth",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 14),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(
                      text: "1. Open Settings: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text:
                          "Go to your device's home screen and tap on the Settings app.",
                      style: TextStyle(
                        color: Colors.grey,
                        height: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        decorationColor: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(
                      text: "2. Go to Bluetooth: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text:
                          "Depending on your device, tap on Connections or directly on Bluetooth.",
                      style: TextStyle(
                        color: Colors.grey,
                        height: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        decorationColor: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(
                      text: "3. Enable Bluetooth: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: "Toggle the switch to turn Bluetooth on.",
                      style: TextStyle(
                        color: Colors.grey,
                        height: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        decorationColor: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
              ),

              Visibility(
                visible: Platform.isAndroid,
                child: Column(
                  children: [
                    SizedBox(height: 34),
                    MkButton(
                        color: Get.theme.colorScheme.primary,
                        onTap: () {
                          try {
                            Get.back();
                            flutterBeacon.openBluetoothSettings;
                          } catch (e) {}
                        },
                        text: "Go To Bluetooth"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
