import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/gql_client.dart';
import 'package:flutter_application_1/repositories/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsInitial()) {
    on<ContactsNavigatedEvent>((event, emit) async {
      emit(ContactsLoadingState());
      await ServiceRepository(client: graphqlClient)
          .getContactsData()
          .then((value) {
        emit(ContactsLoadedState(result: value));
      }).onError((error, stackTrace) {
        emit(ContactsErrorState(error: error! as OperationException));
      });
    });
  }
}
