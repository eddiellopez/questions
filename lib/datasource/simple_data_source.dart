import 'package:questions/datasource/data_source.dart';
import 'package:questions/extensions.dart';
import 'package:questions/question.dart';

// Matches a question start.
// For example, for the input "23. Quo vadis?", will match: "23. "
final RegExp exp = RegExp(r"(\d+)\.\s");

/// A data source for simple text format.
/// See assets/sample.txt
class SimpleDataSource extends DataSource {
  @override
  Future<List<Question>> loadQuestions(String source) async {
    final data = <Question>[];

    final allMatches = exp.allMatches(source);
    // Zip to process content between matches
    if (allMatches.length > 1) {
      allMatches.zipWithNext((prev, curr) {
        return source.substring(prev.start, curr.start);
      }).forEach((element) {
        data.add(_asQuestion(element));
      });
    }

    // Process the content after the last match.
    data.add(_asQuestion(source.substring(allMatches.last.start)));

    return data;
  }

  Question _asQuestion(String str) {
    QuestionBuilder? builder;
    final lines = str
        .split("\n")
        .map((e) => e.trim())
        .filter((value) => value.isNotEmpty);

    for (var line in lines) {
      if (builder == null) {
        // The question text
        final firstMatch = exp.firstMatch(line);
        builder = QuestionBuilder()
          ..withId(int.parse(firstMatch!.group(1)!))
          ..withText(line.substring(firstMatch.end));
      } else {
        // The responses
        builder.addAnswer(_asAnswer(line, builder.id!));
      }
    }

    return builder!.build();
  }

  Answer _asAnswer(String line, int questionId) {
    return Answer(line.substring(2), questionId);
  }
}
