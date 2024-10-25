import 'dart:math';

class QuestionData {
  final String question;
  final String correctAnswer;
  final List<String> options;

  QuestionData({
    required this.question,
    required this.correctAnswer,
    required this.options,
  });
}

class QuestionGenerator {
  final List<String> selectedScaleTypes;
  final List<int> selectedDegrees;
  final Random random = Random();

  QuestionGenerator(this.selectedScaleTypes, this.selectedDegrees);

  final Map<String, List<String>> scales = {
    'DO Maggiore': ['DO', 'RE', 'MI', 'FA', 'SOL', 'LA', 'SI'],
    'SOL Maggiore': ['SOL', 'LA', 'SI', 'DO', 'RE', 'MI', 'FA#'],
    'RE Maggiore': ['RE', 'MI', 'FA#', 'SOL', 'LA', 'SI', 'DO#'],
    'LA Maggiore': ['LA', 'SI', 'DO#', 'RE', 'MI', 'FA#', 'SOL#'],
    'MI Maggiore': ['MI', 'FA#', 'SOL#', 'LA', 'SI', 'DO#', 'RE#'],
    'SI Maggiore': ['SI', 'DO#', 'RE#', 'MI', 'FA#', 'SOL#', 'LA#'],
    'FA# Maggiore': ['FA#', 'SOL#', 'LA#', 'SI', 'DO#', 'RE#', 'MI#'],
    'DO# Maggiore': ['DO#', 'RE#', 'MI#', 'FA#', 'SOL#', 'LA#', 'SI#'],
    'FA Maggiore': ['FA', 'SOL', 'LA', 'SIb', 'DO', 'RE', 'MI'],
    'SIb Maggiore': ['SIb', 'DO', 'RE', 'MIb', 'FA', 'SOL', 'LA'],
    'MIb Maggiore': ['MIb', 'FA', 'SOL', 'LAb', 'SIb', 'DO', 'RE'],
    'LAb Maggiore': ['LAb', 'SIb', 'DO', 'REb', 'MIb', 'FA', 'SOL'],
    'REb Maggiore': ['REb', 'MIb', 'FA', 'SOLb', 'LAb', 'SIb', 'DO'],
    'SOLb Maggiore': ['SOLb', 'LAb', 'SIb', 'DOb', 'REb', 'MIb', 'FA'],
    'DOb Maggiore': ['DOb', 'REb', 'MIb', 'FAb', 'SOLb', 'LAb', 'SIb'],
    'DO Minore': ['DO', 'RE', 'MIb', 'FA', 'SOL', 'LAb', 'SIb'],
  };

  List<String> get allNotes => ['DO', 'DO#', 'REb', 'RE', 'RE#', 'MIb', 'MI', 'MI#', 'FAb', 'FA', 'FA#', 'SOLb', 'SOL', 'SOL#', 'LAb', 'LA', 'LA#', 'SIb', 'SI', 'SI#', 'DOb'];

  QuestionData generateQuestion() {
    final selectedScaleType = selectedScaleTypes[random.nextInt(selectedScaleTypes.length)];
    final possibleScales = scales.keys.where((scale) => scale.contains(selectedScaleType)).toList();
    final selectedScale = possibleScales[random.nextInt(possibleScales.length)];
    final selectedDegree = selectedDegrees[random.nextInt(selectedDegrees.length)];

    return QuestionData(
      question: 'Qual è il $selectedDegree° grado della scala di $selectedScale?',
      correctAnswer: scales[selectedScale]![selectedDegree - 1],
      options: allNotes,
    );
  }
}