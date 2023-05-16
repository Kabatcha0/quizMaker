class TypeQuiz {
  late String quizDesc;
  late String quizId;
  late String quizImageUrl;
  late String quizTitle;
  TypeQuiz({
    required this.quizDesc,
    required this.quizId,
    required this.quizImageUrl,
    required this.quizTitle,
  });
  TypeQuiz.fromJson(Map<String, dynamic> json) {
    quizDesc = json["quizDesc"];
    quizId = json["quizId"];
    quizImageUrl = json["quizImageUrl"];
    quizTitle = json["quizTitle"];
  }
}
