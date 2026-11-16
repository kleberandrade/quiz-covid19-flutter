import 'package:material_ui/material_ui.dart';

import 'data/question_bank.dart';
import 'domain/question.dart';
import 'presentation/quiz_page.dart';

class QuizApp extends StatelessWidget {
  const QuizApp({super.key, this.questions, this.textScaler});

  final List<Question>? questions;
  final TextScaler? textScaler;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Quiz COVID-19',
    debugShowCheckedModeBanner: false,
    locale: const Locale('pt', 'BR'),
    supportedLocales: const [Locale('pt', 'BR')],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF006B60)),
      useMaterial3: true,
      fontFamily: 'QuizRoboto',
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 56),
          padding: const EdgeInsets.all(16),
        ),
      ),
    ),
    builder: textScaler == null
        ? null
        : (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: textScaler),
            child: child!,
          ),
    home: QuizPage(questions: questions ?? questionBank),
  );
}
