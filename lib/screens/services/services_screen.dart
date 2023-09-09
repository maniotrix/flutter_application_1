import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final services = ['Loans', 'Statements', 'Contacts'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Services")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: services.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  handleCardsOnTap(index, context);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                        leading: const Icon(Icons.list),
                        trailing: const Icon(Icons.arrow_forward),
                        title: Text(services[index])),
                  ),
                ),
              );
            }),
      ),
    );
  }

  void handleCardsOnTap(int index, BuildContext context) {
    if (index == 0) {
      const snackBar = SnackBar(
        content: Text(
          'Loans not found!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (index == 1) {
    } else {
      context.go('/services/contacts');
    }
  }
}
