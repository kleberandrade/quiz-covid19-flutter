import 'package:material_ui/material_ui.dart';

import '../domain/question.dart';
import '../domain/quiz_session.dart';
import 'sources_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.questions});
  final List<Question> questions;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late QuizSession _session;
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _advance() {
    setState(_session.advance);
    _scrollController.jumpTo(0);
  }

  void _restart() {
    setState(_session.restart);
    _scrollController.jumpTo(0);
  }

  @override
  void initState() {
    super.initState();
    _session = QuizSession(widget.questions);
  }

  @override
  void didUpdateWidget(QuizPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.questions != widget.questions) {
      _session = QuizSession(widget.questions);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Quiz COVID-19'),
      actions: [
        IconButton(
          tooltip: 'Fontes e informações',
          icon: const Icon(Icons.info_outline),
          onPressed: () => Navigator.of(context).push<void>(
            MaterialPageRoute(
              builder: (_) => SourcesPage(questions: widget.questions),
            ),
          ),
        ),
      ],
    ),
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _session.isComplete
                  ? _buildResults()
                  : _buildQuestion(),
            ),
          ),
        ),
      ),
    ),
  );

  List<Widget> _buildQuestion() {
    final question = _session.question;
    final answered = _session.selectedIndex != null;
    return [
      Text(
        'Pergunta ${_session.questionIndex + 1} de ${_session.total}',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 12),
      LinearProgressIndicator(
        value: _session.progress,
        semanticsLabel: 'Progresso de respostas',
        semanticsValue: '${(_session.progress * 100).round()}',
      ),
      const SizedBox(height: 24),
      Semantics(
        header: true,
        child: Text(
          question.prompt,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      const SizedBox(height: 24),
      for (var index = 0; index < question.options.length; index++)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: FilledButton(
            onPressed: answered
                ? null
                : () => setState(() {
                    _session.answer(index);
                  }),
            child: Text(question.options[index], textAlign: TextAlign.center),
          ),
        ),
      if (answered) ...[
        Semantics(
          liveRegion: true,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _session.isCorrect
                        ? 'Resposta correta!'
                        : 'Vamos aprender!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sua resposta: ${question.options[_session.selectedIndex!]}',
                  ),
                  Text('Resposta correta: ${question.correctAnswer}'),
                  const SizedBox(height: 8),
                  Text(question.explanation),
                  const SizedBox(height: 8),
                  Text(
                    'Fonte: ${question.source.host} • Revisão: ${question.reviewedOn}',
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: _advance,
          child: Text(
            _session.questionIndex == _session.total - 1
                ? 'Ver resultado'
                : 'Próxima pergunta',
          ),
        ),
      ],
      const SizedBox(height: 24),
      const Text(
        'Conteúdo educativo. Não substitui orientação profissional. '
        'Consulte as recomendações atuais das autoridades de saúde locais.',
      ),
    ];
  }

  List<Widget> _buildResults() => [
    Semantics(
      header: true,
      child: Text(
        'Quiz concluído',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    ),
    const SizedBox(height: 24),
    Text(
      '${_session.score} de ${_session.total} acertos',
      style: Theme.of(context).textTheme.headlineSmall,
    ),
    const SizedBox(height: 12),
    const Text(
      'Continue aprendendo com as fontes oficiais. '
      'A pontuação mede as respostas deste quiz, não o seu estado de saúde.',
    ),
    const SizedBox(height: 24),
    FilledButton(onPressed: _restart, child: const Text('Jogar novamente')),
  ];
}
