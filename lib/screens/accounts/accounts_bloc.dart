import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/gql_client.dart';
import 'package:flutter_application_1/repositories/accounts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc() : super(AccountsInitial()) {
    on<AccountsNavigatedEvent>((event, emit) async {
      emit(AccountsLoadingState());
      await AccountsRepository(client: graphqlClient)
          .getAccountsData()
          .then((value) {
        emit(AccountsLoadedState(result: value));
      });
    });
  }
}
