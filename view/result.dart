import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? mobileNumber;

Future<String?> getMobileNumber() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('mobile_number');
}

class ResultPage extends StatefulWidget {
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Results'),
      ),
      body: FutureBuilder<String?>(
        future: getMobileNumber(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            return TestResultsList(mobileNumber: snapshot.data!);
          } else {
            return Center(
              child: Text('No mobile number found!'),
            );
          }
        },
      ),
    );
  }
}

class TestResultsList extends StatefulWidget {
  final String mobileNumber;

  TestResultsList({required this.mobileNumber});

  @override
  State<TestResultsList> createState() => _TestResultsListState();
}

class _TestResultsListState extends State<TestResultsList> {
  late Stream<QuerySnapshot> _examsStream;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    setState(() {
      _examsStream = FirebaseFirestore.instance
          .collection('users')
          .doc('students')
          .collection('students')
          .doc(widget.mobileNumber)
          .collection('exams')
          .orderBy('date', descending: true)
          .snapshots();
    });
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
            return Center(
              child: Text(
                'Loading....',
                style: TextStyle(fontSize: 20, letterSpacing: 5),
              ),
            );
          default:
            List<DocumentSnapshot> docs = snapshot.data!.docs;
            List<Map<String, dynamic>> sortedExamDataList = docs.map((examDoc) {
              DateTime date = DateFormat('dd MM yyyy').parse(examDoc['date']);

              return {
                'examDoc': examDoc,
                'date': date,
              };
            }).toList();

            sortedExamDataList.sort((a, b) => (b['date']).compareTo(a['date']));

            return ListView.builder(
              itemCount: sortedExamDataList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot examDoc = sortedExamDataList[index]['examDoc'];
                DateTime date = sortedExamDataList[index]['date'];

                return Card(
                  child: ListTile(
                    title: Text(examDoc['subject']),
                    subtitle: Text(
                      'Marks: ${examDoc['marks']} / ${examDoc['total']}',
                    ),
                    trailing: Text(DateFormat('dd/MM/yyyy').format(date)),
                  ),
                );
              },
            );
        }
      },
    );
  }
}
