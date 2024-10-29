import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckAnswerButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isCorrect;
  final bool answered;

  const CheckAnswerButton({
    Key? key,
    required this.onPressed,
    this.isCorrect = false,
    this.answered = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color buttonColor = Theme.of(context).primaryColor;
    if (answered) {
      buttonColor = isCorrect ? Colors.green : Colors.red;
    }

    return ElevatedButton(
      onPressed: answered ? null : () {
        HapticFeedback.mediumImpact();
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      child: Text(
        'Controlla',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class NextQuestionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isEnabled;

  const NextQuestionButton({
    Key? key,
    required this.onPressed,
    required this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? () {
        HapticFeedback.mediumImpact();
        onPressed();
      } : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Text(
        'Prossima domanda',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}