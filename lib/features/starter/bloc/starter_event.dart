part of 'starter_bloc.dart';

abstract class StarterPageEvent extends Equatable {
  const StarterPageEvent();

  @override
  List<Object> get props => [];
}

class StarterPageEventSetup extends StarterPageEvent {
  final String greetingMessage;
  final String subtitleMessage;

  const StarterPageEventSetup({
    this.greetingMessage = '',
    this.subtitleMessage = '',
  });
}

class StarterPageEventCheckIn extends StarterPageEvent {
  final String greetingMessage;
  final String subtitleMessage;

  const StarterPageEventCheckIn({
    this.greetingMessage = '',
    this.subtitleMessage = '',
  });
}

class StarterPageEventReset extends StarterPageEvent {
  const StarterPageEventReset();
}

class StarterPageEventHeartTapped extends StarterPageEvent {
  final BuildContext context;
  final AppLocalizations appLocalizations;

  const StarterPageEventHeartTapped({
    required this.context,
    required this.appLocalizations,
  });
}
