import 'package:flutter/material.dart';
import '/admin/student_model.dart';
import '/widgets/Drawer.dart';

class StudentMarkScreen extends StatelessWidget {
  final Student student;

  StudentMarkScreen({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Marks - Student'),
      ),
      drawer: MyDrawer(),
      body: ListView.builder(
        itemCount: student.tests.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(student.tests[index].testName),
            // subtitle: Text('${dat}'),
            trailing: Text('${student.tests[index].marks} / 50'),
          );
        },
      ),
    );
  }
}
