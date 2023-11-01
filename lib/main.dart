import 'dart:io';

// import 'package:artxprochatapp/AppModule/SingleChatModule/Model/users_model.dart';
// import 'package:artxprochatapp/AppModule/SingleChatModule/ViewModel/single_chat_view_model.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

// import 'AppModule/AuthModule/SignUp/Model/user_model.dart';
import 'RoutesAndBindings/app_pages.dart';
import 'RoutesAndBindings/app_routes.dart';
import 'Utils/SizeConfig/size_config.dart';
import 'Utils/Theme/app_theme.dart';
import 'Utils/Theme/theme.dart';
import 'firebase_options.dart';

void getNotification() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: true,
    provisional: true,
    sound: true,
  );
  await FirebaseMessaging.onMessage.listen((event) {
    Get.snackbar(event.notification!.title!, event.notification!.body!);
  });
}

Future<void> main() async {
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    getNotification();

    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseFirestore.instance.collection('users');
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final prefs = await SharedPreferences.getInstance();
    final prefemail = prefs.getString('email');
    final prefpassword = prefs.getString('password');
    if (state == AppLifecycleState.resumed &&
        prefemail != null &&
        prefpassword != null) {
      if (prefemail != '' && prefpassword != '') {
        final userRef = databaseReference.doc(_auth.currentUser!.uid);
        final fcmToken = await FirebaseMessaging.instance.getToken();
        userRef.update({
          "isOnline": true,
          "lastActive": FieldValue.serverTimestamp(),
          'fmcToken': fcmToken
        });
      }
    } else {
      if (_auth.currentUser?.uid != null) {
        final userRef = databaseReference.doc(_auth.currentUser!.uid);
        // FirebaseMessaging.onMessage.listen((event) async {
        //   await onBackgroundHandler();
        // });
        final fcmToken = await FirebaseMessaging.instance.getToken();
        userRef.update(
            {"isOnline": false, "lastActive": FieldValue.serverTimestamp()});
      }
    }
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return GetMaterialApp(
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: child!,
            );
          },
          getPages: AppPages.routes,
          initialRoute: AppRoutes.splashView,
        );
      });
    });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
