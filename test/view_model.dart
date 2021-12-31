import 'package:flutter_test/flutter_test.dart';
import 'package:questions/datasource/data_source.dart';
import 'package:questions/question.dart';
import 'package:questions/view_model.dart';

import 'datasource/question_matcher.dart';

void main() {
  test("zipWithNext illegal", () async {
    // Considering the following ViewModel:
    var testDataSource = TestDataSource();
    final viewModel = QuestionViewModel(testDataSource);

    // If the data is not loaded by calling loadAsset...
    // We expect an error.
    expect(() => viewModel.getNextQuestion(), throwsStateError);
  });

  test("zipWithNext empty", () async {
    // Considering the following ViewModel:
    var testDataSource = TestDataSource();
    final viewModel = QuestionViewModel(testDataSource);

    // If the questions are empty...
    testDataSource.setQuestions([]);
    await viewModel.loadAsset("test");

    // We expect an error.
    expect(() => viewModel.getNextQuestion(), throwsStateError);
  });

  test("zipWithNext one", () async {
    // Considering the following ViewModel:
    var testDataSource = TestDataSource();
    final viewModel = QuestionViewModel(testDataSource);

    // Given the questions are available...
    testDataSource.setQuestions([Question("Test", 1, [])]);
    await viewModel.loadAsset("test");

    // We expect the question.
    expect(viewModel.getNextQuestion(), isSameQuestionAs("Test", {}));
  });
}

class TestDataSource extends DataSource {
  List<Question>? _questions;

  @override
  Future<List<Question>> loadQuestions(String source) {
    return Future.value(_questions);
  }

  setQuestions(List<Question> questions) {
    _questions = questions;
  }
}
