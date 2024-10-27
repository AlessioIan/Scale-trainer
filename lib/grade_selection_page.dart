import 'package:flutter/material.dart';
import 'quiz_page.dart';

class GradeSelectionPage extends StatefulWidget {
  final List<String> selectedScaleTypes;
  GradeSelectionPage({required this.selectedScaleTypes});

  @override
  _GradeSelectionPageState createState() => _GradeSelectionPageState();
}

class _GradeSelectionPageState extends State<GradeSelectionPage> {
  final selectedDegrees = <int>{};

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
                  'Seleziona i gradi da allenare',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 10),

              // Grades options
              ...List.generate(7, (index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: selectedDegrees.contains(index + 1)
                          ? Colors.blue
                          : Colors.grey[300]!,
                      width: 2,
                    ),
                  ),
                  child: CheckboxListTile(
                    title: Text(
                      'Grado ${index + 1}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: selectedDegrees.contains(index + 1)
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    value: selectedDegrees.contains(index + 1),
                    onChanged: (bool? value) {
                      setState(() {
                        value! ? selectedDegrees.add(index + 1) : selectedDegrees.remove(index + 1);
                      });
                    },
                    activeColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )),

              SizedBox(height: 10),

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
                  onPressed: () => setState(() => selectedDegrees.addAll(List.generate(7, (i) => i + 1))),
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
                    if (selectedDegrees.isNotEmpty) {
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