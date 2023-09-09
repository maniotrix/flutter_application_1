import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/gql_client.dart';
import 'package:flutter_application_1/repositories/accounts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc() : super(TransactionsInitial()) {
    on<TransactionsNavigatedEvent>((event, emit) async {
      emit(TransactionsLoadingState());
      await AccountsRepository(client: graphqlClient)
          .getTransactionsData()
          .then((value) {
        emit(TransactionsLoadedState(result: value));
      });
    });
  }
}
