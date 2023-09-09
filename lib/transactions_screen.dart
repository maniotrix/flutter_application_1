// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/accounts/accounts_screen.dart';
import 'package:flutter_application_1/screens/transactions/transactions_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsScreen extends StatefulWidget {
  dynamic arguments;
  TransactionsScreen({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  dynamic accounts;

  @override
  void initState() {
    super.initState();
    setAccountsData();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<TransactionsBloc>().add(TransactionsNavigatedEvent());
    });
  }

  setAccountsData() {
    /* final data =
        (widget.arguments as AccountsParameters).accountsData['accountHolder']; */
    final data = widget.arguments;
    if (data == null) {
    } else {
      accounts = (widget.arguments as AccountsParameters).accountsData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts - Transactions'),
      ),
      body: Column(
        children: <Widget>[
          Text('Details for Transactions : ${accounts['accountHolder']}',
              style: Theme.of(context).textTheme.titleLarge),
          Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              labelPadding: const EdgeInsets.only(left: 20, right: 20),
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: const [
                Tab(
                  text: 'Transactions',
                ),
                Tab(
                  text: 'Details',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: BlocBuilder<TransactionsBloc, TransactionsState>(
                    builder: (context, state) {
                      if (state is TransactionsLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TransactionsLoadedState) {
                        final result = state.result;
                        final transactionsData = result.data?['transactions'];
                        return ListView.builder(
                          itemCount: transactionsData.length,
                          itemBuilder: (context, index) {
                            print(result.data);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Text(
                                    transactionsData[index]['description']),
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
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              accounts['accountHolder'],
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              'Account No: ${accounts['accountNumber']}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Balance: ${accounts['balance']} USD}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
