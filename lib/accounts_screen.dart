import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootAccountsScreen extends StatefulWidget {
  const RootAccountsScreen({Key? key}) : super(key: key);

  @override
  State<RootAccountsScreen> createState() => _RootAccountsScreenState();
}

class _RootAccountsScreenState extends State<RootAccountsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Screen Accounts',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () => context.go('/accounts/transactions'),
              child: const Text('View Transactions'),
            ),
          ],
        ),
      ),
    );
  }
}
