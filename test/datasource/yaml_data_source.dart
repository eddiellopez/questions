import 'package:flutter_test/flutter_test.dart';
import 'package:questions/datasource/yaml_data_source.dart';
import 'package:questions/question.dart';

import 'question_matcher.dart';

void main() {
  test("loadQuestions", () async {
    const source = """
- section:
    name: The Solar System
    id: A
    questions:
      - question:
          text: What is the mass of the Earth?
          id: 1
          answers:
            - 5.9722×10^24 kg

      - question:
          text: Name two space telescopes.
          id: 2
          answers:
            - Hubble
            - James Webb

      - question:
          text: Name the planets of the Solar System.
          id: 3
          answers:
            - Mercury
            - Venus
            - Earth
            - Mars
            - Jupiter
            - Saturn
            - Uranus
            - Neptune

- section:
    name: Another System
""";

    // Considering the data source:
    final dataSource = YamlDataSource();
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
