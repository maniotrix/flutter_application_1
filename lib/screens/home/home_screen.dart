import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/screens/home/bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeBloc>().add(HomeNavigatedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
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
                      homeData['name'],
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      'Account No: ${homeData['accountNumber']}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'Balance: ${homeData['balance']} ${homeData['currency']}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              )),
            );
            /* return ListView.builder(
              itemCount: homeData.length,
              itemBuilder: (context, index) {
                print(result.data);
                return ListTile(
                  key: Key(homeData['accountNumber']),
                  title: Text(homeData['name']),
                  subtitle: Text('Account No: ${homeData['accountNumber']}'),
                );
              },
            ); */
          } else {
            return const Center(
              child: Text('You have an error'),
            );
          }
        },
      ),
    );
  }
}
