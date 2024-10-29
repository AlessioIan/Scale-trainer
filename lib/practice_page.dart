import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class PracticePage extends StatefulWidget {
  final List<String> selectedScaleTypes;
  final bool hintsEnabled;

  PracticePage({
    required this.selectedScaleTypes,
    required this.hintsEnabled,
  });

  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool showHints = false;
  late String currentScale;
  late String currentType;

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

  @override
  void initState() {
    super.initState();
    showHints = widget.hintsEnabled;
    generateNewScale();
  }

  void generateNewScale() {
    final List<String> possibleScales = scales.keys
        .where((scale) => widget.selectedScaleTypes
            .any((type) => scale.contains(type)))
        .toList();
    final random = Random();
    final selectedScale = possibleScales[random.nextInt(possibleScales.length)];
    setState(() {
      currentScale = selectedScale.split(' ')[0];
      currentType = selectedScale.split(' ')[1];
      showHints = widget.hintsEnabled;
    });
  }

  Future<void> playSwishSound() async {
    try {
      await audioPlayer.play(AssetSource('sounds/swish2.mp3'));
    } catch (e) {
      print('Errore durante la riproduzione del suono: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaleNotes = scales['$currentScale $currentType'] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text('Pratica Scale')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Titolo con la scala da suonare
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Suona la scala di\n$currentScale $currentType',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 20),

              // Lista dei gradi
              if (showHints)
                Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 200), // Imposta una larghezza massima per il container
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Allinea il contenuto a sinistra
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        scaleNotes.length,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            '${index + 1}° ${scaleNotes[index]}',
                            style: TextStyle(
                              fontSize: 18,
                              color: (scaleNotes[index].contains('#') || scaleNotes[index].contains('b')) 
                                  ? Theme.of(context).primaryColor 
                                  : Colors.black,
                              fontWeight: (scaleNotes[index].contains('#') || scaleNotes[index].contains('b'))
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              // Pulsante per mostrare gli aiuti
              if (!showHints)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    setState(() {
                      showHints = true;
                    });
                  },
                  child: Text(
                    'Mostra aiuti',
                    style: TextStyle(fontSize: 20),
                  ),
                ),

              Spacer(),

              // Pulsante prossima scala
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    playSwishSound();
                    generateNewScale();
                  },
                  child: Text(
                    'Prossima scala',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}