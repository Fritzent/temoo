import 'package:flutter/material.dart';
import 'package:tere_mood/core/model/question.dart';
import 'package:tere_mood/core/model/question_option.dart';

class DummyQuestion {
  static List<Question> get questions => [
        Question(
          id: 'q1',
          question: 'Udah ada makan belum hari ini?',
          emoji: '🍕',
          description: 'harus ingat makan ya biar tetap semangat.',
          options: [
            QuestionOption(
              id: 'q1_a',
              label: "Iya sudah, keunyang buangetttt!",
              description: "gitu dong kan keren",
              icon: Icons.local_pizza_outlined,
              iconBackgroundColor: const Color(0xFFE2D1F9),
            ),
            QuestionOption(
              id: 'q1_b',
              label: 'Cuma ngemil aja sih hari ini',
              description: "harus tetap makan ya jgn ngemil doang loh",
              icon: Icons.icecream_rounded,
              iconBackgroundColor: const Color(0xFFF5B83D),
            ),
            QuestionOption(
              id: 'q1_c',
              label: 'Belum samsek...',
              description: "harus makan ya jgn samsek",
              icon: Icons.sentiment_dissatisfied_outlined,
              iconBackgroundColor: const Color(0xFFF49AC2),
            ),
          ],
        ),
        Question(
          id: 'q2',
          question: 'Udah ada minum juga kan hari ini?',
          emoji: '💧',
          description: 'inget minum bagus buat kesehatan tubuh loh.',
          options: [
            QuestionOption(
              id: 'q2_a',
              label: 'Udah Dong!',
              description: "Air putih 2 Liter",
              icon: Icons.water_drop,
              iconBackgroundColor: const Color(0xFFE2D1F9),
            ),
            QuestionOption(
              id: 'q2_b',
              label: 'Udah..',
              description: "Tapi kopi susu",
              icon: Icons.coffee,
              iconBackgroundColor: const Color(0xFFF5B83D),
            ),
            QuestionOption(
              id: 'q2_c',
              label: 'Belum samsek..',
              description: "inget minum please inget ntar sakit loh",
              icon: Icons.sentiment_dissatisfied_outlined,
              iconBackgroundColor: const Color(0xFFF49AC2),
            ),
          ],
        ),
        Question(
          id: 'q3',
          question: 'Kalau moodnya aman kah?',
          emoji: '💖',
          description: 'harus sesuai hatinya yak, pleasee...',
          options: [
            QuestionOption(
              id: 'q3_a',
              label: 'Happy Bangetttt!',
              description: "Mantap jiwa, semoga selalu happy yaa",
              icon: Icons.sentiment_very_satisfied_outlined,
              iconBackgroundColor: const Color(0xFFE2D1F9),
            ),
            QuestionOption(
              id: 'q3_b',
              label: 'Biasa aja sih',
              description: "Yah butuh moodbooster nih kyknya",
              icon: Icons.sentiment_neutral_outlined,
              iconBackgroundColor: const Color(0xFFF5B83D),
            ),
            QuestionOption(
              id: 'q3_c',
              label: 'Lagi nggak baikkkkkkk!!!!!!!',
              description: "iya iya cerita sini ada apa",
              icon: Icons.sentiment_dissatisfied_outlined,
              iconBackgroundColor: const Color(0xFFF49AC2),
            ),
          ],
        ),
      ];
}