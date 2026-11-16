import '../domain/question.dart';

const contentReviewedOn = '2026-11-16';
final _who = Uri.parse(
  'https://www.who.int/news-room/fact-sheets/detail/coronavirus-disease-(covid-19)',
);

// Educational paraphrases; see docs/CONTENT.md for provenance and maintenance.
final List<Question> questionBank = List.unmodifiable([
  Question(
    id: 'cause',
    prompt: 'Qual agente causa a COVID-19?',
    options: ['O vírus SARS-CoV-2', 'Uma bactéria'],
    correctIndex: 0,
    explanation: 'A COVID-19 é causada pelo coronavírus SARS-CoV-2.',
    source: _who,
    reviewedOn: contentReviewedOn,
  ),
  Question(
    id: 'air',
    prompt: 'Como a COVID-19 pode se transmitir?',
    options: [
      'Somente ao tocar objetos',
      'Pelo ar, por partículas respiratórias',
    ],
    correctIndex: 1,
    explanation: 'O risco aumenta em contato próximo e em ambientes fechados compartilhados.',
    source: _who,
    reviewedOn: contentReviewedOn,
  ),
  Question(
    id: 'ventilation',
    prompt: 'O que ajuda a reduzir o risco em ambientes internos?',
    options: ['Melhorar a ventilação', 'Manter o ambiente sem renovação de ar'],
    correctIndex: 0,
    explanation: 'A ventilação integra as medidas de prevenção.',
    source: _who,
    reviewedOn: contentReviewedOn,
  ),
  Question(
    id: 'vaccination',
    prompt: 'Qual é um benefício importante da vacinação?',
    options: ['Impedir toda transmissão', 'Proteger contra doença grave'],
    correctIndex: 1,
    explanation: 'Vacinas protegem contra doença grave e morte. Siga as recomendações locais.',
    source: _who,
    reviewedOn: contentReviewedOn,
  ),
  Question(
    id: 'symptoms',
    prompt: 'Uma pessoa sem sintomas pode transmitir o vírus?',
    options: ['Sim', 'Não'],
    correctIndex: 0,
    explanation:
        'A transmissão pode ocorrer antes dos sintomas ou sem sintomas.',
    source: _who,
    reviewedOn: contentReviewedOn,
  ),
  Question(
    id: 'long-covid',
    prompt: 'Os efeitos da COVID-19 podem persistir?',
    options: [
      'Nunca persistem',
      'Sim, algumas pessoas têm efeitos prolongados',
    ],
    correctIndex: 1,
    explanation: 'A condição pós-COVID-19 pode afetar as atividades diárias.',
    source: _who,
    reviewedOn: contentReviewedOn,
  ),
]);
