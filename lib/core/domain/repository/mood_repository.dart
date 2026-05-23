import '../../../../core/model/question.dart';

abstract class MoodRepository {
  Future<List<Question>> getQuestions();
}