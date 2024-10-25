import 'package:flutter/material.dart';
import 'grade_selection_page.dart';

class ScaleTypeSelectionPage extends StatefulWidget {
  @override
  _ScaleTypeSelectionPageState createState() => _ScaleTypeSelectionPageState();
}

class _ScaleTypeSelectionPageState extends State<ScaleTypeSelectionPage> {
  final scaleTypes = ['Maggiore', 'Minore'];
  final selectedScaleTypes = <String>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Seleziona il tipo di scala')),
      body: Column(
        children: [
          ...scaleTypes.map((type) => CheckboxListTile(
                title: Text('Scale $type'),
                value: selectedScaleTypes.contains(type),
                onChanged: (bool? value) {
                  setState(() {
                    value! ? selectedScaleTypes.add(type) : selectedScaleTypes.remove(type);
                  });
                },
              )),
          ElevatedButton(
            child: Text('Seleziona tutto'),
            onPressed: () => setState(() => selectedScaleTypes.addAll(scaleTypes)),
          ),
          Spacer(),
          ElevatedButton(
            child: Text('Avanti'),
            onPressed: () {
              if (selectedScaleTypes.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GradeSelectionPage(selectedScaleTypes: selectedScaleTypes.toList()),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Seleziona almeno un tipo di scala')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}