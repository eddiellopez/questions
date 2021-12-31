import 'package:questions/question.dart';

/// Defines a Data Source for questions.
abstract class DataSource {
  /// Loads a list of questions from the supplied source.
  Future<List<Question>> loadQuestions(String source);
}
