import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/global/global.dart';
import '../models/questions_model.dart';

class QuestionsFirebaseManger {

  static Future<List<Question>> getQuestionsForLevel(String difficulty, String level) async {
    QuerySnapshot questions;
    try {
      questions =
          await FirebaseFirestore.instance
              .collection(difficulty)
              .doc(level)
              .collection('Questions').get();

      List<Question> questionsList = [];

      for (var question in questions.docs) {
        questionsList.add(Question.fromMap(question.data() as Map<String, dynamic>, question.id, false));
      }

     return questionsList;
    } on FirebaseException {
      throw Exception();
    }
  }

  static Future<List<List<Question>>> getQuestionsForDifficulty(String difficulty) async {
    QuerySnapshot questions;
    try {

      List<List<Question>> questionsMatrix = [];

      for(var i = 1; i < 11; i++) {
        questions =
        await FirebaseFirestore.instance
            .collection(difficulty)
            .doc('level $i')
            .collection('Questions').get();

        for (var question in questions.docs) {

          questionsMatrix[i - 1].add(Question.fromMap(question.data() as Map<String, dynamic>, question.id, false));
        }
      }
     return questionsMatrix;
    } on FirebaseException {
      throw Exception();
    }
  }

  static Future<List<List<List<Question>>>> getAllQuestions() async {
    QuerySnapshot questions;
    try {

      List<List<List<Question>>> questions3Matrix = [];
      List<List<Question>> questionsMatrix;

      for(var (i, dif) in difficulty.indexed){
        questionsMatrix = List.generate(10, (index) => []);
        for(var j = 0; j < 10; j++) {
          questions = await FirebaseFirestore.instance
              .collection(dif).doc('level $j').collection('Questions').get();

          for (var question in questions.docs) {
            questionsMatrix[j].add(
                Question.fromMap(
                  question.data() as Map<String, dynamic>,
                  question.id,
                  !(myAllSolvedQuestions[i][j][question.id] == question.id)
                )
            );
          }
        }
        questions3Matrix.add(questionsMatrix);
      }
      debugPrint('questions3Matrix: $questions3Matrix');
      return questions3Matrix;
    } on FirebaseException {
      throw Exception();
    }
  }

}