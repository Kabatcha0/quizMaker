import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/components/components.dart';
import 'package:quiz/cubit/cubit.dart';
import 'package:quiz/cubit/states.dart';
import 'package:quiz/modules/home/home.dart';
import 'package:quiz/modules/sign_in/sign_in.dart';
import 'package:quiz/shared/local/local.dart';

class SignUp extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SignUp({super.key});

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
                                  color: Color(0xFF448AFF),
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
                            return "Please enter your name";
                          }
                          return null;
                        },
                        textEditingController: name,
                        hint: "Name",
                        textInputType: TextInputType.name),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                  if (state is QuizSignUpLoadingState)
                    const LinearProgressIndicator(),
                  if (state is QuizSignUpLoadingState)
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
                            cubit.signUp(
                                email: email.text,
                                password: password.text,
                                name: name.text);
                          }
                        },
                        data: "Sign Up"),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
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
                          navigatorPushReplecement(
                              context: context, widget: SignIn());
                        },
                        child: const Text(
                          "Sign In",
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
      if (state is QuizSignUpSuccessState) {
        CacheHelper.setData(key: "Uid", value: QuizCubit.get(context).user!)
            .then((value) {
          navigator(context: context, widget: Home());
        }).catchError((e) {
          log(e.toString());
        });
      }
    });
  }
}
