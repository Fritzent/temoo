import 'package:tere_mood/core/model/question.dart';

class MoodQuestionState {
  final bool isLoading;
  final List<Question> questions;
  final Map<String, String> selectedAnswers;

  const MoodQuestionState({
    this.isLoading = false,
    this.questions = const [],
    this.selectedAnswers = const {},
  });

  MoodQuestionState copyWith({
    bool? isLoading,
    List<Question>? questions,
    Map<String, String>? selectedAnswers,
  }) {
    return MoodQuestionState(
      isLoading: isLoading ?? this.isLoading,
      questions: questions ?? this.questions,
      selectedAnswers:
          selectedAnswers ?? this.selectedAnswers,
    );
  }
}