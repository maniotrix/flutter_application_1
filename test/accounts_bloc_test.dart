import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_application_1/repositories/accounts.dart';
import 'package:flutter_application_1/screens/accounts/accounts_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountsRepository extends Mock implements AccountsRepository {}

void main() {
  group('AccountsBloc', () {
    late AccountsBloc accountsBloc;
    late MockAccountsRepository mockAccountsRepository;

    setUp(() {
      mockAccountsRepository = MockAccountsRepository();
      accountsBloc = AccountsBloc();
    });

    tearDown(() {
      accountsBloc.close();
    });

    test('initial state should be AccountsInitialState', () {
      expect(accountsBloc.state, equals(AccountsInitial()));
    });

    blocTest<AccountsBloc, AccountsState>(
      'emits [AccountsLoadedState] when AccountsNavigatedEvent is added',
      build: () {
        when(mockAccountsRepository.getAccountsData).thenAnswer((_) async {
          final response = Future.value(getResult());
          return response;
        });
        return accountsBloc;
      },
      act: (bloc) => bloc.add(AccountsNavigatedEvent()),
      wait: const Duration(milliseconds: 2000),
      expect: () => [
        AccountsLoadingState(),
        AccountsLoadedState(
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

  result.data = accountsData;
  return result;
}

const accountsData = {
  "accounts": [
    {
      "id": "bd379b58-c519-4a3f-b19f-6abe570bd9ea",
      "accountNumber": "3341068961",
      "accountType": "Savings",
      "balance": 4189.17,
      "accountHolder": "Alyson Price"
    },
    {
      "id": "fd29c9b9-ac91-40b6-bfde-8214d6eca67f",
      "accountNumber": "2047987159",
      "accountType": "Savings",
      "balance": 4957.34,
      "accountHolder": "Odell Collins"
    },
    {
      "id": "6d88b417-4bc3-4abe-b2dc-798b4d3d6509",
      "accountNumber": "4877701195",
      "accountType": "Checking",
      "balance": 6119.94,
      "accountHolder": "Jaycee Ernser"
    },
    {
      "id": "61342739-d869-4047-b5a0-27752ac9b989",
      "accountNumber": "6800936723",
      "accountType": "Savings",
      "balance": 9970.01,
      "accountHolder": "Rubie Prohaska"
    },
    {
      "id": "4540155b-df4c-427b-803d-f4c5e97e7152",
      "accountNumber": "3135735335",
      "accountType": "Savings",
      "balance": 1672.15,
      "accountHolder": "Bulah Ryan"
    },
    {
      "id": "9d869ebf-daec-48ab-a5fb-37bbbda436dd",
      "accountNumber": "5680832993",
      "accountType": "Checking",
      "balance": 73.12,
      "accountHolder": "Juliet Leuschke"
    },
    {
      "id": "0c885242-ad04-498d-a46c-4631d5f372dd",
      "accountNumber": "7342795832",
      "accountType": "Savings",
      "balance": 9741.78,
      "accountHolder": "Marianna Hahn"
    },
    {
      "id": "845350a4-5120-40fc-acfb-51eedd9c01cc",
      "accountNumber": "8501474306",
      "accountType": "Savings",
      "balance": 1613.04,
      "accountHolder": "Daphne Zemlak"
    },
    {
      "id": "a098ee2e-4aed-45ba-b4b8-203e811d0e5c",
      "accountNumber": "4995575575",
      "accountType": "Savings",
      "balance": 7313.92,
      "accountHolder": "Antonia Schoen"
    },
    {
      "id": "b51440e1-1514-4f4c-a06e-22363ec87183",
      "accountNumber": "2682054418",
      "accountType": "Savings",
      "balance": 5685.28,
      "accountHolder": "Cale Runte"
    }
  ]
};
