import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PsychTest(),
    );
  }
}

class PsychTest extends StatefulWidget {
  @override
  _PsychTestState createState() => _PsychTestState();
}

class _PsychTestState extends State<PsychTest> {
  int currentQuestionIndex = 0;
  List<Map<String, dynamic>> questions = [
    {
      'question': 'Чи часто ви відчуваєте стрес?',
      'options': ['Так', 'Ні']
    },
    {
      'question': 'Чи відчуваєте ви тривогу в соціальних ситуаціях?',
      'options': ['Так', 'Ні']
    },
    {
      'question': 'Чи відчуваєте ви депресію?',
      'options': ['Так', 'Ні']
    },
    {
      'question': 'Чи відчуваєте ви страхи або фобії?',
      'options': ['Так', 'Ні']
    },
    {
      'question': 'Чи відчуваєте ви нездужання?',
      'options': ['Так', 'Ні']
    },
  ];

  List<String> userAnswers = [];

  void answerQuestion(String answer) {
    userAnswers.add(answer);

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      int stressScore = 0;
      int anxietyScore = 0;
      int depressionScore = 0;

      for (String answer in userAnswers) {
        if (answer == 'Так') {
          stressScore++;
        }
        if (answer == 'Так') {
          anxietyScore++;
        }
        if (answer == 'Так') {
          depressionScore++;
        }
      }

      String result = 'Результати:\n';
      result += 'Рівень стресу: $stressScore\n';
      result += 'Рівень тривоги: $anxietyScore\n';
      result += 'Рівень депресії: $depressionScore';

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Результати тесту'),
            content: Text(result),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Скинути тест
                  setState(() {
                    currentQuestionIndex = 0;
                    userAnswers.clear();
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Закрити'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Психологічний тест'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                questions[currentQuestionIndex]['question'],
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
            Column(
              children:
                  (questions[currentQuestionIndex]['options'] as List<String>)
                      .map((option) {
                return ElevatedButton(
                  onPressed: () {
                    answerQuestion(option);
                  },
                  child: Text(option),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
