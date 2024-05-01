import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot examDoc = snapshot.data!.docs[index];
                return Card(
                  child: ListTile(
                    title: Text(examDoc['subject']),
                    subtitle: Text(
                      'Marks: ${examDoc['marks']} / ${examDoc['total']}',
                    ),
                    trailing: Text(examDoc['date'].toString()),
                  ),
                );
              },
            );
        }
      },
    );
  }
}
