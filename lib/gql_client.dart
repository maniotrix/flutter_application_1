import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink _httpLink = HttpLink(
  'http://192.168.1.13:4000/',
);

final Link _link = _httpLink;

final GraphQLClient graphqlClient = GraphQLClient(
  cache: GraphQLCache(store: InMemoryStore()),
  link: _link,
);

ValueNotifier<GraphQLClient> gqlNotifierClient = ValueNotifier(
  graphqlClient,
);
