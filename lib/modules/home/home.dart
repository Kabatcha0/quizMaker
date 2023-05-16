import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/components/components.dart';
import 'package:quiz/cubit/cubit.dart';
import 'package:quiz/cubit/states.dart';
import 'package:quiz/modules/answer/answer.dart';
import 'package:quiz/modules/create_quiz/create_quiz.dart';
import 'package:quiz/modules/sign_in/sign_in.dart';
import 'package:quiz/shared/local/local.dart';
import 'package:random_string/random_string.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizStates>(
        builder: (context, state) {
          var cubit = QuizCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                IconButton(
                    onPressed: () {
                      CacheHelper.removeData(key: "uid").then((value) {
                        cubit.signOut();
                        navigatorPushReplecement(
                            context: context, widget: SignIn());
                      }).catchError((e) {
                        log(e.toString());
                      });
                    },
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.black,
                      size: 32,
                    ))
              ],
              title: RichText(
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
              centerTitle: true,
            ),
            body: (state is QuizAddQuestionsLoadingState &&
                    cubit.typeQuiz.isEmpty &&
                    cubit.getQuestion.isEmpty)
                ? Container()
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => containerHome(
                        functionType: () {
                          if (cubit.typeQuiz[index].quizTitle == "Science") {
                            cubit.deleteType(quizName: "Science");
                          } else if (cubit.typeQuiz[index].quizTitle ==
                              "Countries") {
                            cubit.deleteType(quizName: "Countries");
                          } else if (cubit.typeQuiz[index].quizTitle ==
                              "Movies") {
                            cubit.deleteType(quizName: "Movies");
                          } else {
                            cubit.deleteType(quizName: "general information");
                          }
                        },
                        function: () {
                          cubit.change = false;
                          if (cubit.typeQuiz[index].quizTitle == "Science") {
                            cubit.getQuestions(name: "Science");
                          } else if (cubit.typeQuiz[index].quizTitle ==
                              "Countries") {
                            cubit.getQuestions(name: "Countries");
                          } else if (cubit.typeQuiz[index].quizTitle ==
                              "Movies") {
                            cubit.getQuestions(name: "Movies");
                          } else {
                            cubit.getQuestions(name: "General Information");
                          }
                          navigator(context: context, widget: const Answer());
                        },
                        title: cubit.typeQuiz[index].quizTitle,
                        desc: cubit.typeQuiz[index].quizDesc),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 0,
                        ),
                    itemCount: cubit.typeQuiz.length),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  navigator(context: context, widget: CreateQuiz());
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                )),
          );
        },
        listener: (context, state) {});
  }
}
