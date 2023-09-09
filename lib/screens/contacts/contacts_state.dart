part of 'contacts_bloc.dart';

sealed class ContactsState extends Equatable {
  const ContactsState();
  
  @override
  List<Object> get props => [];
}

final class ContactsInitial extends ContactsState {}
class ContactsInitialState extends ContactsState {}

class ContactsLoadingState extends ContactsState {}

class ContactsLoadedState extends ContactsState {
  final QueryResult result;
  const ContactsLoadedState({
    required this.result,
  });
}

class ContactsErrorState extends ContactsState {}