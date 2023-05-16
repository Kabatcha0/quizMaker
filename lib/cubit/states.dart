abstract class QuizStates {}

class QuizInitialState extends QuizStates {}

class QuizSignUpSuccessState extends QuizStates {
  String uid;
  QuizSignUpSuccessState({required this.uid});
}

class QuizSignUpErrorState extends QuizStates {}

class QuizChooseState extends QuizStates {}

class QuizSignInSuccessState extends QuizStates {
  String uid;
  QuizSignInSuccessState({required this.uid});
}

class QuizSignInErrorState extends QuizStates {}

class QuizSignInLoadingState extends QuizStates {}

class QuizSignUpLoadingState extends QuizStates {}

class QuizSignOutSuccessState extends QuizStates {}

class QuizSignOutErrorState extends QuizStates {}

class QuizDataLoadingState extends QuizStates {}

class QuizDataSuccessState extends QuizStates {}

class QuizDataErrorState extends QuizStates {}

class QuizAddQuestionsLoadingState extends QuizStates {}

class QuizAddQuestionsSuccessState extends QuizStates {}

class QuizAddQuestionsErrorState extends QuizStates {}

class QuizTypeQuizLoadingState extends QuizStates {}

class QuizTypeQuizSuccessState extends QuizStates {}

class QuizTypeQuizErrorState extends QuizStates {}

class QuizGetQuestionsLoadingState extends QuizStates {}

class QuizGetQuestionsSuccessState extends QuizStates {}

class QuizGetQuestionsErrorState extends QuizStates {}

class QuizDeleteTypeQuestionsLoadingState extends QuizStates {}

class QuizDeleteTypeQuestionsSuccessState extends QuizStates {}

class QuizDeleteTypeQuestionsErrorState extends QuizStates {}

class QuizGetChooseState extends QuizStates {}

class QuizGetListChooseState extends QuizStates {}

class QuizCheckAnswerCorrectState extends QuizStates {}

class QuizCheckAnswerIncorrectState extends QuizStates {}

class QuizCheckAnswerNotAttemptedState extends QuizStates {}
