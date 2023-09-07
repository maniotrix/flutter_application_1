import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Architecture demo'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeLoadedState) {
            final result = state.result;
            return ListView.builder(
              itemCount: result.data?.length,
              itemBuilder: (context, index) {
                print(result.data);
                final homeData = result.data?['home'];
                return ListTile(
                  key: Key(homeData['accountNumber']),
                  title: Text(homeData['name']),
                  subtitle: Text('Account No: ${homeData['accountNumber']}'),
                );
              },
            );
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
