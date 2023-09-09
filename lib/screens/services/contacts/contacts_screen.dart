import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/services/contacts/contacts_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ContactsBloc>().add(ContactsNavigatedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts Screen'),
      ),
      body: BlocBuilder<ContactsBloc, ContactsState>(
        builder: (context, state) {
          if (state is ContactsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ContactsLoadedState) {
            final result = state.result;
            final contactsData = result.data?['contacts'];
            return ListView.builder(
              itemCount: contactsData.length,
              itemBuilder: (context, index) {
                print(result.data);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(contactsData[index]['name']),
                );
              },
            );
          } else if (state is ContactsErrorState) {
            return Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Could not load Contacts', style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.red),),
                  ),
                ),
                const SizedBox(height: 40,),
                Text('Message: ${state.error.graphqlErrors.first.message}', style: Theme.of(context).textTheme.bodyLarge,),
                Text('Error Code: ${state.error.graphqlErrors.first.extensions!['code']}', style: Theme.of(context).textTheme.bodyLarge,),
              ],
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
