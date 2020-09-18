class DBLocalTrivia {

  int id;
  String name;
  String description;
  String category;
  int points;
  int questionsQuantity;
  bool played;
  bool favorite;

  DBLocalTrivia({
    this.id,
    this.name,
    this.description,
    this.category,
    this.points,
    this.questionsQuantity,
    this.played,
    this.favorite
  });

  factory DBLocalTrivia.fromJson(Map<String, dynamic> json) => DBLocalTrivia(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    category: json["category"],
    points: json["points"],
    questionsQuantity: json["questions_quantity"],
    played: json["played"] == 0 ? false : true,
    favorite: json["favorite"] == 0 ? false : true,
  );
}