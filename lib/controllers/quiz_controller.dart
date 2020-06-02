import 'dart:math';

import 'package:quiz_covid19/models/question.dart';
import 'package:quiz_covid19/services/quiz_api.dart';

class QuizController {
  List<Question> _questionBank;

  Random _random = new Random();
  int questionIndex = 0;
  bool _shiftAnswer;
  int hitNumber = 0;

  int get questionsNumber => _questionBank?.length ?? 0;
  Question get question => _questionBank[questionIndex];

  Future<void> initialize() async {
    questionIndex = 0;
    hitNumber = 0;
    _questionBank = await QuizApi.fetch();
    print('Number of questions: ${_questionBank.length}');
    _questionBank.shuffle();
    _shiftAnswer = _random.nextBool();
  }

  void nextQuestion() {
    questionIndex = ++questionIndex % _questionBank.length;
    _shiftAnswer = _random.nextBool();
  }

  String getQuestion() {
    return _questionBank[questionIndex].question;
  }

  String getAnswer1() {
    return _shiftAnswer
        ? _questionBank[questionIndex].answer1
        : _questionBank[questionIndex].answer2;
  }

  String getAnswer2() {
    return _shiftAnswer
        ? _questionBank[questionIndex].answer2
        : _questionBank[questionIndex].answer1;
  }

  bool correctAnswer(String answer) {
    var correct = _questionBank[questionIndex].answer1 == answer;
    hitNumber = hitNumber + (correct ? 1 : 0);
    return correct;
  }
}
