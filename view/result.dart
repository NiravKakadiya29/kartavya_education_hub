import 'package:flutter/material.dart';
import '/admin/student_model.dart';
import '/admin/test_model.dart';
import '/view/student_mark_screen.dart';

class ResultPage extends StatelessWidget {
  final List<Student> students = [
    Student(
      name: 'John Doe',
      tests: [
        Test(testName: 'Math Test', marks: 0),
        Test(testName: 'Science Test', marks: 0),
        Test(testName: 'testName', marks: 50)
      ],
    ),
    Student(name: 'nk', tests: [Test(testName: 'maths', marks: 50)])
    // Add more students here
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Marks App',
      initialRoute: '/student',
      routes: {
        '/student': (context) => StudentMarkScreen(student: students[0]),
        // Add routes for more students
      },
    );
  }
}
