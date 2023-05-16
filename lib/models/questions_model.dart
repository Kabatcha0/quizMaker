class GetQuestions {
  late String question;
  late String option1;
  late String option2;
  late String option3;
  late String option4;
  GetQuestions.fromJosn(Map<String, dynamic> json) {
    question = json["question"];
    option1 = json["option1"];
    option2 = json["option2"];
    option3 = json["option3"];
    option4 = json["option4"];
  }
}
