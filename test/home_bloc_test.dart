import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_application_1/repositories/home.dart';
import 'package:flutter_application_1/screens/home/home_bloc.dart';
import 'package:flutter_application_1/screens/home/home_event.dart';
import 'package:flutter_application_1/screens/home/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

@GenerateMocks([MockHomeRepository])
void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;
    late MockHomeRepository mockHomeRepository;

    setUp(() {
      mockHomeRepository = MockHomeRepository();
      homeBloc = HomeBloc();
    });

    tearDown(() {
      homeBloc.close();
    });

    test('initial state should be HomeInitialState', () {
      expect(homeBloc.state, equals(HomeInitialState()));
    });

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoadedState] when HomeNavigatedEvent is added',
      build: () {
        when(mockHomeRepository.getHomeData()).thenAnswer((_) async {
          final response = Future.value(getResult());
          return response;
        });
        return homeBloc;
      },
      act: (bloc) => bloc.add(HomeNavigatedEvent()),
      expect: () => [
        HomeInitialState(),
        HomeLoadingState(),
        HomeLoadedState(
          result: getResult(),
        )
      ],
    );
  });
}

QueryResult<Object?> getResult() {
  final result = QueryResult(
      options: QueryOptions(document: gql('')),
      source: QueryResultSource.cache);

  result.data = homeData;
  print(result);
  return result;
}

const homeData = {
  "home": {
    "name": "John Doe",
    "accountNumber": "1234567890",
    "balance": 2500.5,
    "currency": "USD",
    "address": {
      "streetName": "Kevon Street",
      "buildingNumber": "590",
      "townName": "South Camilla",
      "postCode": "23458",
      "country": "Guadeloupe"
    },
    "recentTransactions": [
      {
        "date": "2023-07-15",
        "description": "Online Shopping",
        "amount": -150,
        "fromAccount": "Checking",
        "toAccount": "Cash"
      },
      {
        "date": "2023-07-14",
        "description": "Deposit",
        "amount": 1000,
        "fromAccount": "Checking",
        "toAccount": "Cash"
      },
      {
        "date": "2023-07-12",
        "description": "ATM Withdrawal",
        "amount": -200,
        "fromAccount": "Checking",
        "toAccount": "Merchant"
      }
    ],
    "upcomingBills": [
      {
        "date": "2023-07-20",
        "description": "Electricity Bill",
        "amount": 75.5,
        "fromAccount": "Savings",
        "toAccount": "Merchant"
      },
      {
        "date": "2023-07-28",
        "description": "Phone Bill",
        "amount": 45,
        "fromAccount": "Checking",
        "toAccount": "External"
      }
    ]
  }
};
