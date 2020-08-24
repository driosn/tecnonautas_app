class UserRanking {

  String id;
  String userId;
  String username;
  String userAvatar;
  double points;
  int position;
  int coins;
  List<String> trivias;
  int correctQuestions;
  int incorrectQuestions;
  int notPlayedTrivias; 

  UserRanking({
    this.id,
    this.userId,
    this.username,
    this.userAvatar,
    this.points,
    this.position,
    this.coins,
    this.trivias,
    this.correctQuestions,
    this.incorrectQuestions,
    this.notPlayedTrivias,
  });

  factory UserRanking.fromSnapshotData(Map<String, dynamic> data) {
    UserRanking auxiliarUserRanking = UserRanking(
    id : data["id"],
    userId : data["userId"],
    username : data["username"],
    userAvatar : data["userAvatar"],
    points : double.parse(data["points"].toString()),
    position : data["position"],
    coins : data["coins"],
    trivias : List<String>.from(data["trivias"]),
    correctQuestions : data["correctQuestions"],
    incorrectQuestions : data["incorrectQuestions"],
    notPlayedTrivias : data["notPlayedTrivias"],
    );

    return auxiliarUserRanking;
  }

}