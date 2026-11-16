import 'package:material_ui/material_ui.dart';
import 'package:quiz_covid19/app.dart';
import 'package:quiz_covid19/domain/question.dart';

// Run with: flutter run -t example/main.dart -d chrome
void main() => runApp(
  QuizApp(
    questions: [
      Question(
        id: 'flutter-language',
        prompt: 'Qual linguagem é usada pelo Flutter?',
        options: ['Dart', 'Java'],
        correctIndex: 0,
        explanation: 'Este projeto Flutter usa Dart com null safety.',
        source: Uri.parse('https://docs.flutter.dev/resources/faq'),
        reviewedOn: '2026-11-16',
      ),
    ],
  ),
);
