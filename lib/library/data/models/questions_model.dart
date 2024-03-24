//enum Difficulty {easy, middle, difficult}

class Question {
  int level;
  String questionId;
  String question;
  String answer_1;
  String answer_2;
  String answer_3;
  int difficulty;

  Question({
    this.level = 0,
    this.questionId = '',
    this.question = '',
    this.answer_1 = '',
    this.answer_2 = '',
    this.answer_3 = '',
    this.difficulty = 0,
  });

  factory Question.fromMap(Map<String, dynamic> map, String id) {
    return Question(
      level: map['level'] ?? 0,
      questionId: id,
      question: map['question'] ?? '',
      answer_1: map['answer_1'] ?? '',
      answer_2: map['answer_2'] ?? '',
      answer_3: map['answer_3'] ?? '',
      difficulty: map['difficulty'] ?? 0,
    );
  }

  static Map<String, dynamic> toMap(Question question) => {
    "level": question.level,
    "questionId": question.questionId,
    "question": question.question,
    "answer_1": question.answer_1,
    "answer_2": question.answer_2,
    "answer_3": question.answer_3,
    "difficulty": question.difficulty,
  };
}
