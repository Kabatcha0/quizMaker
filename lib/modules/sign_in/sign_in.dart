import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/components/components.dart';
import 'package:quiz/cubit/cubit.dart';
import 'package:quiz/cubit/states.dart';
import 'package:quiz/modules/home/home.dart';
import 'package:quiz/modules/sign_up/sign_up.dart';
import 'package:quiz/shared/local/local.dart';

class SignIn extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SignIn({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizStates>(builder: (context, state) {
      var cubit = QuizCubit.get(context);
      return Scaffold(
        body: SafeArea(
            child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  RichText(
                    text: const TextSpan(
                        text: "Quiz",
                        children: [
                          TextSpan(
                              text: "Maker",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold))
                        ],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: textFromField(
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please enter your Email";
                          }
                          return null;
                        },
                        textEditingController: email,
                        hint: "Email",
                        textInputType: TextInputType.emailAddress),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: textFromField(
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please enter your password";
                          } else if (text.length < 6) {
                            return "please enter ur pass max 6";
                          }
                          return null;
                        },
                        textEditingController: password,
                        hint: "Password",
                        textInputType: TextInputType.emailAddress),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (state is QuizSignInLoadingState)
                    const LinearProgressIndicator(),
                  if (state is QuizSignInLoadingState)
                    const SizedBox(
                      height: 12,
                    ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(30)),
                    child: materialButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.signIn(
                                email: email.text, password: password.text);
                          }
                        },
                        data: "Sign In"),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      InkWell(
                        onTap: () {
                          navigator(context: context, widget: SignUp());
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  )
                ],
              ),
            ),
          ),
        )),
      );
    }, listener: (context, state) {
      if (state is QuizSignInSuccessState) {
        log(state.uid);
        CacheHelper.setData(key: "Uid", value: state.uid).then((value) {
          navigator(context: context, widget: Home());
          log("${CacheHelper.getData(key: "Uid")}");
          log("message");
        }).catchError((e) {
          log(e.toString());
        });
      }
    });
  }
}
