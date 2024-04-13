class Question {
  String questionId;
  String question;
  String answer_1;
  String answer_2;
  String answer_3;
  String answer_4;
  String rightAnswer;
  bool locked;


  Question({
    this.questionId = '',
    this.question = '',
    this.answer_1 = '',
    this.answer_2 = '',
    this.answer_3 = '',
    this.answer_4 = '',
    this.rightAnswer = '',
    this.locked = true,
  });

  factory Question.fromMap(Map<String, dynamic> map, String id, bool locked) {
    return Question(
      questionId: id,
      question: map['question'] ?? '',
      answer_1: map['answer_1'] ?? '',
      answer_2: map['answer_2'] ?? '',
      answer_3: map['answer_3'] ?? '',
      answer_4: map['answer_4'] ?? '',
      rightAnswer: map['rightAnswer'] ?? '',
      locked: locked,
    );
  }

  static Map<String, dynamic> toMap(Question question) => {
    "question": question.question,
    "answer_1": question.answer_1,
    "answer_2": question.answer_2,
    "answer_3": question.answer_3,
    "answer_4": question.answer_4,
    "rightAnswer": question.rightAnswer,
  };
}
