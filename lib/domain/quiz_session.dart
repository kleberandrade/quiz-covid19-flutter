import 'question.dart';

/// One local attempt. Answer once, review feedback, then advance explicitly.
class QuizSession {
  QuizSession(List<Question> questions)
    : _questions = List.unmodifiable(questions) {
    if (_questions.isEmpty) {
      throw ArgumentError('At least one question is required.');
    }
  }

  final List<Question> _questions;
  int _questionIndex = 0;
  int _score = 0;
  int? _selectedIndex;
  bool _isComplete = false;

  int get total => _questions.length;
  int get questionIndex => _questionIndex;
  Question get question => _questions[_questionIndex];
  int get score => _score;
  int? get selectedIndex => _selectedIndex;
  bool get isComplete => _isComplete;
  bool get isCorrect => _selectedIndex == question.correctIndex;
  int get answered =>
      isComplete ? total : _questionIndex + (_selectedIndex == null ? 0 : 1);
  double get progress => answered / total;

  /// Returns whether an answer was accepted (not whether it was correct).
  bool answer(int index) {
    if (isComplete || _selectedIndex != null) return false;
    RangeError.checkValidIndex(index, question.options);
    _selectedIndex = index;
    if (isCorrect) _score++;
    return true;
  }

  void advance() {
    if (_selectedIndex == null || isComplete) {
      throw StateError('Answer the current question before advancing.');
    }
    if (_questionIndex == total - 1) {
      _isComplete = true;
    } else {
      _questionIndex++;
      _selectedIndex = null;
    }
  }

  void restart() {
    _questionIndex = 0;
    _score = 0;
    _selectedIndex = null;
    _isComplete = false;
  }
}
