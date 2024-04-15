import 'dart:convert';

import 'package:flutter/material.dart';

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
  static List<List<Map<int, String>>> getAllSolvedQuestions(){
    List<List<Map<int, String>>> allSolvedQuestions = [];
    List<Map<int, String>> solvedQuestions = [];

    for(var dif in difficulty){
      solvedQuestions = List.generate(10, (index) => {});

      List<String>? reListOfString = sharedPreferences!.getStringList('${dif}SolvedQuestions');
      debugPrint('solvedQuestions $dif: $reListOfString');

      if(reListOfString != null){
        for(var (index, string) in reListOfString.indexed){
          solvedQuestions[index] = json.decode(string) as Map<int, String>;
        }
      }
      debugPrint('solvedQuestions $dif: $solvedQuestions');
      allSolvedQuestions.add(solvedQuestions);
    }

    debugPrint('allSolvedQuestions: $allSolvedQuestions');
    return allSolvedQuestions;
  }

  static updateSolvedQuestions(int dif){
    sharedPreferences!.setStringList('${difficulty[dif]}SolvedQuestions',
        myAllSolvedQuestions[dif].map((questionsIdsMap) => json.encode(questionsIdsMap)).toList());
  }
}