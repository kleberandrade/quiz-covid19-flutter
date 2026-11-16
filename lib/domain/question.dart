/// A reviewed, single-choice question. Lists are copied at the boundary.
class Question {
  Question({
    required this.id,
    required this.prompt,
    required List<String> options,
    required this.correctIndex,
    required this.explanation,
    required this.source,
    required this.reviewedOn,
  }) : options = List.unmodifiable(options) {
    if ([id, prompt, explanation].any((value) => value.trim().isEmpty) ||
        options.length < 2 ||
        options.any((option) => option.trim().isEmpty) ||
        options.map((option) => option.trim()).toSet().length !=
            options.length ||
        correctIndex < 0 ||
        correctIndex >= options.length ||
        source.scheme != 'https' ||
        source.host.isEmpty ||
        !RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(reviewedOn) ||
        DateTime.tryParse(reviewedOn)?.toIso8601String().substring(0, 10) !=
            reviewedOn) {
      throw ArgumentError(
        'Question must have valid content, answers, source and review date.',
      );
    }
  }

  final String id;
  final String prompt;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final Uri source;
  final String reviewedOn;

  String get correctAnswer => options[correctIndex];
}
