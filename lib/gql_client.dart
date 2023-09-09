import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink _httpLink = HttpLink(
  'http://$Apollo_SandBox_IpAddress:4000/',
);

final Link _link = _httpLink;

final GraphQLClient graphqlClient = GraphQLClient(
  cache: GraphQLCache(store: InMemoryStore()),
  link: _link,
);

ValueNotifier<GraphQLClient> gqlNotifierClient = ValueNotifier(
  graphqlClient,
);
