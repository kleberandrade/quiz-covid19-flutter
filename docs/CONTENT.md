# Educational content and sources

Reviewed: **2026-11-16**. App language: Brazilian Portuguese.

The bundled bank in `lib/data/question_bank.dart` contains original educational paraphrases of the [WHO COVID-19 fact sheet](https://www.who.int/news-room/fact-sheets/detail/coronavirus-disease-(covid-19)), dated 27 November 2025 and accessed on the review date. The six question IDs map to the sheet's sections:

- `cause`: Key facts / Overview.
- `air`: Transmission.
- `ventilation`: Prevention.
- `vaccination`: Vaccines.
- `symptoms`: Transmission.
- `long-covid`: Overview / Symptoms.

This is a small educational exercise, not a clinical assessment. No efficacy percentage, vaccination schedule, diagnosis, treatment or personal risk score is supplied. Follow current local health authority guidance, including [Brazil's Ministry of Health](https://www.gov.br/saude/pt-br/assuntos/covid-19), for decisions affecting health. The app prominently explains its educational limits.

The original 2020 Google Sheets endpoint is no longer queried. Its changing or unavailable content cannot establish the provenance of a current recommendation. The new bank is versioned with the source code and works without a question server.

## Maintaining questions

Verify an official source before editing a health question. Record the question's `source` URL and `reviewedOn` date; update `contentReviewedOn` and the bank's review test when reviewing the complete bank. Do not assume a historically published page is still maintained. For example, the [WHO masks Q&A](https://www.who.int/news-room/questions-and-answers/item/coronavirus-disease-covid-19-masks), checked during this work, explicitly says it is no longer updated; it was not used as the current bank's source.

Keep one unambiguously correct answer, short alternatives, a plain-language explanation and a stable unique ID. Put correctness in `correctIndex`, not in the first option's position or answer text. The current bank alternates correct positions. The constructor rejects blank text, duplicate options, invalid indexes, non-HTTPS sources and invalid ISO dates.

After updating content, run the full tests and have a qualified human review medical meaning and Portuguese wording. No clinician review was performed as part of this software update. Recheck sources before any release and periodically afterward; the date is a review record, not a guarantee of ongoing accuracy. WHO retains its rights in the source material; see `THIRD_PARTY.md`.
