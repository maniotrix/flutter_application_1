import 'package:graphql_flutter/graphql_flutter.dart';

class HomeRepository {
  final GraphQLClient client;

  HomeRepository({
    required this.client,
  });

  Future<QueryResult> getHomeData() async {
    const String query = r'''
                          query getHome {
                                    home {
                                      name
                                      accountNumber
                                      balance
                                      currency
                                      address {
                                        streetName
                                        buildingNumber
                                        townName
                                        postCode
                                        country
                                      }
                                      recentTransactions {
                                        date
                                        description
                                        amount
                                        fromAccount
                                        toAccount
                                      }
                                      upcomingBills {
                                        date
                                        description
                                        amount
                                        fromAccount
                                        toAccount
                                      }
                                    }
                                  }''';
    final results = await client.query(
      QueryOptions(
        document: gql(query),
      ),
    );
    //print(results);
    if (results.hasException) {
      return Future.error('Home Result Exception');
    } else {
      return results;
    }
  }
}
