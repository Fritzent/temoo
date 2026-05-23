// NANTI INI TINGGAL DI UNCOMMENT KALAU MAU IMPLEMENT FIRESTORE

// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../../../../core/model/question.dart';
// import '../../../../core/model/question_option.dart';
// import 'mood_datasource.dart';

// class MoodFirestoreDataSource implements MoodDataSource {
//   final FirebaseFirestore firestore;

//   MoodFirestoreDataSource(this.firestore);

//   @override
//   Future<List<Question>> getQuestions() async {
//     final snapshot =
//         await firestore.collection('questions').get();

//     return snapshot.docs.map((doc) {
//       final data = doc.data();

//       return Question(
//         id: doc.id,
//         question: data['question'],
//         emoji: data['emoji'],
//         description: data['description'],
//         options: (data['options'] as List)
//             .map(
//               (e) => QuestionOption(
//                 id: e['id'],
//                 label: e['label'],
//                 description: e['description'],
//                 icon: Icons.favorite,
//                 iconBackgroundColor: Colors.pink.shade100,
//               ),
//             )
//             .toList(),
//       );
//     }).toList();
//   }
// }