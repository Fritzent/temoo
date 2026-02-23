part of 'starter_bloc.dart';

class StarterPageState extends Equatable {
  const StarterPageState({
    this.status = ListeningStatus.idle,
    this.isHeartFilled = false,
    this.greetingMessage = '',
    this.subtitleMessage = '',
  });

  final ListeningStatus status;
  final bool isHeartFilled;
  final String greetingMessage;
  final String subtitleMessage;

  StarterPageState copyWith({
    ListeningStatus? status,
    bool? isHeartFilled,
    String? greetingMessage,
    String? subtitleMessage,
  }) {
    return StarterPageState(
      status: status ?? this.status,
      isHeartFilled: isHeartFilled ?? this.isHeartFilled,
      greetingMessage: greetingMessage ?? this.greetingMessage,
      subtitleMessage: subtitleMessage ?? this.subtitleMessage,
    );
  }

  @override
  List<Object> get props =>
      [status, isHeartFilled, greetingMessage, subtitleMessage];
}
