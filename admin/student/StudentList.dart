import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kartavya_education_hub/const/consts.dart';

import 'StudentForm.dart';

class StudentList extends StatefulWidget {
  final String standard;

  const StudentList({Key? key, required this.standard}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: Column(
        children: [
          Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc('students')
                  .collection('students')
                  // for filter use
                  .where('class', isEqualTo: widget.standard)
                  .orderBy('roll_number')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Access the document snapshot at this index
                      DocumentSnapshot document = snapshot.data!.docs[index];
                      // Extract data from document snapshot
                      String itemName = document['name'];
                      String rollNumber = document['roll_number'];
                      // Return a list tile for the item
                      return ListTile(
                        title: Text(itemName),
                        subtitle: Text('Roll Number: $rollNumber'),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(color: Colors.brown),
        child: Center(
            child: Text(
          'Add New Student',
          style: TextStyle(color: Colors.white, fontSize: 18),
        )),
      ).onTap(() {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return StudentForm(standard: widget.standard);
          },
        );
      }),
    );
  }
}
