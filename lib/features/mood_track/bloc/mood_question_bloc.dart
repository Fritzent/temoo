import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tere_mood/core/domain/repository/mood_repository.dart';

import 'mood_question_event.dart';
import 'mood_question_state.dart';

class MoodQuestionBloc extends Bloc<MoodQuestionEvent, MoodQuestionState> {
  final MoodRepository repository;

  MoodQuestionBloc(this.repository) : super(const MoodQuestionState()) {
    on<LoadMoodQuestions>(_onLoadQuestions);
    on<SelectMoodAnswer>(_onSelectAnswer);
  }

  Future<void> _onLoadQuestions(
    LoadMoodQuestions event,
    Emitter<MoodQuestionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final questions = await repository.getQuestions();

    emit(
      state.copyWith(
        isLoading: false,
        questions: questions,
      ),
    );
  }

  void _onSelectAnswer(
    SelectMoodAnswer event,
    Emitter<MoodQuestionState> emit,
  ) {
    final updated =
        Map<String, String>.from(state.selectedAnswers);

    updated[event.questionId] = event.optionId;

    emit(
      state.copyWith(
        selectedAnswers: updated,
      ),
    );
  }
}