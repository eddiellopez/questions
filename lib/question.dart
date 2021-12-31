/// A question.
class Question {
  final String text;
  final int id;
  final List<Answer> answers;

  Question(this.text, this.id, this.answers);

  @override
  String toString() {
    return 'Question{text: $text, id: $id}';
  }
}

/// An answer.
class Answer {
  final String text;
  final int questionId;

  Answer(this.text, this.questionId);

  @override
  String toString() {
    return 'Answer{text: $text, questionId: $questionId}';
  }
}

/// A question builder.
class QuestionBuilder {
  String? text;
  int? id;
  List<Answer> answers = [];

  void withText(String text) {
    this.text = text;
  }

  void withId(int id) {
    this.id = id;
  }

  void addAnswer(Answer answer) {
    answers.add(answer);
  }

  Question build() {
    return Question(text!, id!, answers);
  }
}
