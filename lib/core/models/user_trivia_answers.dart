class UserTriviaAnswers {

  List<Map<String, dynamic>> answers;

  UserTriviaAnswers() {
    answers = List<Map<String, dynamic>>();
  }

  factory UserTriviaAnswers.fromDocument(Map<String, dynamic> data) {
    List<dynamic> auxiliar = List<dynamic>.from(data["answers"]);
    UserTriviaAnswers auxiliarUserTriviaAnswers = UserTriviaAnswers();
    
    auxiliar.forEach((answer) {
        auxiliarUserTriviaAnswers.answers.add(Map<String, dynamic>.from(answer));
    });

    return auxiliarUserTriviaAnswers;
  }
}