class Question {
  String questionId;
  String question;
  String answer_1;
  String answer_2;
  String answer_3;
  String rightAnswer;


  Question({
    this.questionId = '',
    this.question = '',
    this.answer_1 = '',
    this.answer_2 = '',
    this.answer_3 = '',
    this.rightAnswer = '',
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionId: map['questionId'] ?? '',
      question: map['question'] ?? '',
      answer_1: map['answer_1'] ?? '',
      answer_2: map['answer_2'] ?? '',
      answer_3: map['answer_3'] ?? '',
      rightAnswer: map['rightAnswer'] ?? '',
    );
  }

  static Map<String, dynamic> toMap(Question question) => {

    "questionId": question.questionId,
    "question": question.question,
    "answer_1": question.answer_1,
    "answer_2": question.answer_2,
    "answer_3": question.answer_3,
    "rightAnswer": question.rightAnswer,
  };
}
