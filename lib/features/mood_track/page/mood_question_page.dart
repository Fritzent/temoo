import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tere_mood/features/mood_track/bloc/mood_question_bloc.dart';
import 'package:tere_mood/features/mood_track/bloc/mood_question_event.dart';
import 'package:tere_mood/features/mood_track/bloc/mood_question_state.dart';

import '../../../../injection.dart';

class MoodQuestionPage extends StatelessWidget {
  const MoodQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MoodQuestionBloc(sl())
        ..add(
          LoadMoodQuestions(),
        ),
      child: const _MoodQuestionPageView(),
    );
  }
}

class _MoodQuestionPageView extends StatelessWidget {
  const _MoodQuestionPageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FC),
      body: SafeArea(
        child: BlocBuilder<MoodQuestionBloc, MoodQuestionState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
        
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: state.questions.length,
              itemBuilder: (context, index) {
                final question = state.questions[index];
        
                return Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                        color: Colors.black.withOpacity(0.04),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.emoji,
                        style: const TextStyle(
                          fontSize: 40,
                        ),
                      ),
        
                      const SizedBox(height: 16),
        
                      Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color:  Color(0xFF1A1A2E),
                        ),
                      ),
        
                      const SizedBox(height: 8),
        
                      Text(
                        question.description,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                      ),
        
                      const SizedBox(height: 24),
        
                      ...question.options.map((option) {
                        final isSelected =
                            state.selectedAnswers[
                                    question.id] ==
                                option.id;
        
                        return GestureDetector(
                          onTap: () {
                            context.read<MoodQuestionBloc>().add(
                                  SelectMoodAnswer(
                                    questionId:
                                        question.id,
                                    optionId: option.id,
                                  ),
                                );
                          },
                          child: AnimatedContainer(
                            duration:
                                const Duration(
                              milliseconds: 250,
                            ),
                            margin:
                                const EdgeInsets.only(
                              bottom: 14,
                            ),
                            padding:
                                const EdgeInsets.all(
                              16,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.pink.shade50
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius.circular(
                                22,
                              ),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.pink
                                    : Colors.grey
                                        .shade300,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets
                                          .all(12),
                                  decoration:
                                      BoxDecoration(
                                    color: option
                                        .iconBackgroundColor,
                                    shape:
                                        BoxShape.circle,
                                  ),
                                  child: Icon(
                                    option.icon,
                                  ),
                                ),
        
                                const SizedBox(
                                  width: 16,
                                ),
        
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      Text(
                                        option.label,
                                        style:
                                            const TextStyle(
                                          fontWeight:
                                              FontWeight
                                                  .w600,
                                                  color:  Color(0xFF1A1A2E),
                                        ),
                                      ),
        
                                      const SizedBox(
                                        height: 4,
                                      ),
        
                                      Text(
                                        option
                                            .description,
                                        style:
                                            TextStyle(
                                          color: Colors
                                              .grey
                                              .shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
        
                                AnimatedOpacity(
                                  opacity:
                                      isSelected
                                          ? 1
                                          : 0,
                                  duration:
                                      const Duration(
                                    milliseconds:
                                        250,
                                  ),
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Colors.pink,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}