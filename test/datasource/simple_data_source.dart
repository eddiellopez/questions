import 'package:flutter_test/flutter_test.dart';
import 'package:questions/datasource/simple_data_source.dart';
import 'package:questions/question.dart';

import 'question_matcher.dart';

void main() {
  test("loadQuestions", () async {
    const source = """
This is a sample text file with questions to use with SimpleDataSource.


A: The Solar System


1. What is the mass of the Earth?

. 5.9722×10^24 kg


2. Name two space telescopes.

. Hubble
. James Webb


3. Name the planets of the Solar System.

 . Mercury
 . Venus
 . Earth
 . Mars
 . Jupiter
 . Saturn
 . Uranus
 . Neptune

""";

    // Considering the data source:
    final dataSource = SimpleDataSource();
    // Given the above questionnaire, when loaded...
    final List<Question> questions = await dataSource.loadQuestions(source);

    // We expect three questions.
    expect(questions.length, 3);

    expect(
        questions[0],
        isSameQuestionAs(
            "What is the mass of the Earth?", {"5.9722×10^24 kg"}));

    expect(
        questions[1],
        isSameQuestionAs(
            "Name two space telescopes.", {"Hubble", "James Webb"}));

    expect(
        questions[2],
        isSameQuestionAs("Name the planets of the Solar System.", {
          "Mercury",
          "Venus",
          "Earth",
          "Mars",
          "Jupiter",
          "Saturn",
          "Uranus",
          "Neptune"
        }));
  });
}
