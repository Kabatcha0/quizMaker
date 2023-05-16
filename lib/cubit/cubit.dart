import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/cubit/states.dart';
import 'package:quiz/models/questions_model.dart';
import 'package:quiz/models/type_quiz.dart';
import 'package:random_string/random_string.dart';

class QuizCubit extends Cubit<QuizStates> {
  QuizCubit() : super(QuizInitialState());
  static QuizCubit get(context) => BlocProvider.of(context);
  List<List> choose = [];
  List correct = [];
  List incorrect = [];

  int notAttempted = 0;
  void getListChoose() {
    for (int i = 0; getQuestion.length > i; i++) {
      choose.add([false, false, false, false]);
    }
    emit(QuizGetChooseState());
  }

  bool change = false;
  void notAttemptedCheck(int total) {
    notAttempted = total - (correct.length) - (incorrect.length);
    if (notAttempted < 0) notAttempted = 0;
    change = !change;
    emit(QuizCheckAnswerNotAttemptedState());
  }

  void checkCorrect(int index) {
    if (index == 0) {
      correct.add(true);
    } else {
      incorrect.add(false);
    }
    emit(QuizCheckAnswerCorrectState());
  }

  void getChoose() {
    choose.add([false, false, false, false]);
    log("${choose.length}");
    emit(QuizChooseState());
  }

  void chooseAnswer(int index, int number) {
    choose[index] = choose[index].map((e) => false).toList();
    choose[index][number] = !choose[index][number];

    emit(QuizChooseState());
  }

  String? user;
  void signIn({
    required String email,
    required String password,
  }) {
    emit(QuizSignInLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      user = value.user!.uid;
      emit(QuizSignInSuccessState(uid: user!));
    }).catchError((e) {
      log(e.toString());
      emit(QuizSignInErrorState());
    });
  }

  void saveSignUp(
      {required String email, required String password, required String name}) {
    FirebaseFirestore.instance.collection("users").doc(user!).set({
      "email": email,
      "password": password,
      "name": name,
      "uid": user
    }).then((value) {
      emit(QuizSignUpSuccessState(uid: user!));
    }).catchError((e) {
      log(e.toString());
      emit(QuizSignUpErrorState());
    });
  }

  void addTypeQuiz(
      {required Map<String, dynamic> quiz, required String quizName}) {
    emit(QuizDataLoadingState());
    FirebaseFirestore.instance
        .collection("QuizQuestions")
        .doc(quizName)
        .set(quiz)
        .then((value) {
      emit(QuizDataSuccessState());
    }).catchError((e) {
      log(e.toString());
      emit(QuizDataErrorState());
    });
  }

  void deleteType({
    required String quizName,
  }) {
    emit(QuizDeleteTypeQuestionsLoadingState());
    FirebaseFirestore.instance
        .collection("QuizQuestions")
        .doc(quizName)
        .delete()
        .then((value) {
      FirebaseFirestore.instance
          .collection("QuizQuestions")
          .doc(quizName)
          .collection("question")
          .get()
          .then((value) {
        value.docs.forEach((e) {
          e.reference.delete();
        });
        typeQuiz = [];
        emit(QuizDeleteTypeQuestionsSuccessState());
      }).catchError((e) {
        log(e.toString());
      });
    }).catchError((e) {
      log(e.toString());
      emit(QuizDeleteTypeQuestionsErrorState());
    });
  }

  void addQuestions(
      {required String quizName, required Map<String, String> quizModel}) {
    emit(QuizAddQuestionsLoadingState());
    FirebaseFirestore.instance
        .collection("QuizQuestions")
        .doc(quizName)
        .collection("question")
        .add(quizModel)
        .then((value) {
      emit(QuizAddQuestionsSuccessState());
    }).catchError((e) {
      log(e.toString());
      emit(QuizAddQuestionsErrorState());
    });
  }

  void signUp(
      {required String email, required String password, required String name}) {
    emit(QuizSignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      user = value.user!.uid;
      saveSignUp(email: email, password: password, name: name);
    }).catchError((e) {
      log(e.toString());
    });
  }

  void signOut() {
    FirebaseAuth.instance.signOut().then((value) {
      user = null;
      emit(QuizSignOutSuccessState());
    }).catchError((e) {
      log(e.toString());
      emit(QuizSignOutErrorState());
    });
  }

  List<TypeQuiz> typeQuiz = [];
  void getTypeQuiz() {
    emit(QuizTypeQuizLoadingState());
    typeQuiz = [];
    FirebaseFirestore.instance.collection("QuizQuestions").get().then((value) {
      for (var element in value.docs) {
        typeQuiz.add(TypeQuiz.fromJson(element.data()));
        emit(QuizTypeQuizSuccessState());
      }
    }).catchError((e) {
      log(e.toString());
      emit(QuizTypeQuizErrorState());
    });
  }

  List<GetQuestions> getQuestion = [];
  void getQuestions({required String name}) {
    getQuestion = [];
    emit(QuizGetQuestionsLoadingState());
    FirebaseFirestore.instance
        .collection("QuizQuestions")
        .doc(name)
        .collection("question")
        .get()
        .then((value) {
      value.docs.forEach((e) {
        getQuestion.add(GetQuestions.fromJosn(e.data()));
        log("message dc");
        emit(QuizGetQuestionsSuccessState());
      });
    }).catchError((e) {
      log(e.toString());
      emit(QuizGetQuestionsErrorState());
    });
  }
}
