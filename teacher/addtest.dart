import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kartavya_education_hub/teacher/addmarks.dart';

import '../const/consts.dart';

class AddTest extends StatefulWidget {
  const AddTest({Key? key}) : super(key: key);

  @override
  State<AddTest> createState() => _AddTestState();
}

class _AddTestState extends State<AddTest> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _subjectFocusNode = FocusNode();
  TextEditingController _subjectController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? selectedClass; // Declare selectedClass variable

  List<String> standardClass = [];

  Future<List<String>> getClass() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc("students")
          .collection("students")
          .orderBy('class')
          .get();
      snapshot.docs.forEach((doc) {
        print("the id is ${doc.id}");
        standardClass.add(doc['class']);
      });
    } catch (e) {
      print('Error fetching document IDs: $e');
    }
    return standardClass.toSet().toList();
  }

  @override
  void initState() {
    super.initState();
    selectedClass = null; // Initialize selectedClass
    initializeData();
  }

  Future<void> initializeData() async {
    List<String> classes = await getClass();
    setState(() {
      standardClass = classes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _customDate =
        DateFormat('dd MMMM yyyy').format(_selectedDate).toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Information',
          style: TextStyle(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height *
            0.80, // Set the height to 75% of the screen height
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20.0),
                DropdownButtonFormField<String>(
                  value: selectedClass,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedClass = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a class';
                    }
                    return null;
                  },
                  items: standardClass
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          value,
                        ),
                      ),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Select Class',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Test Date:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2024),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                  child: Text(
                    _selectedDate == ""
                        ? 'Select Date'
                        : DateFormat('dd MMMM yyyy')
                            .format(_selectedDate)
                            .toString(),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: _subjectController,
                  focusNode: _subjectFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Subject is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Subject'),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print(selectedClass);
                      print(_customDate);
                      print(_subjectController.text);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddMarks(
                          selectedClass: selectedClass.toString(),
                          selectedDate: _customDate,
                          subject: _subjectController.text,
                        ),
                      ));
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
