import 'package:flutter/material.dart';

class Lecture {
  final String subject;
  final String teacher;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  Lecture({
    required this.subject,
    required this.teacher,
    required this.startTime,
    required this.endTime,
  });
}

class Timetable {
  List<Lecture> lectures = [];

  void addLecture(Lecture lecture) {
    lectures.add(lecture);
  }

  void editLecture(int index, Lecture newLecture) {
    if (index >= 0 && index < lectures.length) {
      lectures[index] = newLecture;
    }
  }

  void deleteLecture(int index) {
    if (index >= 0 && index < lectures.length) {
      lectures.removeAt(index);
    }
  }
}

class TimetablePage extends StatefulWidget {
  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  final Timetable timetable = Timetable();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timetable'),
      ),
      body: ListView.builder(
        itemCount: timetable.lectures.length,
        itemBuilder: (context, index) {
          final lecture = timetable.lectures[index];
          return Card(
            child: ListTile(
              title: Text('${lecture.subject} - ${lecture.teacher}'),
              subtitle: Text(
                  '${lecture.startTime.format(context)} - ${lecture.endTime.format(context)}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show a dialog for adding a new lecture
          showDialog(
            context: context,
            builder: (context) {
              String _subject = '';
              String _teacher = '';
              TimeOfDay _startTime = TimeOfDay.now();
              TimeOfDay _endTime = TimeOfDay.now();

              return AlertDialog(
                title: Text('Add Lecture'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Subject'),
                      onChanged: (value) {
                        _subject = value;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Teacher'),
                      onChanged: (value) {
                        _teacher = value;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text('Start Time'),
                        ),
                        Expanded(
                          child: Text(_startTime.format(context)),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final TimeOfDay? newStartTime = await showTimePicker(
                          context: context,
                          initialTime: _startTime,
                        );
                        if (newStartTime != null) {
                          setState(() {
                            _startTime = newStartTime;
                          });
                        }
                      },
                      child: Text('Select Start Time'),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text('End Time'),
                        ),
                        Expanded(
                          child: Text(_endTime.format(context)),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final TimeOfDay? newEndTime = await showTimePicker(
                          context: context,
                          initialTime: _endTime,
                        );
                        if (newEndTime != null) {
                          setState(() {
                            _endTime = newEndTime;
                          });
                        }
                      },
                      child: Text('Select End Time'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      final newLecture = Lecture(
                        subject: _subject,
                        teacher: _teacher,
                        startTime: _startTime,
                        endTime: _endTime,
                      );
                      timetable.addLecture(newLecture);
                      Navigator.of(context).pop();
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
