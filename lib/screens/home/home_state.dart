import 'package:graphql_flutter/graphql_flutter.dart';

class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final QueryResult result;
  HomeLoadedState({
    required this.result,
  });
}

class HomeErrorState extends HomeState {}
