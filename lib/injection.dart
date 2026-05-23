import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:tere_mood/core/data/data_source/mood_datasource.dart';
import 'package:tere_mood/core/data/data_source/mood_dummy_datasource.dart';
import 'package:tere_mood/core/data/repository/mood_repository_impl.dart';
import 'package:tere_mood/core/domain/repository/mood_repository.dart';

final sl = GetIt.instance;

Future<void> initInjection() async {

  /// CHANGE THIS
  //const useFirebase = true;

  // if (useFirebase) {
  //   sl.registerLazySingleton<MoodDataSource>(
  //     () => MoodFirestoreDataSource(
  //       FirebaseFirestore.instance,
  //     ),
  //   );
  // } else {
  //   sl.registerLazySingleton<MoodDataSource>(
  //     () => MoodDummyDataSource(),
  //   );
  // }

  sl.registerLazySingleton<MoodDataSource>(
      () => MoodDummyDataSource(),
    );

  sl.registerLazySingleton<MoodRepository>(
    () => MoodRepositoryImpl(
      sl(),
    ),
  );
}