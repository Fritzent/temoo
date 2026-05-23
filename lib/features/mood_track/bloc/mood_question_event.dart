abstract class MoodQuestionEvent {}

class LoadMoodQuestions extends MoodQuestionEvent {}

class SelectMoodAnswer extends MoodQuestionEvent {
  final String questionId;
  final String optionId;

  SelectMoodAnswer({
    required this.questionId,
    required this.optionId,
  });
}