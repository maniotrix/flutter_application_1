import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final QueryResult result;
  const HomeLoadedState({
    required this.result,
  });
}

class HomeErrorState extends HomeState {}
