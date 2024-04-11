import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/questions_model.dart';

class QuestionsFirebaseManger {

  static Future<List<String>> getLevels(difficulty) async {
    QuerySnapshot levels;
    try {
      levels =
          await FirebaseFirestore.instance.collection('middle').get();

      List<String> levelsList = [];


      for (var level in levels.docs) {
        levelsList.add(level.id);
      }
      print(levels.docs.length);
      print(levelsList);
      return levelsList;
    } on FirebaseException {
      throw Exception();
    }
  }

  static Future<List<Question>> getQuestionsForLevel(level) async {
    QuerySnapshot questions;
    try {
      questions =
          await FirebaseFirestore.instance.collection('middle').doc('level 0').collection('Questions').get();

      List<Question> questionsList = [];


      for (var question in questions.docs) {
        questionsList.add(Question.fromMap(question.data() as Map<String, dynamic>));
      }
      print(questionsList.length);
      print(questionsList[0].question);
      print(questionsList[0].answer_1);
      print(questionsList[0].answer_2);
      print(questionsList[0].answer_3);

     return questionsList;
    } on FirebaseException {
      throw Exception();
    }
  }


}