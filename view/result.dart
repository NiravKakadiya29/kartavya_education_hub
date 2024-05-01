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

  late Stream<QuerySnapshot> _examsStream;

  @override
  void initState() {
    initializeData();
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
            Map<DateTime, List<DocumentSnapshot>> examsByDate = {};
            snapshot.data!.docs.forEach((examDoc) {
              String dateString = examDoc['date'];
              DateTime date = DateFormat('dd MMMM yyyy').parse(dateString);
              if (!examsByDate.containsKey(date)) {
                examsByDate[date] = [];
              }
              examsByDate[date]!.add(examDoc);
            });

            return ListView.builder(
              itemCount: examsByDate.keys.length,
              itemBuilder: (context, index) {
                DateTime date = examsByDate.keys.elementAt(index);
                List<DocumentSnapshot> exams = examsByDate[date]!;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${date.day}/${date.month}/${date.year}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...exams.map((examDoc) {
                      return Card(
                        child: ListTile(
                          title: Text(examDoc['subject']),
                          subtitle: Text(
                            'Marks: ${examDoc['marks']} / ${examDoc['total']}',
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
            );
        }
      },
    );
  }
}
