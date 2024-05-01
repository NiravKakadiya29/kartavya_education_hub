import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kartavya_education_hub/const/consts.dart';

import 'graph/marksprediction.dart';

class StudentPerformance {
  final String subject;
  final int score;
  final DateTime date;

  StudentPerformance({
    required this.subject,
    required this.score,
    required this.date,
  });
}

final List<StudentPerformance> studentData = [
  StudentPerformance(
    subject: 'Math',
    score: 55,
    date: DateTime(2024, 4, 7),
  ),
  StudentPerformance(
    subject: 'Math',
    score: 40,
    date: DateTime(2024, 4, 14),
  ),
  StudentPerformance(
    subject: 'Math',
    score: 40,
    date: DateTime(2024, 4, 21),
  ),
  StudentPerformance(
    subject: 'Math',
    score: 69,
    date: DateTime(2024, 4, 28),
  ),
  StudentPerformance(
    subject: 'Math',
    score: 35,
    date: DateTime(2024, 5, 2),
  ),
  StudentPerformance(
    subject: 'Math',
    score: 88,
    date: DateTime(2024, 5, 9),
  ),
  StudentPerformance(
    subject: 'Math',
    score: 75,
    date: DateTime(2024, 5, 16),
  ),
  StudentPerformance(
    subject: 'Math',
    score: 69,
    date: DateTime(2024, 5, 23),
  ),
  StudentPerformance(
    subject: 'English',
    score: 100,
    date: DateTime(2024, 4, 7),
  ),
  StudentPerformance(
    subject: 'English',
    score: 80,
    date: DateTime(2024, 4, 14),
  ),
  StudentPerformance(
    subject: 'English',
    score: 80,
    date: DateTime(2024, 4, 21),
  ),
  StudentPerformance(
    subject: 'English',
    score: 80,
    date: DateTime(2024, 4, 28),
  ),
  StudentPerformance(
    subject: 'English',
    score: 80,
    date: DateTime(2024, 5, 4),
  ),
  StudentPerformance(
    subject: 'English',
    score: 82,
    date: DateTime(2024, 5, 11),
  ),
  StudentPerformance(
    subject: 'Science',
    score: 79,
    date: DateTime(2024, 4, 7),
  ),
  StudentPerformance(
    subject: 'Science',
    score: 90,
    date: DateTime(2024, 4, 14),
  ),
  StudentPerformance(
    subject: 'Science',
    score: 44,
    date: DateTime(2024, 4, 21),
  ),
  StudentPerformance(
    subject: 'Science',
    score: 75,
    date: DateTime(2024, 4, 28),
  ),
  StudentPerformance(
    subject: 'Science',
    score: 65,
    date: DateTime(2024, 5, 4),
  ),
  StudentPerformance(
    subject: 'Science',
    score: 89,
    date: DateTime(2024, 5, 11),
  ),
  StudentPerformance(
    subject: 'Science',
    score: 80,
    date: DateTime(2024, 5, 18),
  ),
];

class StudentDashboard extends StatelessWidget {
  LineChartBarData buildLineChartBarData(String subject, Color color) {
    return LineChartBarData(
      spots: studentData
          .where((student) => student.subject == subject)
          .map((student) => FlSpot(
                student.date.millisecondsSinceEpoch.toDouble(),
                student.score.toDouble(),
              ))
          .toList(),
      color: color,
      barWidth: 4,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    final minDate = studentData
        .reduce((curr, next) =>
            curr.date.millisecondsSinceEpoch < next.date.millisecondsSinceEpoch
                ? curr
                : next)
        .date;
    final maxDate = studentData
        .reduce((curr, next) =>
            curr.date.millisecondsSinceEpoch > next.date.millisecondsSinceEpoch
                ? curr
                : next)
        .date;

    return Scaffold(
      appBar: AppBar(
        title: Text('Student Performance'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text('Math'),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text('English'),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text('Science'),
                  ),
                ),
              ],
            ),
            20.heightBox,
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.maxFinite,
                  height: 300,
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        buildLineChartBarData('Math', Colors.blue),
                        buildLineChartBarData('English', Colors.green),
                        buildLineChartBarData('Science', Colors.yellowAccent)
                      ],
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              var date = DateTime.fromMillisecondsSinceEpoch(
                                  value.toInt());
                              return Text(
                                  '${date.day}/${date.month}'); // Wrap the return value with a Text widget
                            },
                          ),
                        ),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        drawHorizontalLine: true,
                        checkToShowHorizontalLine: (value) => true,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: Colors.grey,
                          strokeWidth: 0.5,
                        ),
                        checkToShowVerticalLine: (value) => true,
                        getDrawingVerticalLine: (value) => FlLine(
                          color: Colors.grey,
                          strokeWidth: 0.5,
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      minX: minDate.millisecondsSinceEpoch.toDouble(),
                      maxX: maxDate.millisecondsSinceEpoch.toDouble(),
                      minY: 0,
                      maxY: 100,
                    ),
                  ),
                ),
              ),
            ),
            10.heightBox,
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MarksPrediction(),
                  ));
                },
                child: Text('Marks Forecasting'))
          ],
        ),
      ),
    );
  }
}

//
//
// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
//
// void main() {
//   runApp(StudentDashboard());
// }
//
// class StudentDashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Student Dashboard',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: DashboardScreen(),
//     );
//   }
// }
//
// class DashboardScreen extends StatelessWidget {
//   // Mock student exam data
//   final List<String> examDates = ['Jan 1', 'Jan 15', 'Feb 1', 'Feb 15', 'Mar 1'];
//   final List<String> subjects = ['Math', 'Science', 'History', 'English'];
//   final List<List<double>> examMarks = [
//     [85, 90, 88, 92, 87],
//     [78, 82, 80, 85, 79],
//     [92, 88, 85, 90, 91],
//     [80, 85, 82, 88, 84]
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Student Dashboard'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Overall Performance Chart
//             Container(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Overall Performance',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   Container(
//                     height: 300,
//                     child: charts.LineChart(
//                       _createOverallPerformanceData().cast<charts.Series<dynamic, num>>(),
//                       animate: true,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Subject-wise Performance Charts
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: subjects.map((subject, index) {
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '$subject Performance',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: 200,
//                         child: charts.LineChart(
//                           _createSubjectPerformanceData(index),
//                           animate: true,
//                         ),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   List<charts.Series<ExamData, String>> _createOverallPerformanceData() {
//     List<ExamData> data = [];
//
//     for (int i = 0; i < examDates.length; i++) {
//       double totalMarks = 0;
//       for (int j = 0; j < subjects.length; j++) {
//         totalMarks += examMarks[j][i];
//       }
//       data.add(ExamData(examDates[i], totalMarks));
//     }
//
//     return [
//       charts.Series<ExamData, String>(
//         id: 'Performance',
//         domainFn: (ExamData data, _) => data.date,
//         measureFn: (ExamData data, _) => data.marks,
//         data: data,
//       ),
//     ];
//   }
//
//   List<charts.Series<ExamData, String>> _createSubjectPerformanceData(int index) {
//     List<ExamData> data = [];
//
//     for (int i = 0; i < examDates.length; i++) {
//       data.add(ExamData(examDates[i], examMarks[index][i]));
//     }
//
//     return [
//       charts.Series<ExamData, String>(
//         id: 'Performance',
//         domainFn: (ExamData data, _) => data.date,
//         measureFn: (ExamData data, _) => data.marks,
//         data: data,
//       ),
//     ];
//   }
// }
//
// class ExamData {
//   final String date;
//   final double marks;
//
//   ExamData(this.date, this.marks);
// }
