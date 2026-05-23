# temoo
Test



lib/
├── core/
│   ├── model/
│   │   ├── question.dart
│   │   └── question_option.dart
│   │
│   └── dummy/
│       └── dummy_question.dart
│
├── features/
│   └── mood/
│       ├── data/
│       │   ├── datasource/
│       │   │   ├── mood_datasource.dart
│       │   │   ├── mood_dummy_datasource.dart
│       │   │   └── mood_firestore_datasource.dart
│       │   │
│       │   └── repository/
│       │       └── mood_repository_impl.dart
│       │
│       ├── domain/
│       │   └── repository/
│       │       └── mood_repository.dart
│       │
│       └── presentation/
│           ├── bloc/
│           │   ├── mood_bloc.dart
│           │   ├── mood_event.dart
│           │   └── mood_state.dart
│           │
│           └── page/
│               └── mood_page.dart
│
├── injection.dart
└── main.dart