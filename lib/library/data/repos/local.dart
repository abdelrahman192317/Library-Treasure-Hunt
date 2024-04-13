
import 'dart:convert';

import '../../core/global/global.dart';

class LocalManager{

  //name
  static String? getName(){
    return sharedPreferences!.getString('name');
  }
  static editName(String newName){
     sharedPreferences!.setString('name', newName);
  }

  //heartCount
  static int? getHeartCount(){
    return sharedPreferences!.getInt('heartCount');
  }
  static minusHeartCount(){
    if(heartCount! > 0){
      heartCount = heartCount! - 1;
      sharedPreferences!.setInt('heartCount', heartCount!);
    }
  }
  static addHeartCount(){
    if(heartCount! < 3){
      heartCount = heartCount! + 1;
      sharedPreferences!.setInt('heartCount', heartCount!);
    }
  }

  //questions
  static List<Map<String, String>> getSolvedQuestions(String difficulty){
    List<String>? solvedQuestions =
      sharedPreferences!.getStringList('${difficulty}SolvedQuestions');
    return solvedQuestions!.map((questionsIdsMap) =>
    json.decode(questionsIdsMap) as Map<String, String>).toList();
  }

  static List<List<Map<int, String>>> getAllSolvedQuestions(){
    List<List<Map<int, String>>> allSolvedQuestions = [];
    for( var dif in difficulty){
      List<String>? solvedQuestions =
      sharedPreferences!.getStringList('${dif}SolvedQuestions');
      allSolvedQuestions
        .add(
        solvedQuestions!
            .map((questionsIdsMap) =>
              json.decode(questionsIdsMap) as Map<int, String>
            ).toList()
        );
    }
    return allSolvedQuestions;
  }

  static updateSolvedQuestions(int difficulty){
    sharedPreferences!.setStringList('${difficulty}SolvedQuestions',
        myAllSolvedQuestions[difficulty].map((questionsIds) => json.encode(questionsIds)).toList());
  }
}