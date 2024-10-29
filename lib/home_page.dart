import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'scale_type_selection_page.dart';
import 'practice_type_selection_page.dart';
import 'info_page.dart';  // Nuovo import per la pagina Info

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              
              // Logo
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Image.asset(
                  'assets/images/logohome.png',
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
              
              // Testo descrittivo
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Cosa vuoi fare?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              SizedBox(height: 40),
              
              // Pulsante Teoria Scale
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    playSwishSound();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScaleTypeSelectionPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Teoria Scale',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              
              // Pulsante Pratica Scale
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    playSwishSound();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PracticeTypeSelectionPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Pratica Scale',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: SizedBox(),
              ),

              // Pulsante Info - Modificato per navigare alla pagina Info
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: TextButton.icon(
                  icon: Icon(Icons.info_outline),
                  label: Text('Info'),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InfoPage()),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}