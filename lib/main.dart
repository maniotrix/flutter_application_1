import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:flutter_application_1/screens/accounts/accounts_bloc.dart';
import 'package:flutter_application_1/screens/accounts/transactions/transactions_bloc.dart';
import 'package:flutter_application_1/screens/home/bloc.dart';
import 'package:flutter_application_1/screens/services/contacts/contacts_bloc.dart';
import 'package:flutter_application_1/screens/services/statements/statements_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(
        'Graphql API Server Running at IP -  $Apollo_SandBox_IpAddress \n Please udpate the IP address as per your local network if stuck on loading.');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => AccountsBloc(),
        ),
        BlocProvider(
          create: (context) => TransactionsBloc(),
        ),
        BlocProvider(
          create: (context) => ContactsBloc(),
        ),
        BlocProvider(
          create: (context) => StatementsBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        routerConfig: goRouter,
      ),
    );
  }
}
