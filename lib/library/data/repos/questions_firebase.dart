import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/global/global.dart';
import '../models/questions_model.dart';

class QuestionsFirebaseManger {

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
          questionsMatrix[j].sort((a, b) => int.parse(a.questionId).compareTo(int.parse(b.questionId)));
        }
        questions3Matrix.add(questionsMatrix);
      }
      return questions3Matrix;
    } on FirebaseException {
      throw Exception();
    }
  }

}