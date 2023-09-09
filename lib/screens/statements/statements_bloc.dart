import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/gql_client.dart';
import 'package:flutter_application_1/repositories/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'statements_event.dart';
part 'statements_state.dart';

class StatementsBloc extends Bloc<StatementsEvent, StatementsState> {
  StatementsBloc() : super(StatementsInitial()) {
    on<StatementsNavigatedEvent>((event, emit) async {
      emit(StatementsLoadingState());
      await ServiceRepository(client: graphqlClient)
          .getStatementsData()
          .then((value) {
        emit(StatementsLoadedState(result: value));
      });
    });
  }
}
