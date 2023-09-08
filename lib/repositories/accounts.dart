import 'package:graphql_flutter/graphql_flutter.dart';

class AccountsRepository {
  final GraphQLClient client;

  AccountsRepository({
    required this.client,
  });

  Future<QueryResult> getAccountsData() async {
    const String query = r'''
                          query getAccounts {
                                  accounts {
                                    id
                                    accountNumber
                                    accountType
                                    balance
                                    accountHolder
                                  }
                                }''';
    final results = await client.query(
      QueryOptions(
        document: gql(query),
      ),
    );
    print(results);
    if (results.hasException) {
      return Future.error('Accounts Result Exception');
    } else {
      return results;
    }
  }
}
