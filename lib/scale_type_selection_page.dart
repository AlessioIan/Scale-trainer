import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'grade_selection_page.dart';

class ScaleTypeSelectionPage extends StatefulWidget {
  @override
  _ScaleTypeSelectionPageState createState() => _ScaleTypeSelectionPageState();
}

class _ScaleTypeSelectionPageState extends State<ScaleTypeSelectionPage> {
  final scaleTypes = ['Maggiore', 'Minore'];
  final selectedScaleTypes = <String>{};
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
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Titolo
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Seleziona la tipologia di scale da allenare',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 30),

              // Scale options
              ...scaleTypes.map((type) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: selectedScaleTypes.contains(type)
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300]!,
                      width: 2,
                    ),
                  ),
                  child: CheckboxListTile(
                    title: Text(
                      'Scale $type',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: selectedScaleTypes.contains(type)
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    value: selectedScaleTypes.contains(type),
                    onChanged: (bool? value) {
                      HapticFeedback.lightImpact();
                      setState(() {
                        value! ? selectedScaleTypes.add(type) : selectedScaleTypes.remove(type);
                      });
                    },
                    activeColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )).toList(),

              SizedBox(height: 20),

              // Seleziona tutto button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Seleziona tutto',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    playSwishSound();
                    setState(() => selectedScaleTypes.addAll(scaleTypes));
                  },
                ),
              ),

              SizedBox(height: 30),

              // Avanti button
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
                  child: Text(
                    'Avanti',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (selectedScaleTypes.isNotEmpty) {
                      HapticFeedback.mediumImpact();
                      playSwishSound();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GradeSelectionPage(
                            selectedScaleTypes: selectedScaleTypes.toList(),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Seleziona almeno un tipo di scala')),
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