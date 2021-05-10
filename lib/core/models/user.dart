class User {

  String id;
  String name;
  String lastname;
  String username;    
  String birthdate;
  String phone;
  String grade;
  String avatar;
  String city;
  int score;
  bool isValidated;

  User({
    this.id,
    this.name,
    this.lastname,
    this.username,
    this.birthdate,
    this.phone,
    this.grade,
    this.avatar,
    this.city,
    this.score,
    this.isValidated
  });

  factory User.fromDocument(Map<String, dynamic> data) => User(
    id : data["id"],
    name : data["name"],
    lastname : data["lastname"],
    username : data["username"],
    birthdate : data["birthdate"],
    phone : data["phone"].toString(),
    grade : data["grade"],
    avatar : data["avatar"],
    city : data["city"],
    score: data["score"],
    isValidated: data["isValidated"]
  );
}