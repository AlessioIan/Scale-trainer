import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'quiz_page.dart';

class GradeSelectionPage extends StatefulWidget {
  final List<String> selectedScaleTypes;
  GradeSelectionPage({required this.selectedScaleTypes});

  @override
  _GradeSelectionPageState createState() => _GradeSelectionPageState();
}

class _GradeSelectionPageState extends State<GradeSelectionPage> {
  final selectedDegrees = <int>{};
  final AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playSwishSound() async {
    try {
      await audioPlayer.play(AssetSource('sounds/swish2.mp3'));
    } catch (e) {
      print('Errore durante la riproduzione del suono: $e');
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Teoria Scale')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Titolo
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Seleziona i gradi da allenare',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 12),

              // Grades options in una ListView compatta
              Container(
                height: 400,
                child: ListView(
                  children: List.generate(7, (index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selectedDegrees.contains(index + 1)
                              ? Theme.of(context).primaryColor
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: CheckboxListTile(
                        title: Text(
                          'Grado ${index + 1}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: selectedDegrees.contains(index + 1)
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        value: selectedDegrees.contains(index + 1),
                        onChanged: (bool? value) {
                          HapticFeedback.lightImpact();
                          setState(() {
                            value! ? selectedDegrees.add(index + 1) : selectedDegrees.remove(index + 1);
                          });
                        },
                        activeColor: Theme.of(context).primaryColor,
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 70),
                      ),
                    ),
                  )),
                ),
              ),

              SizedBox(height: 16),

              // Seleziona tutto button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Seleziona tutto',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    playSwishSound();
                    setState(() => selectedDegrees.addAll(List.generate(7, (i) => i + 1)));
                  },
                ),
              ),

              SizedBox(height: 16),

              // Avanti button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Avanti',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (selectedDegrees.isNotEmpty) {
                      HapticFeedback.mediumImpact();
                      playSwishSound();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(
                            selectedScaleTypes: widget.selectedScaleTypes,
                            selectedDegrees: selectedDegrees.toList(),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Seleziona almeno un grado')),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}