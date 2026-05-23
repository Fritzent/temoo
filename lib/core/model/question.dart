import 'question_option.dart';

class Question {
  final String id;
  final String question;
  final String emoji;
  final String description;
  final List<QuestionOption> options;

  Question({
    required this.id,
    required this.question,
    required this.emoji,
    required this.description,
    required this.options,
  });
}