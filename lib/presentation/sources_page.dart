import 'package:material_ui/material_ui.dart';

import '../domain/question.dart';

class SourcesPage extends StatelessWidget {
  const SourcesPage({super.key, required this.questions});
  final List<Question> questions;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Fontes e informações')),
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Text(
                'Quiz educativo e offline, em português. Sem coleta de dados. '
                'As orientações podem mudar; procure fontes oficiais atualizadas. '
                'Este app não oferece diagnóstico ou tratamento.',
              ),
              const SizedBox(height: 24),
              for (final question in questions)
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.prompt,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text('Revisão: ${question.reviewedOn}'),
                      Semantics(
                        container: true,
                        label: 'Fonte: ${question.source}',
                        excludeSemantics: true,
                        child: SelectableText(question.source.toString()),
                      ),
                    ],
                  ),
                ),
              OutlinedButton(
                onPressed: () => showLicensePage(
                  context: context,
                  applicationName: 'Quiz COVID-19',
                ),
                child: const Text('Licenças de software'),
              ),
              const SizedBox(height: 24),
              const Text(
                'Criado por Kleber de Oliveira Andrade (2020). '
                'Código e documentação sob licença MIT. '
                'As fontes citadas mantêm seus próprios direitos.',
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
