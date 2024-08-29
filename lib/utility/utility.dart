import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';

class Utility{

  static String convertNumberToWords(double number) {
    if (number == 0) return 'Zero';

    int integerPart = number.toInt();
    int decimalPart = ((number - integerPart) * 100).round();

    String words = _convertIntegerToWords(integerPart);

    if (decimalPart > 0) {
      words += ' and ' + _convertIntegerToWords(decimalPart) + ' Paisa';
    }

    return words.trim();
  }

  static String _convertIntegerToWords(int number) {
    if (number == 0) return '';

    int i = 0;
    String words = '';

    while (number > 0) {
      if (number % 1000 != 0) {
        words = _convertHundreds(number % 1000) + thousands[i] + ' ' + words;
      }
      number ~/= 1000;
      i++;
    }

    return words.trim();
  }

  static String _convertHundreds(int number) {
    String str = '';

    if (number > 99) {
      str += units[number ~/ 100] + ' Hundred ';
      number %= 100;
    }

    if (number > 19) {
      str += tens[number ~/ 10] + ' ';
      number %= 10;
    }

    if (number > 0 && number < 10) {
      str += units[number] + ' ';
    } else if (number >= 10) {
      str += teens[number - 10] + ' ';
    }

    return str;
  }



}






const List<String> units = [
  '', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine'
];

const List<String> teens = [
  'Ten', 'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen'
];

const List<String> tens = [
  '', '', 'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety'
];

const List<String> thousands = [
  '', 'Thousand', 'Million', 'Billion', 'Trillion'
];



