import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/components/components.dart';
import 'package:quiz/cubit/cubit.dart';
import 'package:quiz/cubit/states.dart';
import 'package:quiz/modules/home/home.dart';

class Answer extends StatelessWidget {
  const Answer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizStates>(
      builder: (context, state) {
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
          body: cubit.getQuestion.isEmpty
              ? Container()
              : Builder(builder: (context) {
                  cubit.getListChoose();

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              correctAnswer(
                                  number: cubit.getQuestion.length,
                                  name: "total"),
                              const SizedBox(
                                width: 5,
                              ),
                              correctAnswer(
                                  number:
                                      !cubit.change ? 0 : cubit.correct.length,
                                  name: "correct"),
                              const SizedBox(
                                width: 5,
                              ),
                              correctAnswer(
                                  number: !cubit.change
                                      ? 0
                                      : cubit.incorrect.length,
                                  name: "Incorrect"),
                              const SizedBox(
                                width: 5,
                              ),
                              correctAnswer(
                                  number: cubit.notAttempted,
                                  name: "NotAttempted"),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => question(
                                  function1: () {
                                    cubit.chooseAnswer(index, 0);
                                    cubit.checkCorrect(0);
                                  },
                                  function2: () {
                                    cubit.chooseAnswer(index, 1);
                                    cubit.checkCorrect(1);
                                  },
                                  function3: () {
                                    cubit.chooseAnswer(index, 2);
                                    cubit.checkCorrect(2);
                                  },
                                  function4: () {
                                    cubit.chooseAnswer(index, 3);
                                    cubit.checkCorrect(3);
                                  },
                                  index: index + 1,
                                  ques: cubit.getQuestion[index].question,
                                  option1: cubit.getQuestion[index].option1,
                                  option2: cubit.getQuestion[index].option2,
                                  option3: cubit.getQuestion[index].option3,
                                  option4: cubit.getQuestion[index].option4,
                                  list: cubit.choose),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness: 0.8,
                                    ),
                                  ),
                              itemCount: cubit.getQuestion.length),
                        )
                      ],
                    ),
                  );
                }),
          floatingActionButton: cubit.change
              ? FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    navigatorPushReplecement(context: context, widget: Home());
                  },
                  child: const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 30,
                  ))
              : FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    cubit.notAttemptedCheck(cubit.getQuestion.length);
                  },
                  child: const Icon(
                    Icons.verified,
                    color: Colors.white,
                    size: 30,
                  )),
        );
      },
      listener: (context, state) {},
    );
  }
}
