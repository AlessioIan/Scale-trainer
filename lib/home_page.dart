import 'package:flutter/material.dart';
import 'scale_type_selection_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
            
            // Spazio tra il testo e i pulsanti
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
                  // Per ora mostriamo solo un messaggio
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Funzionalità in sviluppo')),
                  );
                },
                child: Text(
                  'Pratica Scale',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}