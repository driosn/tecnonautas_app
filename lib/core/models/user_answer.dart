class UserAnswer {

  Map<String, double> scores;
  Map<String, dynamic> responses;
  String triviaName;
  double totalScore;

  UserAnswer({
    this.scores,
    this.responses,
    this.triviaName,
    this.totalScore
  });

  factory UserAnswer.fromMap(Map<String, dynamic> data) => UserAnswer(
    scores: Map<String, double>.from(data["scores"]),
    responses: Map<String, dynamic>.from(data["responses"]),
    triviaName: data["triviaName"],
    totalScore: data["totalScore"],
  );
}