import 'package:flutter/material.dart';

class QuestionOption {
  final String id;
  final String label;
  final String description;
  final IconData icon;
  final Color iconBackgroundColor;

  QuestionOption({
    required this.id,
    required this.label,
    required this.description,
    required this.icon,
    required this.iconBackgroundColor,
  });
}