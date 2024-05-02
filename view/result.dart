import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? mobile_number;

Future<String?> getMobileNumber() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('mobile_number');
}

class ResultPage extends StatefulWidget {
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Future<void> retrieveData() async {
    mobile_number = await getMobileNumber();
    print(mobile_number);
  }

  Future<void> initializeData() async {
    await retrieveData();
    print("mobile number is $mobile_number");
  }

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Results'),
      ),
      body: TestResultsList(),
    );
  }
}

class TestResultsList extends StatefulWidget {
  @override
  State<TestResultsList> createState() => _TestResultsListState();
}

class _TestResultsListState extends State<TestResultsList> {
  late Stream<QuerySnapshot> _examsStream;

  @override
  void initState() {
    super.initState();
    _examsStream = FirebaseFirestore.instance
        .collection('users')
        .doc('students')
        .collection('students')
        .doc(mobile_number)
        .collection('exams')
        .orderBy('date', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _examsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading....');
          default:
            // Get the list of documents
            List<DocumentSnapshot> docs = snapshot.data!.docs;

            // Map each document to a map containing the document and its parsed date
            List<Map<String, dynamic>> sortedExamDataList = docs.map((examDoc) {
              DateTime date = DateFormat('dd MM yyyy').parse(examDoc['date']);

              return {
                'examDoc': examDoc,
                'date': date,
              };
            }).toList();

            // Sort the list of maps based on the parsed date
            sortedExamDataList.sort((a, b) => (b['date']).compareTo(a['date']));

            // Return the ListView with sorted data
            return ListView.builder(
              itemCount: sortedExamDataList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot examDoc = sortedExamDataList[index]['examDoc'];
                DateTime date = sortedExamDataList[index]['date'];

                return ListTile(
                  title: Text(examDoc['subject']),
                  subtitle: Text(
                    'Marks: ${examDoc['marks']} / ${examDoc['total']}',
                  ),
                  trailing: Text(DateFormat('dd/MM/yyyy')
                      .format(date)), // Use formatted date here
                );
              },
            );
        }
      },
    );
  }
}
