import 'package:tere_mood/core/model/question.dart';
import '../repository/mood_repository.dart';

class GetQuestionsUseCase {
  final MoodRepository repository;

  GetQuestionsUseCase(this.repository);

  Future<List<Question>> call() {
    return repository.getQuestions();
  }
}