import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../const/consts.dart';

class AddMarks extends StatefulWidget {
  final String selectedClass;
  final String selectedDate;
  final String subject;

  const AddMarks({
    Key? key,
    required this.selectedClass,
    required this.selectedDate,
    required this.subject,
  }) : super(key: key);

  @override
  State<AddMarks> createState() => _AddMarksState();
}

class _AddMarksState extends State<AddMarks> {
  late List<DocumentSnapshot> students;
  late List<FocusNode> focusNodes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  void _loadStudents() {
    FirebaseFirestore.instance
        .collection('users')
        .doc('students')
        .collection('students')
        .where('class', isEqualTo: widget.selectedClass)
        .orderBy('roll_number')
        .get()
        .then((snapshot) {
      setState(() {
        students = snapshot.docs;
        _initializeFocusNodes();
        _isLoading = false;
      });
    }).catchError((error) {
      print("Failed to load students: $error");
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _initializeFocusNodes() {
    focusNodes = List.generate(students.length, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Marks',
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: EdgeInsets.all(8.0),
                //   child: Text(
                //     'Student Details',
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 18.0,
                //     ),
                //   ),
                // ),
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Roll Number',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Marks',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(student['roll_number']),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(student['name']),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                focusNode: focusNodes[index],
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    // labelText: 'Marks',
                                    ),
                                onFieldSubmitted: (value) {
                                  if (index < focusNodes.length - 1) {
                                    FocusScope.of(context)
                                        .requestFocus(focusNodes[index + 1]);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
