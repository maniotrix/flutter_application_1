import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
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
        title: const Text('Home Screen'),
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
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                    child: Center(
                  child: Column(
                    children: [
                      Text(homeData['name']),
                      Text('Account No: ${homeData['accountNumber']}')
                    ],
                  ),
                )),
              ),
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
