import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/screens/home/bloc.dart';

class HomeScreen extends StatefulWidget {
  String arguments;
  HomeScreen({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';

  @override
  void initState() {
    super.initState();
    setUserData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeBloc>().add(HomeNavigatedEvent());
    });
  }

  setUserData() {
    final data = widget.arguments;
    if (data.isEmpty) {
    } else {
      username = widget.arguments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              ' Welcome Back, $username',
              style: Theme.of(context).textTheme.headlineMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HomeLoadedState) {
                final result = state.result;
                final homeData = result.data?['home'];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Name: ${homeData['name']}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          'Account No: ${homeData['accountNumber']}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          'Balance: ${homeData['balance']} ${homeData['currency']}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          'Recent Transactions: ${(homeData['recentTransactions'] as List).length}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          'upcomingBills: ${(homeData['upcomingBills'] as List).length}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  )),
                );
              } else {
                return const Center(
                  child: Text('You have an error'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
