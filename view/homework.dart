import 'package:flutter/material.dart';
import 'dart:async';

class Homework {
  final String subject;
  final String description;
  final String dueDate;

  Homework(
      {required this.subject,
      required this.description,
      required this.dueDate});
}

class HomeworkPage extends StatefulWidget {
  @override
  _HomeworkPageState createState() => _HomeworkPageState();
}

class _HomeworkPageState extends State<HomeworkPage> {
  late Future<List<Homework>> _homeworkFuture;

  @override
  void initState() {
    super.initState();
    _homeworkFuture = _fetchHomework();
  }

  Future<List<Homework>> _fetchHomework() async {
    // Replace this with your own API call to fetch the homework data from the server
    await Future.delayed(Duration(seconds: 2));
    return [
      Homework(
        subject: 'Math',
        description: 'Complete the assigned reading for chapter 3',
        dueDate: '16 sep',
      ),
      Homework(
        subject: 'Math',
        description: 'Solve the problems at the end of chapter 3',
        dueDate: '16 sep',
      ),
      Homework(
        subject: 'Math',
        description: 'Write a one-page summary of chapter 5',
        dueDate: '26 sep',
      ),
      Homework(
        subject: 'Math',
        description: 'Write a one-page summary of chapter 15',
        dueDate: '1 sep',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homework'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Announcement block
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Announcement',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.notifications,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),

            // Homework Information
            Expanded(
              child: FutureBuilder<List<Homework>>(
                future: _homeworkFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Homework ${index + 1}',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Subject: ${snapshot.data![index].subject}',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  snapshot.data![index].description,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Due Date: ${snapshot.data![index].dueDate}',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
