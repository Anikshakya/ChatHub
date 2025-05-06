import 'dart:developer';
import 'package:flutter/material.dart';
import '../../api/apis.dart';
import '../../helper/dialogs.dart';
import '../../main.dart';
import '../home_screen.dart';
import '../../services/google_auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => _isAnimate = true);
    });
  }

  // Google Sign-In handler
  Future<void> _handleGoogleBtnClick() async {
    Dialogs.showLoading(context);

    final user = await GoogleAuthService.signInWithGoogle();

    // hide progress bar
    if (!mounted) return;
    Navigator.pop(context);

    if (user != null) {
      log('User: ${user.user}');
      log('Additional Info: ${user.additionalUserInfo}');

      if (await APIs.userExists()) {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        await APIs.createUser();
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }
      }
    } else {
      Dialogs.showSnackbar(context, 'Something went wrong. Try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Welcome to ChatHub'),
      ),
      body: Stack(children: [
        AnimatedPositioned(
          top: mq.height * .15,
          right: _isAnimate ? mq.width * .25 : -mq.width * .5,
          width: mq.width * .5,
          duration: const Duration(seconds: 1),
          child: Image.asset('assets/images/icon.png'),
        ),
        Positioned(
          bottom: mq.height * .15,
          left: mq.width * .05,
          width: mq.width * .9,
          height: mq.height * .06,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 223, 255, 187),
              shape: const StadiumBorder(),
              elevation: 1,
            ),
            onPressed: _handleGoogleBtnClick,
            icon: Image.asset('assets/images/google.png', height: mq.height * .03),
            label: RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(text: 'Login with '),
                  TextSpan(
                    text: 'Google',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
