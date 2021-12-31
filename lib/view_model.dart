import 'package:questions/question.dart';

import 'datasource/data_source.dart';

class QuestionViewModel {
  // The questionnaire.
  List<Question>? _data;

  // Random indexes to return without repeating.
  List<int> _randomIndexes = [];
  var _currentIndex = 0;

  final DataSource dataSource;

  QuestionViewModel(this.dataSource);

  /// Loads the data. Must be called before [getNxtQuestion].
  Future<String> loadAsset(String source) async {
    _data = await dataSource.loadQuestions(source);
    _randomIndexes = List.generate(_data!.length, (int index) => index + 1);
    _randomIndexes.shuffle();
    return "Ready!";
  }

  /// Returns the next question, in a random order.
  /// If no questions are available, throws [StateError].
  Question getNextQuestion() {
    if (_data == null || _data!.isEmpty) {
      throw StateError("No questions available!");
    }
    final r = _randomIndexes[_currentIndex++ % _randomIndexes.length];
    return _data!.firstWhere((key) => key.id == r);
  }

  /// Returns the answers for a question. Returns null if no answer.
  List<Answer>? getAnswers(Question question) {
    return question.answers;
  }
}
