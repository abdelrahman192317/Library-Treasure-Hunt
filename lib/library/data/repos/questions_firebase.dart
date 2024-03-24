import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/questions_model.dart';

class QuestionsFirebaseManger {

  static Future<List<Question>> getQuestions() async {
    QuerySnapshot levels;
    try {
      levels =
          await FirebaseFirestore.instance.collection('Questions').get();

      List<Question> questionsList = [];
      Map<String, dynamic> map;

      for (var level in levels.docs) {
        map = level.data() as Map<String, dynamic>;
        questionsList.add(Question.fromMap(map, level.id));
      }

      return questionsList;
    } on FirebaseException {
      throw Exception();
    }
  }
}