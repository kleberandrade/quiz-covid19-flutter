import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_covid19/data/question_bank.dart';

void main() {
  test(
    'the offline bank is nonempty, uniquely identified, reviewed and sourced',
    () {
      expect(questionBank, isNotEmpty);
      expect(questionBank.map((q) => q.id).toSet().length, questionBank.length);
      for (final question in questionBank) {
        expect(question.reviewedOn, contentReviewedOn);
        expect(question.source.host, 'www.who.int');
        expect(question.source.scheme, 'https');
        expect(question.options[question.correctIndex], isNotEmpty);
        expect(question.explanation, isNotEmpty);
      }
      expect(questionBank.map((q) => q.correctIndex).toSet(), {0, 1});
    },
  );
}
