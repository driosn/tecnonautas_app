import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tecnonautas_app/core/models/trivia.dart';
import 'package:tecnonautas_app/core/models/user.dart';

class UserPreferences {

  static final _singleton = UserPreferences._();

  factory UserPreferences() => _singleton;

  UserPreferences._();

  SharedPreferences _prefs;

  initPreferences() async {
    this._prefs = await SharedPreferences.getInstance();
  } 

  // User fields

  String get id {
    return _prefs.getString("id") ?? null;
  }

  String get name {
    return _prefs.getString("name") ?? null;
  }

  String get lastname {
    return _prefs.getString("lastname") ?? null;
  }

  String get username {
    return _prefs.getString("username") ?? null;
  }

  String get birthdate {
    return _prefs.getString("birthdate") ?? null;
  }

  String get phone {
    return _prefs.getString("phone") ?? null;
  }

  String get grade {
    return _prefs.getString("grade") ?? null;
  }

  String get avatar {
    return _prefs.getString("avatar") ?? null;
  }

  String get city {
    return _prefs.getString("city") ?? null;
  }

  bool get isValidated {
    return _prefs.getBool("is_validated") ?? false;
  }

  String get questionsAnswered {
    return _prefs.getString("questions_answered") ?? "{}";
  }

  // Local Trivias
  List<String> get triviasLocalInfo {
    return _prefs.getStringList("trivias_local_info") ?? List<String>();
  }

  List<String> get triviasLocalScores {
    return _prefs.getStringList("trivias_local_scores") ?? List<String>();
  }

  void updateId(String mValue) {
    _prefs.setString("id", mValue);
  }

  void updateName(String mValue) {
    _prefs.setString("name", mValue);
  }

  void updateLastname(String mValue) {
    _prefs.setString("lastname", mValue);
  }

  void updateUsername(String mValue) {
    _prefs.setString("username", mValue);
  }

  void updateBirthdate(String mValue) {
    _prefs.setString("birthdate", mValue);
  }

  void updatePhone(String mValue) {
    _prefs.setString("phone", mValue);
  }

  void updateGrade(String mValue) {
    _prefs.setString("grade", mValue);
  }

  void updateAvatar(String mValue) {
    _prefs.setString("avatar", mValue);
  }

  void updateCity(String mValue) {
    _prefs.setString("city", mValue);
  }

  void updateIsValidated(bool mValue) {
    _prefs.setBool("is_validated", mValue);
  }

  void updateQuestionsAnswered(String mQuestionsAnswered) {
    _prefs.setString("questions_answered", mQuestionsAnswered);
  }

  // Local Trivias Info
  void updateTriviasLocalInfo(List<String> mNewList) {
    _prefs.setStringList("trivias_local_info", mNewList);
  }

  void updateTriviasLocalScores(List<String> mNewList) {
    _prefs.setStringList("trivias_local_scores", mNewList);
  }

  void addQuestionAnswered(String mQuestionName, String mResult) {
    Map<String, dynamic> currentQuestionsAnswered = json.decode(questionsAnswered) ?? Map<String, String>();

    if (!currentQuestionsAnswered.containsKey(mQuestionName)) {
      currentQuestionsAnswered.putIfAbsent(mQuestionName, () => mResult);
    }

    updateQuestionsAnswered(json.encode(currentQuestionsAnswered));
  }

  String getQuestionStatus(String mQuestionName) {
    Map<String, dynamic> currentQuestionsAnswered = json.decode(questionsAnswered) ?? Map<String, String>();
  
    if (!currentQuestionsAnswered.containsKey(mQuestionName)) {
      return "Not Answered";
    } else {
      if (currentQuestionsAnswered[mQuestionName] == "") return "Ready";
      return currentQuestionsAnswered[mQuestionName];
    }
  }

  // Returns Correct or Incorrect
  String getQuestionResult(String mQuestionName) {
    Map<String, dynamic> currentQuestionsAnswered = json.decode(questionsAnswered) ?? Map<String, String>();
    return currentQuestionsAnswered[mQuestionName];
  }

  void clearQuestionAnswered(String mQuestionName) {
    Map<String, String> currentQuestionsAnswered = json.decode(questionsAnswered) ?? Map<String, String>();

    if (currentQuestionsAnswered.containsKey(mQuestionName)) {
      currentQuestionsAnswered[mQuestionName] = "Not Answered";
    }

    updateQuestionsAnswered(json.encode(currentQuestionsAnswered));
  }

  void addTriviaInfo(Trivia mTrivia) {
    bool existTrivia = false;

    List<String> currentTriviaInfo = this.triviasLocalInfo;
    for(int i = 0; i < currentTriviaInfo.length; i++) {
      Map<String, dynamic> auxiliarMap = json.decode(currentTriviaInfo[i]);

      if (auxiliarMap["name"] == mTrivia.name) {
        existTrivia = true;
        break;
      }
    }

    if (!existTrivia) {
      Map<String, dynamic> newInfoMap = createTriviaInfoMap(mTrivia);
      currentTriviaInfo.add(json.encode(newInfoMap));
      updateTriviasLocalInfo(currentTriviaInfo);
    }
  }

  void updateQuestionResponse(Trivia mTrivia, int mQuestionIndex, String mAnswer) {
    int triviaIndex = -1;
    List<String> currentTriviaInfo = this.triviasLocalInfo;
    for(int i = 0; i < currentTriviaInfo.length; i++) {
      Map<String, dynamic> auxiliarMap = json.decode(currentTriviaInfo[i]);

      if (auxiliarMap["name"] == mTrivia.name) {
        triviaIndex = i;
        break;
      }
    }

    if (triviaIndex != -1) {
      Map<String, dynamic> foundedMap = json.decode(currentTriviaInfo[triviaIndex]);
      foundedMap["responses"]["question$mQuestionIndex"] = mAnswer;

      currentTriviaInfo.removeAt(triviaIndex);
      currentTriviaInfo.insert(triviaIndex, json.encode(foundedMap));
      updateTriviasLocalInfo(currentTriviaInfo);
    }
  }

  void updateQuestionScore(Trivia mTrivia, int mQuestionIndex, String mAnswer) {
    int triviaIndex = -1;
    List<String> currentTriviaScores = this.triviasLocalScores;
    for(int i = 0; i < currentTriviaScores.length; i++) {
      Map<String, dynamic> auxiliarMap = json.decode(currentTriviaScores[i]);

      if (auxiliarMap["name"] == mTrivia.name) {
        triviaIndex = i;
        break;
      }
    }

    if (triviaIndex != -1) {
      Map<String, dynamic> foundedMap = json.decode(currentTriviaScores[triviaIndex]);
      if (mTrivia.respCorrect["question$mQuestionIndex"] == mAnswer) {
        double scorePerQuestion = mTrivia.points / mTrivia.qtyPreg;
        foundedMap["points"] = foundedMap["points"] + scorePerQuestion;

        currentTriviaScores.removeAt(triviaIndex);
        currentTriviaScores.insert(triviaIndex, json.encode(foundedMap));
        updateTriviasLocalScores(currentTriviaScores);
      }
    }
  }

  Map<String, dynamic> createTriviaInfoMap(Trivia mTrivia) {
    Map<String, dynamic> auxiliarMap = Map<String, dynamic>();

    Map<String, dynamic> createResponsesMap(Trivia mTrivia) {
      Map<String, dynamic> responsesMap = Map<String, dynamic>();
      for(int i = 0; i < mTrivia.qtyPreg; i++) {
        responsesMap.putIfAbsent("question$i", () => "");
      }
      return responsesMap;
    }

    auxiliarMap = {
      "id" : mTrivia.id,
      "name" : mTrivia.name,
      "responses" : createResponsesMap(mTrivia)
    };
    return auxiliarMap;
  }

  void addTriviaScore(Trivia mTrivia) {
    bool existTrivia = false;

    List<String> currentTriviaScores = this.triviasLocalScores;
    for(int i = 0; i < currentTriviaScores.length; i++) {
      Map<String, dynamic> auxiliarMap = json.decode(currentTriviaScores[i]);

      if (auxiliarMap["name"] == mTrivia.name) {
        existTrivia = true;
        break;
      }
    }

    if (!existTrivia) {
      Map<String, dynamic> newInfoMap = createTriviaScoreMap(mTrivia);
      currentTriviaScores.add(json.encode(newInfoMap));
      updateTriviasLocalScores(currentTriviaScores);
    }
  }

  Map<String, dynamic> createTriviaScoreMap(Trivia mTrivia) {
    Map<String, dynamic> auxiliarMap = Map<String, dynamic>();

    auxiliarMap = {
      "id" : mTrivia.id,
      "name" : mTrivia.name,
      "points" : 0.0
    };
    return auxiliarMap;
  }

  int getAnsweredQuestionsQty(Trivia mTrivia) {
    int triviaIndex = -1;
    List<String> currentTriviaInfo = this.triviasLocalInfo;
    for(int i = 0; i < currentTriviaInfo.length; i++) {
      Map<String, dynamic> auxiliarMap = json.decode(currentTriviaInfo[i]);

      if (auxiliarMap["name"] == mTrivia.name) {
        triviaIndex = i;
        break;
      }
    }

    if (triviaIndex != -1) {
      int totalAnswered = 0;
      Map<String, dynamic> foundedMap = json.decode(currentTriviaInfo[triviaIndex])["responses"];
      foundedMap.forEach((key, value) {
        if (value != null && value != "") totalAnswered++;
      });      
      return totalAnswered;
    }
    return 0;
  }

  // 0 Ready
  // 1 Correct
  // 2 Wrong
  String checkQuestionAnswer(Trivia mTrivia, int mQuestionIndex, String mAnswer) {
    int triviaIndex = -1;
    List<String> currentTriviaInfo = this.triviasLocalInfo;
    for(int i = 0; i < currentTriviaInfo.length; i++) {
      Map<String, dynamic> auxiliarMap = json.decode(currentTriviaInfo[i]);

      if (auxiliarMap["name"] == mTrivia.name) {
        triviaIndex = i;
        break;
      }
    }

    if (triviaIndex != -1) {
      Map<String, dynamic> foundedMap = json.decode(currentTriviaInfo[triviaIndex])["responses"];      
      if (mTrivia.respCorrect["question$mQuestionIndex"] == foundedMap["question$mQuestionIndex"]) {
        return "Correct";
      } else if (mTrivia.respCorrect["question$mQuestionIndex"] == "") {
        return "Ready";
      } else {
        return "Wrong";
      }
    }
    return "Ready";
  }

  double checkQuestionScore(Trivia mTrivia, int mQuestionIndex, String mAnswer) {
    int triviaIndex = -1;
    List<String> currentTriviaInfo = this.triviasLocalInfo;
    for(int i = 0; i < currentTriviaInfo.length; i++) {
      Map<String, dynamic> auxiliarMap = json.decode(currentTriviaInfo[i]);

      if (auxiliarMap["name"] == mTrivia.name) {
        triviaIndex = i;
        break;
      }
    }

    if (triviaIndex != -1) {
      Map<String, dynamic> foundedMap = json.decode(currentTriviaInfo[triviaIndex])["responses"];      
      if (mTrivia.respCorrect["question$mQuestionIndex"] == foundedMap["question$mQuestionIndex"]) {
        return mTrivia.points / mTrivia.qtyPreg;
      } else {
        return 0;
      }
    }
    return 0;
  }

  void updateCompleteUser(User mUser) {
    updateId(mUser.id);
    updateName(mUser.name);
    updateLastname(mUser.lastname);
    updateUsername(mUser.username);
    updateBirthdate(mUser.birthdate);
    updatePhone(mUser.phone);
    updateGrade(mUser.grade);
    updateAvatar(mUser.avatar);
    updateCity(mUser.city);
    updateIsValidated(mUser.isValidated);
  }

  void deleteUser() {
    updateId(null);
    updateName(null);
    updateLastname(null);
    updateUsername(null);
    updateBirthdate(null);
    updatePhone(null);
    updateGrade(null);
    updateAvatar(null);
    updateCity(null);
    updateIsValidated(null);
  }
  
}