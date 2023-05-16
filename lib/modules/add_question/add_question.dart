import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/components/components.dart';
import 'package:quiz/cubit/cubit.dart';
import 'package:quiz/cubit/states.dart';
import 'package:quiz/modules/home/home.dart';

class AddQuestion extends StatelessWidget {
  TextEditingController questions = TextEditingController();
  TextEditingController option1 = TextEditingController();
  TextEditingController option2 = TextEditingController();
  TextEditingController option3 = TextEditingController();
  TextEditingController option4 = TextEditingController();
  String quizName;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AddQuestion({super.key, required this.quizName});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizStates>(builder: (context, state) {
      var cubit = QuizCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
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
                  textFromField(
                      textEditingController: questions,
                      hint: "Questions",
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Please enter your Question";
                        }
                        return null;
                      },
                      textInputType: TextInputType.name),
                  const SizedBox(
                    height: 10,
                  ),
                  textFromField(
                      textEditingController: option1,
                      hint: "Option1",
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Please enter your Option1";
                        }
                        return null;
                      },
                      textInputType: TextInputType.name),
                  const SizedBox(
                    height: 10,
                  ),
                  textFromField(
                      textEditingController: option2,
                      hint: "Option2",
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Please enter your Option2";
                        }
                        return null;
                      },
                      textInputType: TextInputType.name),
                  const SizedBox(
                    height: 10,
                  ),
                  textFromField(
                      textEditingController: option3,
                      hint: "Option3",
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Please enter your Option3";
                        }
                        return null;
                      },
                      textInputType: TextInputType.name),
                  const SizedBox(
                    height: 10,
                  ),
                  textFromField(
                      textEditingController: option4,
                      hint: "Option4",
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Please enter your Option4";
                        }
                        return null;
                      },
                      textInputType: TextInputType.name),
                  const Spacer(),
                  if (state is QuizAddQuestionsLoadingState) ...[
                    const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(30)),
                        child: materialButton(
                            function: () {
                              cubit.getTypeQuiz();
                              cubit.getQuestions(name: quizName);
                              navigatorPushReplecement(
                                  context: context, widget: Home());
                            },
                            data: "Sumbit"),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(30)),
                        child: materialButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.addQuestions(
                                    quizName: quizName,
                                    quizModel: {
                                      "question": questions.text,
                                      "option1": option1.text,
                                      "option2": option2.text,
                                      "option3": option3.text,
                                      "option4": option4.text,
                                    });
                                cubit.getTypeQuiz();
                                if (quizName == "Science") {
                                  cubit.getQuestions(name: "Science");
                                } else if (quizName == "Countries") {
                                  cubit.getQuestions(name: "Countries");
                                } else if (quizName == "Movies") {
                                  cubit.getQuestions(name: "Movies");
                                } else {
                                  cubit.getQuestions(
                                      name: "general information");
                                }
                                cubit.getChoose();
                                navigator(
                                    context: context,
                                    widget: AddQuestion(
                                      quizName: quizName,
                                    ));
                              }
                            },
                            data: "Add Question"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is QuizAddQuestionsSuccessState) {
        navigator(
            context: context,
            widget: AddQuestion(
              quizName: quizName,
            ));
      }
    });
  }
}
