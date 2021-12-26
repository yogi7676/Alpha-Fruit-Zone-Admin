import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodbuddy/app/helper/app_constants.dart';
import 'package:foodbuddy/app/helper/notification_service.dart';

import 'package:foodbuddy/app/screens/dashboard.dart';
import 'package:foodbuddy/app/screens/login.dart';
import 'package:foodbuddy/app/ui_widgets/noglowbehaviour.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initialize();
  await Firebase.initializeApp();
  runApp(const FoodBuddy());
}
 

class FoodBuddy extends StatefulWidget {
  const FoodBuddy({Key? key}) : super(key: key);

  @override
  State<FoodBuddy> createState() => _FoodBuddyState();
}

class _FoodBuddyState extends State<FoodBuddy> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(behavior: NoGlowBehaviour(), child: child!);
      },
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snap) {
            if (snap.hasData) {
              return const DashBoard();
            }
            return const Login();
          }),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch:
              generateMaterialColor(Color(AppConstants.primaryColor)),
          textTheme: TextTheme(
            headline1: GoogleFonts.openSans(
                fontSize: 95, fontWeight: FontWeight.w300, letterSpacing: -1.5),
            headline2: GoogleFonts.openSans(
                fontSize: 59, fontWeight: FontWeight.w300, letterSpacing: -0.5),
            headline3:
                GoogleFonts.openSans(fontSize: 48, fontWeight: FontWeight.w400),
            headline4: GoogleFonts.openSans(
                fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            headline5:
                GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w400),
            headline6: GoogleFonts.openSans(
                fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
            subtitle1: GoogleFonts.openSans(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
            subtitle2: GoogleFonts.openSans(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
            bodyText1: GoogleFonts.openSans(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
            bodyText2: GoogleFonts.openSans(
                fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            button: GoogleFonts.openSans(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
            caption: GoogleFonts.openSans(
                fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
            overline: GoogleFonts.openSans(
                fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
          )),
      title: 'Alpha Fruit Zone',
    );
  }
}
