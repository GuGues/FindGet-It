import 'package:flutter/material.dart';


String parseString(dynamic value, {String defaultValue = ''}) {
  if (value is String) return value;
  if (value != null) return value.toString();
  return defaultValue;
}

int parseInt(dynamic value, {int defaultValue = 0}) {
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? defaultValue;
  return defaultValue;
}