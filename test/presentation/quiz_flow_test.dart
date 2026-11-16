import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_covid19/app.dart';
import 'package:quiz_covid19/data/question_bank.dart';
import 'package:quiz_covid19/domain/question.dart';

final question = Question(
  id: 'one',
  prompt: 'Uma pergunta?',
  options: ['Certa', 'Errada'],
  correctIndex: 0,
  explanation: 'Explicação educativa.',
  source: Uri.parse('https://www.who.int/'),
  reviewedOn: '2026-11-16',
);

void main() {
  testWidgets('answer, feedback, sources, results and restart', (tester) async {
    await tester.pumpWidget(QuizApp(questions: [question]));
    expect(find.text('Pergunta 1 de 1'), findsOneWidget);
    await tester.tap(find.text('Errada'));
    await tester.tap(
      find.text('Certa'),
    ); // Stale second tap cannot change the first answer.
    await tester.pump();
    expect(find.text('Vamos aprender!'), findsOneWidget);
    expect(find.text('Resposta correta: Certa'), findsOneWidget);
    expect(find.text('Explicação educativa.'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Certa'))
          .onPressed,
      isNull,
    );
    await tester.ensureVisible(find.text('Ver resultado'));
    await tester.tap(find.text('Ver resultado'));
    await tester.pump();
    expect(find.text('0 de 1 acertos'), findsOneWidget);
    await tester.tap(find.text('Jogar novamente'));
    await tester.pump();
    expect(find.text('Pergunta 1 de 1'), findsOneWidget);
    await tester.tap(find.byTooltip('Fontes e informações'));
    await tester.pumpAndSettle();
    expect(find.text('Fontes e informações'), findsWidgets);
    expect(find.textContaining('2026-11-16'), findsWidgets);
    expect(find.bySemanticsLabel('Fonte: ${question.source}'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Certa'));
    await tester.pump();
    expect(find.text('Resposta correta!'), findsOneWidget);
    await tester.ensureVisible(find.text('Ver resultado'));
    await tester.tap(find.text('Ver resultado'));
    await tester.pump();
    expect(find.text('1 de 1 acertos'), findsOneWidget);
  });

  testWidgets('small screen and large text remain scrollable and accessible', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      QuizApp(questions: [question], textScaler: TextScaler.linear(2)),
    );
    await tester.ensureVisible(find.text('Certa'));
    await tester.tap(find.text('Certa'));
    await tester.pump();
    await tester.ensureVisible(find.text('Ver resultado'));
    expect(tester.takeException(), isNull);
    final handle = tester.ensureSemantics();
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    handle.dispose();
  });
  testWidgets('the bundled bank can be completed without a server', (
    tester,
  ) async {
    await tester.pumpWidget(const QuizApp());
    for (var index = 0; index < questionBank.length; index++) {
      final question = questionBank[index];
      expect(
        find.text('Pergunta ${index + 1} de ${questionBank.length}'),
        findsOneWidget,
      );
      await tester.ensureVisible(find.text(question.correctAnswer));
      await tester.tap(find.text(question.correctAnswer));
      await tester.pump();
      final next = find.text(
        index == questionBank.length - 1 ? 'Ver resultado' : 'Próxima pergunta',
      );
      await tester.ensureVisible(next);
      await tester.tap(next);
      await tester.pump();
    }
    expect(
      find.text('${questionBank.length} de ${questionBank.length} acertos'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
