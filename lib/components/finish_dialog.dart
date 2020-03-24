import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_covid19/pages/quiz_page.dart';
import 'package:share/share.dart';

class FinishDialog {
  static Future show(
    BuildContext context, {
    int hitNumber,
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
            backgroundColor: Colors.green,
            maxRadius: 35.0,
            child: Icon(
              hitNumber < 6 ? Icons.warning : Icons.favorite,
              color: Colors.grey.shade900,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Parabéns',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Você acertou $hitNumber de 10!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Que tal tentar mais uma vez? Quem sabe você consegue acertar todas na próxima!',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          actions: [
            FlatButton(
              child: const Text('COMPARTILHAR'),
              onPressed: () {
                Share.share('Quiz COVID-29. Você acertou $hitNumber de 10!');
              },
            ),
            FlatButton(
              child: const Text('JOGAR NOVAMENTE'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
            ),
            FlatButton(
              child: const Text('SAIR'),
              onPressed: () {
                SystemNavigator.pop();
              },
            )
          ],
        );
      },
    );
  }
}
