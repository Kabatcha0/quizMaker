import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quiz/components/components.dart';
import 'package:quiz/modules/home/home.dart';
import 'package:quiz/modules/sign_in/sign_in.dart';
import 'package:quiz/shared/constant.dart';
import 'package:quiz/shared/local/local.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    uiD = CacheHelper.getData(key: "Uid");

    if (uiD != null) {
      Timer(const Duration(seconds: 4), () {
        navigatorPushReplecement(context: context, widget: Home());
      });
    } else {
      Timer(const Duration(seconds: 4), () {
        navigatorPushReplecement(context: context, widget: SignIn());
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: const TextSpan(
                  text: "Quiz",
                  children: [
                    TextSpan(
                        text: "Maker",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 45,
                            fontWeight: FontWeight.bold))
                  ],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 45,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      )),
    );
  }
}
