import 'package:questions/datasource/data_source.dart';
import 'package:questions/question.dart';
import 'package:yaml/yaml.dart';

const String _keyQuestions = "questions";
const String _keySection = "section";
const String _keyQuestion = "question";
const String _keyText = "text";
const String _keyId = "id";
const String _keyAnswers = "answers";

/// A datasource for YAML defined question sets.
/// See: assets/sample.yaml
class YamlDataSource extends DataSource {
  @override
  Future<List<Question>> loadQuestions(String source) async {
    final YamlList entries = loadYaml(source);
    final result = <Question>[];

    // Process each section.
    for (YamlMap entry in entries) {
      // Extract the questions.
      final YamlMap? section = entry[_keySection];
      if (section != null) {
        var questions = section[_keyQuestions];
        if (questions != null) {
          for (YamlMap questionMap in questions) {
            var map = questionMap[_keyQuestion];
            if (map != null) {
              result.add(_asQuestion(map));
            }
          }
        }
      }
    }

    return result;
  }

  Question _asQuestion(YamlMap questionMap) {
    var autoId = 1;

    final builder = QuestionBuilder()
      ..withText(questionMap[_keyText])
      ..withId(questionMap[_keyId] ?? autoId++);

    final answers = questionMap[_keyAnswers];
    for (var ans in answers) {
      builder.addAnswer(Answer(ans, builder.id!));
    }

    return builder.build();
  }
}
