import 'package:graphql_flutter/graphql_flutter.dart';

class ServiceRepository {
  final GraphQLClient client;

  ServiceRepository({
    required this.client,
  });

  Future<QueryResult> getContactsData() async {
    const String query = r'''
                          query getContacts {
                                  contacts
                                }''';
    final results = await client.query(
      QueryOptions(
        document: gql(query),
      ),
    );
    print(results);
    if (results.hasException) {
      return Future.error(results.exception!);
    } else {
      return results;
    }
  }

  Future<QueryResult> getStatementsData() async {
    const String query = r'''
                          query getStatements {
                                  statements {
                                    date
                                    description
                                    amount
                                  }
                                }''';
    final results = await client.query(
      QueryOptions(
        document: gql(query),
      ),
    );
    print(results);
    if (results.hasException) {
      return Future.error('Statements Result Exception');
    } else {
      return results;
    }
  }
}
