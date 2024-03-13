import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core.dart';
import 'routes.dart' as r;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await initService();
  // await Helper.getCurrentUser();
  await Firebase.initializeApp();
  // SplashController splashController = Get.find();
  // splashController.backgroundMsg(message);
  // Helper.onBackgroundSound(message);
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description,
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  await GlobalConfiguration().loadFromAsset("configuration");
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  FlutterDownloader.registerCallback(TestClass.callback);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  Firebase.initializeApp();
  await initService();

  configLoading();

  runApp(GetMaterialApp(
    title: 'Bhagat Singh Museum',
    debugShowCheckedModeBanner: false,
    defaultTransition: Transition.rightToLeft,
    getPages: r.Router.route,
    initialRoute: '/',
    themeMode: ThemeMode.light,
    builder: (context, widget) {
      widget = EasyLoading.init()(context, widget);
      return MediaQuery(
        child: widget,
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      );
      // return widget;
    },
    theme: ThemeData(
      backgroundColor: const Color(0xffF6FBF8),
      primaryColor: const Color(0xffFFFFFF),
      primaryColorDark: const Color(0xffFFFFFF),
      indicatorColor: const Color(0xff000000),
      brightness: Brightness.light,
      errorColor: const Color(0xffF6534C),
      buttonTheme: ButtonThemeData(
          buttonColor: Helper.parseColorCode(Get.find<ConfigService>()
              .configData
              .value
              .btnColorLight), //  <-- dark color
          textTheme: ButtonTextTheme.primary, //
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Helper.parseColorCode(
                  Get.find<ConfigService>().configData.value.btnColorLight),
              secondary: Helper.parseColorCode(Get.find<ConfigService>()
                  .configData
                  .value
                  .btnTextColorLight)) // <-- this auto selects the right color
          ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xffF2660F),
        secondary: const Color(0xffEC9912),
      ),
      highlightColor: Colors.white,
      hintColor: Colors.grey[300],
      textTheme: TextTheme(
        headline6: GoogleFonts.poppins().copyWith(
            fontSize: 10,
            color: Helper.parseColorCode(
                Get.find<ConfigService>().configData.value.textColorLight),
            fontWeight: FontWeight.bold,
            fontFamily: 'Gilroy'),
        headline5: GoogleFonts.poppins().copyWith(
            fontSize: 12,
            color: Helper.parseColorCode(
                Get.find<ConfigService>().configData.value.textColorLight),
            fontWeight: FontWeight.bold,
            fontFamily: 'Gilroy'),
        headline4: GoogleFonts.poppins().copyWith(
            fontSize: 14,
            color: Helper.parseColorCode(
                Get.find<ConfigService>().configData.value.textColorLight),
            fontWeight: FontWeight.bold,
            fontFamily: 'Gilroy'),
        headline3: GoogleFonts.poppins().copyWith(
            fontSize: 16,
            color: Helper.parseColorCode(
                Get.find<ConfigService>().configData.value.textColorLight),
            fontWeight: FontWeight.bold,
            fontFamily: 'Gilroy'),
        headline2: GoogleFonts.poppins().copyWith(
            fontSize: 18,
            color: Helper.parseColorCode(
                Get.find<ConfigService>().configData.value.textColorLight),
            fontWeight: FontWeight.bold,
            fontFamily: 'Gilroy'),
        headline1: GoogleFonts.poppins().copyWith(
            fontSize: 20,
            color: Helper.parseColorCode(
                Get.find<ConfigService>().configData.value.textColorLight),
            fontWeight: FontWeight.bold,
            fontFamily: 'Gilroy'),
        subtitle1: GoogleFonts.poppins(),
        bodyText1: GoogleFonts.poppins().copyWith(
            fontSize: 15,
            color: Helper.parseColorCode(
                Get.find<ConfigService>().configData.value.textColorLight),
            fontWeight: FontWeight.w400,
            fontFamily: 'Gilroy'),
        bodyText2: GoogleFonts.poppins().copyWith(
            fontSize: 14,
            color: Helper.parseColorCode(
                Get.find<ConfigService>().configData.value.textColorLight),
            fontWeight: FontWeight.w400,
            fontFamily: 'Gilroy'),
      ),
    ),
  ));
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

initService() async {
  await GetStorage.init();
  Get.put(AuthService(), permanent: true);
  Get.put(ConfigService(), permanent: true);
  Get.put(CommonService(), permanent: true);
  // Get.put(ConfigController(), permanent: true);
  // Get.put(SplashController(), permanent: true);
  Get.put(ConfigApi(), permanent: true);
}

class TestClass {
  static void callback(String id, DownloadTaskStatus status, int progress) {}
}
