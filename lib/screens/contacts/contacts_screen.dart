import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/accounts/accounts_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RootAccountsScreen extends StatefulWidget {
  const RootAccountsScreen({Key? key}) : super(key: key);

  @override
  State<RootAccountsScreen> createState() => _RootAccountsScreenState();
}

class _RootAccountsScreenState extends State<RootAccountsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AccountsBloc>().add(AccountsNavigatedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts Screen'),
      ),
      body: BlocBuilder<AccountsBloc, AccountsState>(
        builder: (context, state) {
          if (state is AccountsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AccountsLoadedState) {
            final result = state.result;
            final accountsData = result.data?['accounts'];
            return ListView.builder(
              itemCount: accountsData.length,
              itemBuilder: (context, index) {
                print(result.data);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      context.go('/accounts/transactions',
                          extra:
                              AccountsParameters(accountsData: accountsData[index]));
                    },
                    child: Card(
                      child: Text(accountsData[index]['accountHolder']),
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

class AccountsParameters {
  final dynamic accountsData;

  AccountsParameters({required this.accountsData});
}
