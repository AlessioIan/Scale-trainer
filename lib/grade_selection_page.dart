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
      appBar: AppBar(title: Text('Seleziona i gradi')),
      body: Column(
        children: [
          ...List.generate(7, (index) => CheckboxListTile(
                title: Text('Grado ${index + 1}'),
                value: selectedDegrees.contains(index + 1),
                onChanged: (bool? value) {
                  setState(() {
                    value! ? selectedDegrees.add(index + 1) : selectedDegrees.remove(index + 1);
                  });
                },
              )),
          ElevatedButton(
            child: Text('Seleziona tutto'),
            onPressed: () => setState(() => selectedDegrees.addAll(List.generate(7, (i) => i + 1))),
          ),
          Spacer(),
          ElevatedButton(
            child: Text('Avanti'),
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
        ],
      ),
    );
  }
}