import 'package:flutter/material.dart';

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String name;
  final ValueChanged<T?> onChanged;
  final Color color;
  final double shape;

  const MyRadioListTile({
    required this.value,
    required this.groupValue,
    required this.name,
    required this.color,
    required this.onChanged,
    required this.shape
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      focusColor: Color.fromARGB(0, 0, 0, 0),
      highlightColor: Color.fromARGB(0, 0, 0, 0),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 1),
        //padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _customRadioButton,
            SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? color : null,
        borderRadius: BorderRadius.circular(shape),
        border: Border.all(
          color: isSelected ? color : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Text(
        name,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[600]!,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        )
      ),
    );
  }
}