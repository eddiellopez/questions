import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:questions/datasource/yaml_data_source.dart';
import 'package:questions/question.dart';
import 'package:questions/view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Questions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Questions'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final _questionViewModel = QuestionViewModel(YamlDataSource());
  Question? _question;
  List<Answer>? _answers;
  String? _error;

  @override
  void initState() {
    super.initState();
    const sampleAsset = kIsWeb ? 'sample.yaml' : 'assets/sample.yaml';
    rootBundle.loadString(sampleAsset).then((value) {
      _questionViewModel
          .loadAsset(value)
          .then((value) => _question = _questionViewModel.getNextQuestion());
    }).catchError((error, stackTrace) {
      _error = error.toString();
    });
  }

  void _getRandomQuestion() {
    setState(() {
      _error = null;
      _answers = null;
      _question = _questionViewModel.getNextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: IntrinsicHeight(
                child: _buildContent(context),
              ),
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _getRandomQuestion,
        tooltip: 'Next question',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (_error != null) {
      return Text("Error: $_error");
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Question ${_question?.id ?? 0}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: Text(
              _question?.text ?? '?',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          _question != null ? _buildAnswer(context) : const Text(""),
        ],
      );
    }
  }

  Widget _buildAnswer(BuildContext context) {
    if (_answers != null) {
      return Expanded(child: Column(children: _buildAnswers()));
    } else {
      return TextButton(
        child: const Text("Show answers"),
        onPressed: _showAnswers,
      );
    }
  }

  List<Widget> _buildAnswers() {
    final ans = <Widget>[];
    for (var answer in _answers!) {
      ans.add(Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        alignment: Alignment.centerLeft,
        child: Text(
          "- ${answer.text}",
          style: Theme.of(context).textTheme.headline6,
        ),
      ));
    }
    return ans;
  }

  void _showAnswers() {
    setState(() {
      _answers = _questionViewModel.getAnswers(_question!);
    });
  }
}
