import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/components/components.dart';
import 'package:quiz/cubit/cubit.dart';
import 'package:quiz/cubit/states.dart';
import 'package:quiz/modules/add_question/add_question.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatelessWidget {
  TextEditingController quizImageUrl = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController type = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CreateQuiz({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizStates>(builder: (context, state) {
      var cubit = QuizCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 28,
                color: Colors.black,
              )),
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
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // textFromField(
                  //     textEditingController: type,
                  //     hint: "Type",
                  //     validator: (text) {
                  //       return null;
                  //     },
                  //     textInputType: TextInputType.name),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  textFromField(
                      textEditingController: quizImageUrl,
                      hint: "Quiz Image Url (Optional)",
                      validator: (text) {
                        return null;
                      },
                      textInputType: TextInputType.name),
                  const SizedBox(
                    height: 10,
                  ),
                  textFromField(
                      textEditingController: title,
                      hint: "Title",
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Please enter your Title";
                        }
                        return null;
                      },
                      textInputType: TextInputType.name),
                  const SizedBox(
                    height: 10,
                  ),
                  textFromField(
                      textEditingController: description,
                      hint: "Description",
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Please enter your Description";
                        }
                        return null;
                      },
                      textInputType: TextInputType.name),
                  const Spacer(),
                  if (state is QuizDataLoadingState) ...[
                    const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(30)),
                    child: materialButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.addTypeQuiz(quiz: {
                              "quizId": title.text,
                              "quizImageUrl": quizImageUrl.text == ""
                                  ? ""
                                  : quizImageUrl.text,
                              "quizTitle": title.text,
                              "quizDesc": description.text,
                            }, quizName: title.text);
                          }
                        },
                        data: "Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is QuizDataSuccessState) {
        navigator(
            context: context,
            widget: AddQuestion(
              quizName: title.text,
            ));
      }
    });
  }
}
