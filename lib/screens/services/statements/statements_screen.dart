import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/services/statements/statements_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class StatementsScreen extends StatefulWidget {
  const StatementsScreen({Key? key}) : super(key: key);

  @override
  State<StatementsScreen> createState() => _StatementsScreenState();
}

class _StatementsScreenState extends State<StatementsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<StatementsBloc>().add(StatementsNavigatedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statements Screen'),
      ),
      body: BlocBuilder<StatementsBloc, StatementsState>(
        builder: (context, state) {
          if (state is StatementsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StatementsLoadedState) {
            final result = state.result;
            final statementsData = result.data?['statements'];
            return ListView.builder(
              itemCount: statementsData.length,
              itemBuilder: (context, index) {
                print(result.data);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      context.go('/services/statements/pdf');
                    },
                    child: Card(
                      child: Text(statementsData[index]['description']),
                    ),
                  ), /*  */
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

