import 'package:tere_mood/core/data/data_source/mood_datasource.dart';

import '../../../../core/model/question.dart';
import '../../domain/repository/mood_repository.dart';

class MoodRepositoryImpl implements MoodRepository {
  final MoodDataSource datasource;

  MoodRepositoryImpl(this.datasource);

  @override
  Future<List<Question>> getQuestions() {
    return datasource.getQuestions();
  }
}