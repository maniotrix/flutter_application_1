import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/services/statements/statements_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class StatementsScreen extends StatefulWidget {
  const StatementsScreen({Key? key}) : super(key: key);

  @override
  State<StatementsScreen> createState() => _StatementsScreenState();
}

class _StatementsScreenState extends State<StatementsScreen> {
  Set<int> dropDownValues = {};
  List<dynamic> filterdStatements = [];

  int selectedYear = 0;

  QueryResult? queryResult;

  formatDates(String date) {
    final elements = date.split('-');
    if (elements[1].length < 2) {
      elements[1] = '0${elements[1]}';
    }
    if (elements[2].length < 2) {
      elements[2] = '0${elements[2]}';
    }

    return elements.join();
  }

  setDropDownData() {
    final data = queryResult!.data?['statements'] as List;
    for (var statement in data) {
      String date = statement['date'];
      var parsedDate = DateTime.parse(formatDates(date));
      dropDownValues.add(parsedDate.year);
    }

    List<int> values = dropDownValues.toList();
    values.sort();
    dropDownValues = values.reversed.toSet();
  }

  setFilteredStatements(int year) {
    final data = queryResult!.data?['statements'] as List;
    for (var statement in data) {
      String date = statement['date'];
      var parsedDate = DateTime.parse(formatDates(date));
      if (parsedDate.year == year) {
        filterdStatements.add(statement);
      }
    }
    filterdStatements.sort(
      (a, b) {
        var dateA = DateTime.parse(formatDates(a['date']));
        var dateB = DateTime.parse(formatDates(b['date']));
        return dateA.compareTo(dateB);
      },
    );
  }

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
        title: const Text('Statements'),
      ),
      body: BlocBuilder<StatementsBloc, StatementsState>(
        builder: (context, state) {
          if (state is StatementsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StatementsLoadedState) {
            queryResult = state.result;
            if (dropDownValues.isEmpty) {
              setDropDownData();
              selectedYear = dropDownValues.first;
            }
            setFilteredStatements(selectedYear);
            return Column(
              children: [
                DropdownButton<int>(
                  value: selectedYear,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (int? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      selectedYear = value!;
                      filterdStatements.clear();
                    });
                  },
                  items: dropDownValues.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filterdStatements.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            context.go('/services/statements/pdf');
                          },
                          child: Card(
                            child: ListTile(
                              title:
                                  Text(filterdStatements[index]['description']),
                              leading: Text(filterdStatements[index]['date']),
                              trailing: Text(
                                  '\$${(filterdStatements[index]['amount'] as double).toStringAsFixed(2)}'),
                            ),
                          ),
                        ), /*  */
                      );
                    },
                  ),
                ),
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
