import 'dart:io';
import 'package:Mingledxb/screens/sign_up_screen.dart';
import 'package:Mingledxb/screens/update_location_sceen.dart';
import 'package:Mingledxb/screens/welcome_to_mingle_screen.dart';
import 'package:flutter/material.dart';
import 'package:Mingledxb/constants/constants.dart';
import 'package:Mingledxb/helpers/app_helper.dart';
import 'package:Mingledxb/screens/update_app_screen.dart';

import '../models/user_model.dart';
import 'blocked_account_screen.dart';
import 'count_down_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Variables
  final AppHelper _appHelper = AppHelper();
  final List<Color> _colors = [
    APP_ACCENT_COLOR,
    APP_PRIMARY_COLOR,
  ];

  /// Navigate to next page
  void _nextScreen(screen) {
    // Go to next page route
    Future(() {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => screen), (route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    _appHelper.getAppStoreVersion().then((storeVersion) async {
      debugPrint('storeVersion: $storeVersion');

      // Get hard coded App current version
      int appCurrentVersion = 1;
      // Check Platform
      if (Platform.isAndroid) {
        // Get Android version number
        appCurrentVersion = ANDROID_APP_VERSION_NUMBER;
      } else if (Platform.isIOS) {
        // Get iOS version number
        appCurrentVersion = IOS_APP_VERSION_NUMBER;
      }

      /// Compare both versions
      if (storeVersion > appCurrentVersion) {
        /// Go to update app screen
        _nextScreen(const UpdateAppScreen());
        debugPrint("Go to update screen");
      } else {
        /// Authenticate User Account
        UserModel().authUserAccount(
          updateLocationScreen: () => _nextScreen(const UpdateLocationScreen()),
          signInScreen: () => _nextScreen(const WelcomeScreenMingle()),
          signUpScreen: () => _nextScreen(const SignUpScreen()),
          countdownscreen: () => _nextScreen(const CountDownScreen()),
          homeScreen: () => _nextScreen(const HomeScreen()),
          blockedScreen: () => _nextScreen(const BlockedAccountScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              "assets/images/app_logo.jpeg",
              width: double.infinity,
            ),
            const Text(
              "The dating app for",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "people who hate",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "dating apps!!",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            // Align(
            //   alignment: Alignment.center,
            //   child: Container(
            //     margin: const EdgeInsets.only(left: 16, right: 16),
            //     child: const Text(
            //       "The dating app for people who hate dating apps",
            //       style: TextStyle(
            //         fontSize: 16,
            //         color: Colors.white,
            //         fontStyle: FontStyle.italic,
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 30,
            // )
          ],
        ),
      ),
    );
  }
}
