import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OptionWheel extends StatelessWidget {
  final List<String> options;
  final int selectedIndex;
  final Function(int) onSelectedItemChanged;
  final bool isEnabled;

  const OptionWheel({
    Key? key,
    required this.options,
    required this.selectedIndex,
    required this.onSelectedItemChanged,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repeatedOptions = List<String>.generate(
      options.length * 1000,
      (index) => options[index % options.length],
    );

    final initialIndex = (repeatedOptions.length / 2).floor() + selectedIndex;

    return SizedBox(
      height: 300,
      child: ListWheelScrollView.useDelegate(
        physics: isEnabled
            ? FixedExtentScrollPhysics()
            : NeverScrollableScrollPhysics(),
        itemExtent: 60,
        onSelectedItemChanged: (index) {
          if (isEnabled) {
            final actualIndex = index % options.length;
            onSelectedItemChanged(actualIndex);
            HapticFeedback.lightImpact();
          }
        },
        controller: FixedExtentScrollController(initialItem: initialIndex),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: repeatedOptions.length,
          builder: (context, index) {
            final actualIndex = index % options.length;
            final isSelected = actualIndex == selectedIndex;

            return AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: isSelected ? 200 : 100,  // Larghezza aumentata per l'elemento selezionato
              height: isSelected ? 80 : 50,   // Altezza aumentata per l'elemento selezionato
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.blue.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                options[actualIndex],
                style: TextStyle(
                  fontSize: isSelected ? 32 : 18,  // Font size aumentato per l'elemento selezionato
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.blue : Colors.black87,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}