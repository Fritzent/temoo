import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tere_mood/core/enum/listening_enum.dart';
import 'package:tere_mood/core/enum/snackbar_enum.dart';
import 'package:tere_mood/core/widget/snackbar_lovely_widget.dart';
import 'package:tere_mood/l10n/app_localizations.dart';

part 'starter_event.dart';
part 'starter_state.dart';

class StarterPageBloc extends Bloc<StarterPageEvent, StarterPageState> {
  StarterPageBloc() : super(const StarterPageState()) {
    on<StarterPageEventSetup>(_onSetup);
    on<StarterPageEventCheckIn>(_onStartCheckIn);
    on<StarterPageEventReset>(_onReset);
    on<StarterPageEventHeartTapped>(_onHeartTapped);
  }

  void _onSetup(StarterPageEventSetup event, Emitter<StarterPageState> emit) {
    emit(state.copyWith(
      status: ListeningStatus.listening,
      greetingMessage: event.greetingMessage,
      subtitleMessage: event.subtitleMessage,
    ));
  }

  void _onStartCheckIn(StarterPageEventCheckIn event, Emitter<StarterPageState> emit) {
    emit(state.copyWith(
      status: ListeningStatus.checkingIn,
      greetingMessage: event.greetingMessage,
      subtitleMessage: event.subtitleMessage,
    ));
  }

  void _onReset(StarterPageEventReset event, Emitter<StarterPageState> emit) {
    emit(const StarterPageState());
  }

  void _onHeartTapped(StarterPageEventHeartTapped event, Emitter<StarterPageState> emit) {
    emit(state.copyWith(isHeartFilled: !state.isHeartFilled));
    if (state.isHeartFilled) {
      event.context.showAvatarSnackBar(
        message: event.appLocalizations.textHappyYouLiked,
        type: AvatarSnackBarType.lovely,
      );
    } else {
      event.context.showAvatarSnackBar(
        message: event.appLocalizations.textSadNotLiked,
        type: AvatarSnackBarType.sad,
      );
    }
  }
}
