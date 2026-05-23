import '../../../../core/model/question.dart';

abstract class MoodDataSource {
  Future<List<Question>> getQuestions();
}