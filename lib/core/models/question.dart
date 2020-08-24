class Question {

  int questionIndex;
  String questionLbl;
  int qtyResp;
  int questionTime;
  String respCorrect;
  Map<String, String> responses;

  Question({
    this.questionIndex,
    this.questionLbl,
    this.qtyResp,
    this.questionTime,
    this.respCorrect,
    this.responses
  });

}