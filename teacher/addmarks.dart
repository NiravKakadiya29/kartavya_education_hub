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
  late List<TextEditingController> markControllers;
  bool _isLoading = true;
  bool _canSubmit = false;

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
        _initializeMarkControllers();
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

  void _initializeMarkControllers() {
    markControllers =
        List.generate(students.length, (index) => TextEditingController());
    for (var controller in markControllers) {
      controller.addListener(_checkIfAllMarksFilled);
    }
  }

  void _checkIfAllMarksFilled() {
    bool allFilled = true;
    for (var controller in markControllers) {
      if (controller.text.isEmpty) {
        allFilled = false;
        break;
      }
    }
    setState(() {
      _canSubmit = allFilled;
    });
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var controller in markControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String? _validateMarks(String? value) {
    if (value == null || value.isEmpty) {
      return 'Marks are required';
    }
    return null;
  }

  void _handleSubmit() {
    if (_canSubmit) {
      for (int i = 0; i < students.length; i++) {
        final student = students[i];
        final rollNumber = student['roll_number'];
        final marks = markControllers[i].text;

        // Store marks in Firestore
        FirebaseFirestore.instance
            .collection('users')
            .doc('students')
            .collection('students')
            .doc(student.id)
            .collection('exams')
            .doc('${widget.subject} ${widget.selectedDate}')
            .set({
          'marks': marks,
          'subject': widget.subject,
          'date': Timestamp.fromDate(DateTime.parse(widget.selectedDate)),
        }).then((value) {
          print('Marks stored successfully for roll number $rollNumber');
          // Close the bottom sheet
          Navigator.pop(context);
        }).catchError((error) {
          print('Failed to store marks for roll number $rollNumber: $error');
        });
      }
    } else {
      // Find the first empty mark field and focus on it
      for (int i = 0; i < markControllers.length; i++) {
        if (markControllers[i].text.isEmpty) {
          FocusScope.of(context).requestFocus(focusNodes[i]);
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Marks',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: _canSubmit ? Colors.green : Colors.grey,
            ),
            onPressed: _handleSubmit,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                controller: markControllers[index],
                                focusNode: focusNodes[index],
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  errorText: _canSubmit &&
                                          markControllers[index].text.isEmpty
                                      ? 'Marks are required'
                                      : null,
                                ),
                                validator: _validateMarks,
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
