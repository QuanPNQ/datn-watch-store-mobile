import 'package:flutter/services.dart';

class NoSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.contains(' ')) {
      final String newText = newValue.text.replaceAll(' ', '');

      final int offsetDiff = newValue.text.length - newText.length;
      final int newOffset = newValue.selection.end - offsetDiff;

      return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newOffset),
      );
    }

    return newValue;
  }
}
