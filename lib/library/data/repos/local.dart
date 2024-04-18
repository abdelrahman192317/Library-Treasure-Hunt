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
    return sharedPreferences!.getInt('heartCount') ?? 3;
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
  static List<List<Map<String, String>>> getAllSolvedQuestions(){
    List<List<Map<String, String>>> allSolvedQuestions = [];
    List<Map<String, String>> solvedQuestions = [];

    for(var dif in difficulty){
      solvedQuestions = List.generate(10, (index) => <String, String>{});

      List<String>? reListOfString = sharedPreferences!.getStringList('${dif}SolvedQuestions');

      if(reListOfString != null){
        for(var (index, string) in reListOfString.indexed){
          solvedQuestions[index] = fromDynamic(json.decode(string));
        }
      }
      allSolvedQuestions.add(solvedQuestions);
    }
    return allSolvedQuestions;
  }

  static updateSolvedQuestions(int dif){
    List<String> listOfMap = [];
    for(var map in myAllSolvedQuestions[dif]) {
      if(map.isNotEmpty)listOfMap.add(json.encode(map));
    }
    sharedPreferences!.setStringList('${difficulty[dif]}SolvedQuestions', listOfMap);
  }

  static Map<String,String> fromDynamic(Map<String, dynamic> map) {
    Map<String,String> remap = {};
    map.forEach((key, value) => remap[key] = value as String);
    return remap;
  }
}