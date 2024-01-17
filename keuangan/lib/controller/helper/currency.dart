import 'package:flutter/material.dart';

String intToCurrency(num data) {
  int getLength = data.toString().length;
  String parseData = data.toString();
  int tousand = 0;
  String build = '';

  while (getLength > 3) {
    getLength -= 3;
    ++tousand;
    if (tousand == 1) {
      build = parseData.substring(getLength, getLength + 3) + build;
    } else {
      build = '${parseData.substring(getLength, getLength + 3)}.$build';
    }
  }
  if (parseData.length < 4) {
    build = parseData;
  } else {
    build = '${parseData.substring(0, getLength)}.$build';
  }
  return build;
}

currencyFormat({required String data, required TextEditingController controller}) {
  try {
    if (data[0] == '0') {
      data = data.substring(1, data.length);
    }
  } catch (_) {}
  int getLength = data.replaceAll('.', '').length;
  data = data.replaceAll('.', '');
  int tousand = 0;
  String build = '';

  while (getLength > 3) {
    getLength -= 3;
    ++tousand;
    if (tousand == 1) {
      build = '${data.substring(getLength, getLength + 3)}$build';
    } else {
      build = '${data.substring(getLength, getLength + 3)}.$build';
    }
  }
  if (data.length < 4) {
    build = data;
  } else {
    build = '${data.substring(0, getLength)}.$build';
  }
  controller.text = build;
  controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
}

removeDot(double data) {
  String lastNumber = data.toString().split('.').length == 2 ? ',${data.toString().split('.').last}' : '';
  if (lastNumber == ',0' || lastNumber == ',00') {
    lastNumber = '';
  }
  String parseData = data.toString().split('.').first;
  return parseData + lastNumber;
}

String toCurrency(double data) {
  String lastNumber = data.toString().split('.').length == 2 ? ',${data.toString().split('.').last}' : '';
  if (lastNumber == ',0' || lastNumber == ',00') {
    lastNumber = '';
  }
  int getLength = data.toString().split('.').first.length;
  String parseData = data.toString().split('.').first;
  int tousand = 0;
  String build = '';

  while (getLength > 3) {
    getLength -= 3;
    ++tousand;
    if (tousand == 1) {
      build = '${parseData.substring(getLength, getLength + 3)}$build';
    } else {
      build = '${parseData.substring(getLength, getLength + 3)}.$build';
    }
  }
  if (parseData.length < 4) {
    build = parseData;
  } else {
    build = '${parseData.substring(0, getLength)}.$build';
  }
  return build + lastNumber;
}
