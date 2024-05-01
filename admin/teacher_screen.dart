import 'package:flutter/material.dart';
import '/admin/student_model.dart';

class TeacherScreen extends StatefulWidget {
  final List<Student> students;

  TeacherScreen({required this.students});

  @override
  _TeacherScreenState createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Marks - Teacher'),
      ),
      body: ListView.builder(
        itemCount: widget.students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.students[index].name),
            subtitle: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                widget.students[index].tests[0].marks = double.parse(value);
              },
            ),
          );
        },
      ),
    );
  }
}
