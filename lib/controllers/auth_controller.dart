import 'dart:async';
import 'dart:convert';

import 'package:dastaan_e_shahadat/controllers/detail_controller.dart';
import 'package:dastaan_e_shahadat/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:sms_autofill/sms_autofill.dart';

import '../core.dart';
import 'bottom_nav_controller.dart';

class AuthController extends GetxController {
  ScrollController scrollController = ScrollController();
  DashboardController dashboardController = Get.find();
  GuestController guestController = Get.find();
  CategoryTypeController categoryTypeController = Get.put(CategoryTypeController());
  DetailController detailController = Get.put(DetailController());
  NearByController nearByController = Get.put(NearByController());
  SplashController splashController = Get.put(SplashController());
  BottomNavController bottomNavController = Get.put(BottomNavController());

  var email = "".obs;
  var mobileNumber="".obs;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  ScrollController otpScrollController = ScrollController();
  var otp = "".obs;
  var countTimer = 59.obs;
  var bHideTimer = false.obs;
  late Timer timer;
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  // final SmsAutoFill autoFillSMS = SmsAutoFill();
  GuestApi guestApi = Get.find();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> checkMobileNumber(String mobileNo) async {
    bool apiStatus = await verifyMobileNo(mobileNo);
    if (apiStatus) {
      if (GetStorage().read('language_id') == "" ||
          GetStorage().read('language_id') == null) {
        Get.toNamed('/language');
      } else {
        dashboardController.fetchLabelData();
        dashboardController.fetchDashboardData();
        categoryTypeController.fetchTrailsData();
        detailController.getOfflineLocationsData();
        nearByController.getNearByData();
        bottomNavController.updateIndex();
        Get.toNamed('/dashboard');
        await dashboardController.fetchBeaconData();
        dashboardController.initBeaconService();
      }
    }
  }

  updateFcmToken() {
    String fcmToken = GetStorage().read("fcm_token") ?? '';
    if (fcmToken != null && fcmToken != "") {
      guestApi.updateFCMToken(fcmToken);
    } else {
      splashController.updateFCMToken();
    }
  }

  Future<bool> verifyMobileNo(String mobileNo) async {
    AuthApi authApi = Get.find();
    EasyLoading.show(status: 'loading...');
    var response = await authApi.verifyMobileNo(mobileNo);
    EasyLoading.dismiss();
    print(response);
    if (response['status']) {
      if (response['data'] != "" && response['data'] != null) {
        await GetStorage().write('token', response['data']);
        await GetStorage().write('username', response['username']);
        await GetStorage().write('user_type', "U");
        updateFcmToken();
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> loginWithSocialMedia(String mobileNo) async {
    AuthApi authApi = Get.find();
    EasyLoading.show(status: 'loading...');
    var response = await authApi.verifyMobileNo(mobileNo);
    EasyLoading.dismiss();
    print(response);
    if (response['status']) {
      if (response['data'] != "" && response['data'] != null) {
        await GetStorage().write('token', response['data']);
        await GetStorage().write('username', response['username']);
        await GetStorage().write('user_type', response['usertype']);
        return true;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Future sendOtpToEmail([bool redirection = true]) async {
    AuthApi authApi = Get.find();
    EasyLoading.show(status: 'loading...');
    var response = await authApi.sendOtpToEmail(email.value);
    EasyLoading.dismiss();
    print(response);
    if (response['status']) {
      Fluttertoast.showToast(
        msg: response['message'],
        backgroundColor: Colors.green,
        gravity: ToastGravity.TOP,
      );
      if (redirection) {
        Get.toNamed('/verify-otp');
      }
    } else {
      Fluttertoast.showToast(
        msg: response['message'],
        backgroundColor: Get.theme.errorColor,
        gravity: ToastGravity.TOP,
      );
    }
  }

  Future verifyOtp() async {
    AuthApi authApi = Get.find();
    EasyLoading.show(status: 'loading...');
    var response = await authApi.verifyOtp(email.value, otp.value);
    EasyLoading.dismiss();
    print(response);
    if (response['status']) {
      if (response['data'] != "" && response['data'] != null) {
        await GetStorage().write('token', response['data']);
        await GetStorage().write('username', response['username']);
        await GetStorage().write('user_type', response['usertype']);
        await GetStorage().write('name', response['name']);
        updateFcmToken();

        if (GetStorage().read('language_id') == "" ||
            GetStorage().read('language_id') == null) {
          Get.toNamed('/language');
        } else {
          dashboardController.fetchLabelData();
          dashboardController.fetchDashboardData();
          categoryTypeController.fetchTrailsData();
          detailController.getOfflineLocationsData();
          nearByController.getNearByData();
          if (GetStorage().read('user_type') != "U") {
            guestController.page = 1;
            guestController.showLoadMore = true;
            guestController.forUser.value = false;
            guestController.forUser.refresh();
            guestController.fetchGuestInformationHistory();
            bottomNavController.updateIndex();

            Get.toNamed('/emp_dashboard');
          } else {
            bottomNavController.updateIndex();

            Get.toNamed('/dashboard');
            await dashboardController.fetchBeaconData();
            dashboardController.initBeaconService();
          }
        }
      } else {
        Fluttertoast.showToast(
          msg: response['message'],
          backgroundColor: Get.theme.errorColor,
          gravity: ToastGravity.TOP,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: response['message'],
        backgroundColor: Get.theme.errorColor,
        gravity: ToastGravity.TOP,
      );
    }
  }

  loginWithFB() async {
    final LoginResult fBResult = await FacebookAuth.instance.login();
    switch (fBResult.status) {
      case LoginStatus.success:
        final AccessToken? accessToken = fBResult.accessToken;
        // OverlayEntry loader = Helper.overlayLoader(GlobalVariable.navState.currentContext);
        // Overlay.of(GlobalVariable.navState.currentContext).insert(loader);
        final graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,email,first_name,last_name,picture.width(720).height(720),birthday,gender,languages,location{location}&access_token=${accessToken?.token}'));
        final profile = jsonDecode(graphResponse.body);
        // exit;
        if (profile["email"] == "") {
          Fluttertoast.showToast(
              msg:
              "Your facebook profile does not provide email address. Please try with another method");
          return false;
        }
        Map<String, dynamic> glData = {
          'user_input': profile["email"],
          'register_type': '2'
        };
        AuthApi authApi = Get.find();
        EasyLoading.show(status: 'loading...');
        var response = await authApi.loginWithSocialMedia(glData);
        EasyLoading.dismiss();
        // resp = jsonDecode(resp);
        if (response['status']) {
          await GetStorage().write('token', response['data']);
          await GetStorage().write('username', response['username']);
          await GetStorage().write('user_type', response['usertype']);
          if (GetStorage().read('language_id') == "" ||
              GetStorage().read('language_id') == null) {
            Get.toNamed('/language');
          } else {
            dashboardController.fetchLabelData();
            dashboardController.fetchDashboardData();
            categoryTypeController.fetchTrailsData();
            detailController.getOfflineLocationsData();
            nearByController.getNearByData();
            if (GetStorage().read('user_type') != "U") {
              bottomNavController.updateIndex();
              Get.toNamed('/emp_dashboard');
              guestController.page = 1;
              guestController.showLoadMore = true;
              guestController.forUser.value = false;
              guestController.forUser.refresh();
              guestController.fetchGuestInformationHistory();
            } else {
              bottomNavController.updateIndex();

              Get.toNamed('/dashboard');
              await dashboardController.fetchBeaconData();
              dashboardController.initBeaconService();
            }
          }
        } else {
          Fluttertoast.showToast(
            msg: "There is some problem to facebook login, please try again",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 5,
            backgroundColor: Get.theme.indicatorColor,
            textColor: Get.theme.primaryColor,
            fontSize: 15.0,
          );
        }

        break;
      case LoginStatus.cancelled:
        break;
      case LoginStatus.failed:
        Fluttertoast.showToast(
          msg: "There is some problem to facebook login, please try again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          backgroundColor: Get.theme.indicatorColor,
          textColor: Get.theme.primaryColor,
          fontSize: 15.0,
        );
        break;
    }
  }

  loginWithGoogle() async {
    await googleSignIn.signIn();
    if (googleSignIn.currentUser != null) {
      Map<String, dynamic> glData = {
        'user_input': googleSignIn.currentUser?.email ?? '',
        'register_type': '3'
      };
      print(glData);
      AuthApi authApi = Get.find();
      EasyLoading.show(status: 'loading...');
      var response = await authApi.loginWithSocialMedia(glData);
      EasyLoading.dismiss();
      if (response['status']) {
        print(response['data']);
        await GetStorage().write('token', response['data']);
        await GetStorage().write('username', response['username']);
        await GetStorage().write('user_type', response['usertype']);
        updateFcmToken();

        if (GetStorage().read('language_id') == "" ||
            GetStorage().read('language_id') == null) {
          Get.toNamed('/language');
        } else {
          dashboardController.fetchLabelData();
          dashboardController.fetchDashboardData();
          categoryTypeController.fetchTrailsData();
          detailController.getOfflineLocationsData();
          nearByController.getNearByData();
          if (GetStorage().read('user_type') != "U") {
            bottomNavController.updateIndex();

            Get.toNamed('/emp_dashboard');
            guestController.page = 1;
            guestController.showLoadMore = true;
            guestController.forUser.value = false;
            guestController.forUser.refresh();
            guestController.fetchGuestInformationHistory();
          } else {
            bottomNavController.updateIndex();

            Get.toNamed('/dashboard');
            await dashboardController.fetchBeaconData();
            dashboardController.initBeaconService();
          }
        }
      } else {
        Fluttertoast.showToast(
          msg: "There is some problem to google login, please try again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          backgroundColor: Get.theme.indicatorColor,
          textColor: Get.theme.primaryColor,
          fontSize: 15.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "There is some problem to google login, please try again",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Get.theme.indicatorColor,
        textColor: Get.theme.primaryColor,
        fontSize: 15.0,
      );
    }
  }

  loginWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
          clientId: 'des.dwgroup.app',
          redirectUri: Uri.parse(
            'https://smiling-abrupt-screw.glitch.me/callbacks/sign_in_with_apple',
          ),
        ),
      );
      Map<String, dynamic> glData = {
        'user_input': credential.email,
        'register_type': '4',
        'uuid': credential.userIdentifier ?? '',
      };
      print(glData);
      AuthApi authApi = Get.find();
      EasyLoading.show(status: 'loading...');
      var response = await authApi.loginWithSocialMedia(glData);
      EasyLoading.dismiss();
      if (response['status']) {
        print(response['data']);
        await GetStorage().write('token', response['data']);
        await GetStorage().write('username', response['username']);
        updateFcmToken();

        if (GetStorage().read('language_id') == "" ||
            GetStorage().read('language_id') == null) {
          Get.toNamed('/language');
        } else {
          dashboardController.fetchLabelData();
          dashboardController.fetchDashboardData();
          categoryTypeController.fetchTrailsData();
          detailController.getOfflineLocationsData();
          nearByController.getNearByData();
          if (GetStorage().read('user_type') != "U") {
            bottomNavController.updateIndex();

            Get.toNamed('/emp_dashboard');
            guestController.page = 1;
            guestController.showLoadMore = true;
            guestController.forUser.value = false;
            guestController.forUser.refresh();
            guestController.fetchGuestInformationHistory();
          } else {
            bottomNavController.updateIndex();

            Get.toNamed('/dashboard');
            await dashboardController.fetchBeaconData();
            dashboardController.initBeaconService();
          }
        }
      } else {
        Fluttertoast.showToast(
          msg: "There is some problem to google login, please try again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          backgroundColor: Get.theme.indicatorColor,
          textColor: Get.theme.primaryColor,
          fontSize: 15.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "There is some problem to apple login, please try again",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Get.theme.indicatorColor,
        textColor: Get.theme.primaryColor,
        fontSize: 15.0,
      );
    }
  }

  startTimer() {
    bHideTimer.value = true;
    bHideTimer.refresh();
    countTimer.value = 59;
    countTimer.refresh();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      countTimer.value--;
      countTimer.refresh();
      if (countTimer.value == 0) {
        bHideTimer.value = false;
        bHideTimer.refresh();
      }
      if (countTimer.value <= 0) timer.cancel();
    });
  }
}
