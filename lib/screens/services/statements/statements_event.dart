part of 'statements_bloc.dart';

sealed class StatementsEvent extends Equatable {
  const StatementsEvent();

  @override
  List<Object> get props => [];
}

final class StatementsNavigatedEvent extends StatementsEvent {}
