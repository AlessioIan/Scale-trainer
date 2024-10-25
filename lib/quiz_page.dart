import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'models/question_generator.dart';
import 'models/answer_checker.dart';
import 'components/option_wheel.dart';
import 'components/quiz_buttons.dart';

class QuizPage extends StatefulWidget {
  final List<String> selectedScaleTypes;
  final List<int> selectedDegrees;
  
  QuizPage({required this.selectedScaleTypes, required this.selectedDegrees});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late QuestionGenerator questionGenerator;
  final answerChecker = AnswerChecker();
  Timer? _timer;
  
  final AudioPlayer audioPlayer = AudioPlayer();
  
  String question = '';
  List<String> options = [];
  String correctAnswer = '';
  String feedbackMessage = '';
  int selectedIndex = 0;
  bool answered = false;
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    questionGenerator = QuestionGenerator(widget.selectedScaleTypes, widget.selectedDegrees);
    generateQuestion();
  }

  void generateQuestion() {
    _timer?.cancel();
    playSwishSound();
    final questionData = questionGenerator.generateQuestion();
    setState(() {
      question = questionData.question;
      correctAnswer = questionData.correctAnswer;
      options = questionData.options;
      feedbackMessage = '';
      selectedIndex = 0;
      answered = false;
      isCorrect = false;
    });
  }

  Future<void> playSound(bool correct) async {
    try {
      await audioPlayer.stop();
      await audioPlayer.play(AssetSource(correct ? 'sounds/correct.mp3' : 'sounds/wrong.mp3'));
    } catch (e) {
      print('Errore durante la riproduzione del suono: $e');
    }
  }

  Future<void> playSwishSound() async {
    try {
      await audioPlayer.stop();
      await audioPlayer.play(AssetSource('sounds/swish.mp3'));
    } catch (e) {
      print('Errore durante la riproduzione del suono swish: $e');
    }
  }

  void checkAnswer() {
    if (answered) return;
    
    isCorrect = answerChecker.checkAnswer(options[selectedIndex], correctAnswer);
    playSound(isCorrect);
    
    setState(() {
      answered = true;
      feedbackMessage = isCorrect ? 'Corretto!' : 'Sbagliato! La nota corretta è $correctAnswer.';
    });

    if (isCorrect) {
      _timer = Timer(Duration(seconds: 2), () {
        if (mounted) {
          generateQuestion();
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              question,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
          OptionWheel(
            options: options,
            selectedIndex: selectedIndex,
            onSelectedItemChanged: (index) {
              if (!answered) {
                setState(() => selectedIndex = index);
                HapticFeedback.lightImpact();
              }
            },
            isEnabled: !answered,
          ),
          SizedBox(height: 20),
          CheckAnswerButton(
            onPressed: checkAnswer,
            isCorrect: isCorrect,
            answered: answered,
          ),
          SizedBox(height: 20),
          Text(
            feedbackMessage,
            style: TextStyle(
              fontSize: 18,
              color: answered ? (isCorrect ? Colors.green : Colors.red) : Colors.black,
            ),
          ),
          SizedBox(height: 20),
          if (!isCorrect && answered)
            NextQuestionButton(
              onPressed: generateQuestion,
              isEnabled: true,
            ),
        ],
      ),
    );
  }
}