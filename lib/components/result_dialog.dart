import 'package:flutter/material.dart';
import 'package:quiz_covid19/models/question.dart';

class ResultDialog {
  static Future show(
    BuildContext context, {
    @required Question question,
    @required bool correct,
    @required Function onNext,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          title: CircleAvatar(
            backgroundColor: correct ? Colors.green : Colors.red,
            child: Icon(
              correct ? Icons.check : Icons.close,
              color: Colors.grey.shade900,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                question.question,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                correct ? 'Você acertou!' : 'Você errou! O correto é:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: correct ? Colors.green : Colors.red,
                ),
              ),
              Text(
                question.answer1,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          actions: [
            FlatButton(
              child: const Text('PRÓXIMO'),
              onPressed: () {
                Navigator.of(context).pop();
                onNext();
              },
            )
          ],
        );
      },
    );
  }
}
