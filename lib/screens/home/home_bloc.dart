import 'package:flutter_application_1/gql_client.dart';
import 'package:flutter_application_1/repositories/home.dart';
import 'package:flutter_application_1/screens/home/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeNavigatedEvent>((event, emit) async {
      emit(HomeLoadingState());
      await HomeRepository(client: graphqlClient).getHomeData().then((value) {
        emit(HomeLoadedState(result: value));
      });
    });
  }
}
