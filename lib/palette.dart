import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void showColorPickerDialog(BuildContext context, onColorSelected) {
  Color selectedColor = Colors.black;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('選擇顏色'),
        content: SingleChildScrollView(
          child: MaterialPicker(
            pickerColor: selectedColor,
            onColorChanged: (color) {
              selectedColor = color;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              onColorSelected(selectedColor);
              Navigator.pop(context);
            },
            child: const Text('確定'),
          ),
        ],
      );
    },
  );
}
