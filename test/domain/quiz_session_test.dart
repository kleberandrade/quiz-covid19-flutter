import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_covid19/domain/question.dart';
import 'package:quiz_covid19/domain/quiz_session.dart';

Question sample({int correctIndex = 1}) => Question(
  id: 'sample',
  prompt: 'Choose',
  options: ['A', 'B'],
  correctIndex: correctIndex,
  explanation: 'Because',
  source: Uri.parse('https://www.who.int/'),
  reviewedOn: '2026-11-16',
);

void main() {
  test(
    'one answer per question; progress and score finish at the boundary',
    () {
      final quiz = QuizSession([sample(), sample(correctIndex: 0)]);
      expect(quiz.progress, 0);
      expect(quiz.score, 0);
      expect(quiz.advance, throwsStateError);
      expect(quiz.answer(1), isTrue);
      expect(quiz.answer(1), isFalse);
      expect(quiz.score, 1);
      expect(quiz.progress, 0.5);
      quiz.advance();
      expect(quiz.questionIndex, 1);
      expect(quiz.selectedIndex, isNull);
      expect(quiz.answer(1), isTrue);
      expect(quiz.score, 1);
      expect(quiz.progress, 1);
      quiz.advance();
      expect(quiz.isComplete, isTrue);
      expect(quiz.answer(0), isFalse);
      expect(quiz.advance, throwsStateError);
      quiz.restart();
      expect(quiz.isComplete, isFalse);
      expect(quiz.progress, 0);
      expect(quiz.score, 0);
      expect(quiz.questionIndex, 0);
      expect(quiz.selectedIndex, isNull);
    },
  );

  test('invalid input cannot change a session', () {
    expect(() => QuizSession([]), throwsArgumentError);
    final quiz = QuizSession([sample()]);
    expect(() => quiz.answer(-1), throwsRangeError);
    expect(() => quiz.answer(2), throwsRangeError);
    expect(quiz.progress, 0);
    expect(quiz.selectedIndex, isNull);
  });

  test('correct scores include zero and perfect results', () {
    for (final correct in [false, true]) {
      final quiz = QuizSession([sample()]);
      quiz.answer(correct ? 1 : 0);
      expect(quiz.isCorrect, correct);
      quiz.advance();
      expect(quiz.score, correct ? 1 : 0);
      expect(quiz.isComplete, isTrue);
    }
  });

  test('input lists cannot mutate questions or sessions', () {
    final options = ['A', 'B'];
    final question = Question(
      id: 'q',
      prompt: 'Q',
      options: options,
      correctIndex: 0,
      explanation: 'E',
      source: Uri.parse('https://who.int'),
      reviewedOn: '2026-11-16',
    );
    options.clear();
    expect(question.options, ['A', 'B']);
    expect(() => question.options.clear(), throwsUnsupportedError);
    final questions = [question];
    final quiz = QuizSession(questions);
    questions.clear();
    expect(quiz.total, 1);
  });

  test('question validates content and answer index at construction', () {
    expect(() => sample(correctIndex: 2), throwsArgumentError);
    for (final options in <List<String>>[
      [],
      ['A'],
      ['A', 'A'],
      ['A', ' '],
    ]) {
      expect(
        () => Question(
          id: 'q',
          prompt: 'Q',
          options: options,
          correctIndex: 0,
          explanation: 'E',
          source: Uri.parse('https://who.int'),
          reviewedOn: '2026-11-16',
        ),
        throwsArgumentError,
      );
    }
    expect(
      () => Question(
        id: '',
        prompt: 'Q',
        options: ['A', 'B'],
        correctIndex: 0,
        explanation: 'E',
        source: Uri.parse('https://who.int'),
        reviewedOn: '2026-11-16',
      ),
      throwsArgumentError,
    );
  });
  test('invalid question metadata is rejected at the content boundary', () {
    Question make({
      String prompt = 'Q',
      String explanation = 'E',
      String source = 'https://who.int',
      String date = '2026-11-16',
    }) => Question(
      id: 'q',
      prompt: prompt,
      options: ['A', 'B'],
      correctIndex: 0,
      explanation: explanation,
      source: Uri.parse(source),
      reviewedOn: date,
    );
    expect(() => make(prompt: ' '), throwsArgumentError);
    expect(() => make(explanation: ' '), throwsArgumentError);
    for (final source in ['http://who.int', 'https:', 'relative']) {
      expect(() => make(source: source), throwsArgumentError);
    }
    for (final date in ['unknown', '2026-02-30', '2026-13-01', '2026-01-00']) {
      expect(() => make(date: date), throwsArgumentError);
    }
    expect(() => sample(correctIndex: -1), throwsArgumentError);
  });
}
