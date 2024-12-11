import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../main.dart';
import '../../api/apis.dart';
import 'auth/login_screen.dart';
import 'home_screen.dart';

//splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      //exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white));

      log('\nUser: ${APIs.auth.currentUser}');

      //navigate
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (_) => APIs.auth.currentUser != null
                ? const HomeScreen()
                : const LoginScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    mq = MediaQuery.sizeOf(context);

    return Scaffold(
      //body
      body: Stack(children: [
        //app logo
        Positioned(
            top: mq.height * .15,
            right: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset('assets/images/icon.png')),

        //text with copyright
        Positioned(
          bottom: mq.height * .15,
          width: mq.width,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'MADE IN NEPAL WITH ❤️',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: Colors.black87, letterSpacing: .5),
              ),
              SizedBox(height: 5), // Spacing between the two texts
              Text(
                'aniklinkin.np ©',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14, color: Colors.black54, letterSpacing: .5),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
