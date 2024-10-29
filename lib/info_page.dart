import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titolo principale
              Center(
                child: Text(
                  'Benvenuto in Scale Trainer App!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              
              SizedBox(height: 24),// Sezione sulla passione e motivazione
              Text(
                'Questa app nasce dalla mia passione per la musica e dall\'esigenza di avere uno strumento pratico per lo studio delle scale. Come "aspirante musicista", ho cercato un modo efficace per memorizzare e praticare le scale, così ho deciso di creare questo strumento che unisce teoria e pratica.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),              
              SizedBox(height: 24),
              
              Text(
                'L\'applicazione al momento è divisa in due parti:',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              
              SizedBox(height: 16),
              
              // Sezione Teoria Scale
              Text(
                '• TEORIA SCALE:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, top: 8.0),
                child: Text(
                  'In questa sezione l\'app ti proporrà domande casuali sui gradi delle scale. Potrai personalizzare il tuo allenamento scegliendo sia le tipologie di scale che i gradi specifici su cui esercitarti.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              
              SizedBox(height: 16),
              
              // Sezione Pratica Scale
              Text(
                '• PRATICA SCALE:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, top: 8.0),
                child: Text(
                  'In questa sezione l\'app ti chiederà di suonare scale selezionate in modo casuale. Se hai gli aiuti abilitati, visualizzerai automaticamente i gradi della scala. In caso contrario, potrai sempre consultarli tramite l\'apposito pulsante quando ne avrai bisogno.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              
              SizedBox(height: 24),
              

              
              SizedBox(height: 24),
              
              // Disclaimer
              Text(
                'È importante precisare che questa è un\'app sviluppata con passione ma da un non professionista. Non sono un programmatore di mestiere, bensì un appassionato di musica che ha voluto creare uno strumento utile per sé e per gli altri. Per questo motivo, potresti incontrare qualche imperfezione o bug durante l\'utilizzo. Me ne scuso in anticipo e ti ringrazio per la comprensione.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              
              SizedBox(height: 24),
              
              // Sezione feedback
              Text(
                'Il tuo feedback è prezioso! Se riscontri problemi o hai suggerimenti per migliorare l\'app, puoi contattarmi:',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              
              SizedBox(height: 8),
              
              Text(
                'Email: alessio.iannarilli3@gmail.com',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: 24),
              
              // Chiusura
              Center(
                child: Text(
                  'Buono studio e buona musica!',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}