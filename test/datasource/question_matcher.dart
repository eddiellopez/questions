import 'package:flutter_test/flutter_test.dart';
import 'package:questions/question.dart';

isSameQuestionAs(String text, Set<String> answers) {
  return QuestionMatcher(text, answers);
}

/// A matcher for questions.
class QuestionMatcher extends Matcher {
  String expectedText;
  Set<String> expectedAnswers;

  QuestionMatcher(this.expectedText, this.expectedAnswers);

  @override
  Description describe(Description description) {
    return description.add(expectedText);
  }

  @override
  bool matches(item, Map<dynamic, dynamic> matchState) {
    Question actual = item as Question;
    return actual.text == expectedText &&
        actual.answers
            .map((e) => e.text)
            .toSet()
            .difference(expectedAnswers)
            .isEmpty;
  }
}
