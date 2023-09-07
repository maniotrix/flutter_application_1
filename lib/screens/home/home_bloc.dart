import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/repositories/home.dart';

import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc(
    super.initialState, {
    required this.homeRepository,
  });

  @override
  get initialState => HomeInitialState();

  @override
  Stream<HomeState> mapEventToState(event) async* {
    if (event is HomeLoadEvent) {
      try {
        yield HomeLoadingState();
        final posts = await homeRepository.getHomeData();
        yield HomeLoadedState(
          result: posts,
        );
      } catch (error) {
        yield HomeErrorState();
      }
    }
  }
}
