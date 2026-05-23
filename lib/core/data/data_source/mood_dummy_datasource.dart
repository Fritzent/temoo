import '../../../../core/dummy/dummy_question.dart';
import '../../../../core/model/question.dart';
import 'mood_datasource.dart';

class MoodDummyDataSource implements MoodDataSource {
  @override
  Future<List<Question>> getQuestions() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return DummyQuestion.questions;
  }
}