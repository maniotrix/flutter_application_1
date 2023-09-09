part of 'transactions_bloc.dart';

sealed class TransactionsState extends Equatable {
  const TransactionsState();
  
  @override
  List<Object> get props => [];
}

final class TransactionsInitial extends TransactionsState {}
class TransactionsInitialState extends TransactionsState {}

class TransactionsLoadingState extends TransactionsState {}

class TransactionsLoadedState extends TransactionsState {
  final QueryResult result;
  const TransactionsLoadedState({
    required this.result,
  });
}

class TransactionsErrorState extends TransactionsState {}