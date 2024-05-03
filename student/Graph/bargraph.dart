import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as chart; // renamed the import
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentPerformanceBarPage extends StatefulWidget {
  @override
  _StudentPerformanceBarPageState createState() =>
      _StudentPerformanceBarPageState();
}

class _StudentPerformanceBarPageState extends State<StudentPerformanceBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Performance Graph'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc('students')
            .collection('students')
            //.doc(mobileNumber) // Replace mobileNumber with your variable
            .doc('9879315796') // Replace mobileNumber with your variable
            .collection('exams')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<StudentPerformance> performances = [];
              snapshot.data!.docs.forEach((doc) {
                performances.add(StudentPerformance(
                  subject: doc['subject'],
                  marks: int.parse(doc['marks']),
                  date: DateFormat('dd MM yyyy').parse(doc['date']),
                  totalmarks: int.parse(doc['total']),
                ));
              });
              return StudentPerformanceGraph(performances: performances);
            }
          }
        },
      ),
    );
  }
}

class StudentPerformanceGraph extends StatelessWidget {
  final List<StudentPerformance> performances;

  StudentPerformanceGraph({required this.performances});

  @override
  Widget build(BuildContext context) {
    Map<int, List<StudentPerformance>> performancesByTotal = {};

    // Group performances by total marks
    performances.forEach((performance) {
      int total = performance.totalmarks;
      if (!performancesByTotal.containsKey(total)) {
        performancesByTotal[total] = [];
      }
      performancesByTotal[total]!.add(performance);
    });

    // Create a list of bar charts for each group of performances with the same total marks
    List<Widget> charts = [];
    performancesByTotal.forEach((total, performances) {
      List<chart.Series<StudentPerformance, String>> seriesList = [];
      performances.forEach((performance) {
        seriesList.add(chart.Series<StudentPerformance, String>(
          id: performance.subject,
          data: [performance],
          domainFn: (_, __) => performance.subject,
          measureFn: (performance, _) => performance.marks,
        ));
      });

      charts.add(
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Total Marks: $total',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 200,
                child: chart.BarChart(
                  seriesList,
                  animate: true,
                  vertical: false,
                  barRendererDecorator: chart.BarLabelDecorator<String>(),
                  domainAxis: chart.OrdinalAxisSpec(
                    renderSpec: chart.SmallTickRendererSpec(labelRotation: 45),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });

    return SingleChildScrollView(
      child: Column(
        children: charts,
      ),
    );
  }
}

class StudentPerformance {
  final String subject;
  final int marks;
  final int totalmarks;
  final DateTime date;

  StudentPerformance({
    required this.totalmarks,
    required this.subject,
    required this.marks,
    required this.date,
  });
}
