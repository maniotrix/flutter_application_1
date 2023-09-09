part of 'statements_bloc.dart';

sealed class StatementsState extends Equatable {
  const StatementsState();
  
  @override
  List<Object> get props => [];
}

final class StatementsInitial extends StatementsState {}
class StatementsInitialState extends StatementsState {}

class StatementsLoadingState extends StatementsState {}

class StatementsLoadedState extends StatementsState {
  final QueryResult result;
  const StatementsLoadedState({
    required this.result,
  });
}

class StatementsErrorState extends StatementsState {}