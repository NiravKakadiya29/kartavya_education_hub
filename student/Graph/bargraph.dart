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
        title: Text('Student Performance Dashboard'),
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
              return StudentPerformanceDashboard(performances: performances);
            }
          }
        },
      ),
    );
  }
}

class StudentPerformanceDashboard extends StatelessWidget {
  final List<StudentPerformance> performances;

  StudentPerformanceDashboard({required this.performances});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Student Performance Summary',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: StudentPerformanceGraph(performances: performances),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Performance Insights',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: PerformanceInsights(performances: performances),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Performance Forecasting',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: PerformanceForecast(performances: performances),
          ),
        ],
      ),
    );
  }
}

class PerformanceInsights extends StatelessWidget {
  final List<StudentPerformance> performances;

  PerformanceInsights({required this.performances});

  @override
  Widget build(BuildContext context) {
    // Calculate average, highest, and lowest marks for all subjects
    Map<String, List<int>> subjectMarks = {};
    performances.forEach((performance) {
      if (!subjectMarks.containsKey(performance.subject)) {
        subjectMarks[performance.subject] = [];
      }
      subjectMarks[performance.subject]!.add(performance.marks);
    });

    Map<String, dynamic> insights = {};

    subjectMarks.forEach((subject, marks) {
      // Calculate average marks
      double averageMarks =
          marks.isNotEmpty ? marks.reduce((a, b) => a + b) / marks.length : 0;

      // Calculate highest marks
      int highestMarks =
          marks.isNotEmpty ? marks.reduce((a, b) => a > b ? a : b) : 0;

      // Calculate lowest marks
      int lowestMarks =
          marks.isNotEmpty ? marks.reduce((a, b) => a < b ? a : b) : 0;

      // Add more insights here as needed

      insights[subject] = {
        'averageMarks': averageMarks,
        'highestMarks': highestMarks,
        'lowestMarks': lowestMarks,
        // Add more insights here as needed
      };
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance Insights by Subject',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        // Display insights for each subject
        ...insights.entries.map((entry) {
          String subject = entry.key;
          Map<String, dynamic> data = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Subject: $subject',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text('Average Marks: ${data['averageMarks'].toStringAsFixed(2)}'),
              Text('Highest Marks: ${data['highestMarks']}'),
              Text('Lowest Marks: ${data['lowestMarks']}'),
              Divider(), // Add a divider between subjects
            ],
          );
        }).toList(),
      ],
    );
  }
}

class PerformanceForecast extends StatelessWidget {
  final List<StudentPerformance> performances;

  PerformanceForecast({required this.performances});

  @override
  Widget build(BuildContext context) {
    Map<String, List<StudentPerformance>> performancesBySubject = {};

    // Group performances by subject
    performances.forEach((performance) {
      if (!performancesBySubject.containsKey(performance.subject)) {
        performancesBySubject[performance.subject] = [];
      }
      performancesBySubject[performance.subject]!.add(performance);
    });

    Map<String, double> forecastedMarks = {};

    performancesBySubject.forEach((subject, performances) {
      // Prepare data for linear regression for each subject
      List<List<double>> data = [];
      performances.forEach((performance) {
        data.add([
          performance.date.millisecondsSinceEpoch.toDouble(),
          performance.marks.toDouble()
        ]);
      });

      // Perform linear regression for each subject
      final model = SimpleLinearRegression(data);

      // Forecast performance for next period for each subject
      DateTime nextDate = DateTime.now()
          .add(Duration(days: 30)); // For example, forecast for next 30 days
      double forecastedMark =
          model.predict(nextDate.millisecondsSinceEpoch.toDouble());

      forecastedMarks[subject] = forecastedMark;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance Forecast for All Subjects',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        // Display forecasts for each subject
        ...forecastedMarks.entries.map((entry) {
          String subject = entry.key;
          double forecastedMark = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Subject: $subject',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Forecasted Marks for Next Period: ${forecastedMark.toStringAsFixed(2)}',
              ),
              Divider(), // Add a divider between subjects
            ],
          );
        }).toList(),
      ],
    );
  }
}

// Simple Linear Regression Implementation
class SimpleLinearRegression {
  final List<List<double>> data;
  late double slope;
  late double intercept;

  SimpleLinearRegression(this.data) {
    fit();
  }

  void fit() {
    double xSum = 0;
    double ySum = 0;
    double xySum = 0;
    double xSquareSum = 0;

    for (var i = 0; i < data.length; i++) {
      double x = data[i][0];
      double y = data[i][1];

      xSum += x;
      ySum += y;
      xySum += x * y;
      xSquareSum += x * x;
    }

    slope = ((data.length * xySum) - (xSum * ySum)) /
        ((data.length * xSquareSum) - (xSum * xSum));
    intercept = (ySum - (slope * xSum)) / data.length;
  }

  double predict(double x) {
    return (slope * x) + intercept;
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

    return Column(
      children: charts,
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

/*


// this is second model in this graph change frequntly when data chenge into database then dirtly change into this

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
 */
