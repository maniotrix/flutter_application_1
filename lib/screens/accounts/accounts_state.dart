part of 'accounts_bloc.dart';

sealed class AccountsState extends Equatable {
  const AccountsState();
  
  @override
  List<Object> get props => [];
}

final class AccountsInitial extends AccountsState {}
class AccountsInitialState extends AccountsState {}

class AccountsLoadingState extends AccountsState {}

class AccountsLoadedState extends AccountsState {
  final QueryResult result;
  const AccountsLoadedState({
    required this.result,
  });
}

class AccountsErrorState extends AccountsState {}