// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:tuple/tuple.dart';
//
// class StudentPerformance {
//   final String subject;
//   final int score;
//   final DateTime date;
//
//   StudentPerformance({
//     required this.subject,
//     required this.score,
//     required this.date,
//   });
// }
//
// final List<StudentPerformance> studentData = [
//   StudentPerformance(
//     subject: 'Math',
//     score: 79,
//     date: DateTime(2024, 4, 1),
//   ),
//   StudentPerformance(
//     subject: 'Math',
//     score: 80,
//     date: DateTime(2024, 4, 3),
//   ),
//   StudentPerformance(
//     subject: 'Math',
//     score: 81,
//     date: DateTime(2024, 4, 5),
//   ),
//   StudentPerformance(
//     subject: 'Math',
//     score: 82,
//     date: DateTime(2024, 4, 7),
//   ),
//   StudentPerformance(
//     subject: 'Math',
//     score: 83,
//     date: DateTime(2024, 4, 9),
//   ),
//   StudentPerformance(
//     subject: 'Math',
//     score: 84,
//     date: DateTime(2024, 4, 11),
//   ),
//   StudentPerformance(
//     subject: 'Math',
//     score: 85,
//     date: DateTime(2024, 4, 13),
//   ),
//   StudentPerformance(
//     subject: 'Math',
//     score: 86,
//     date: DateTime(2024, 4, 15),
//   ),
//   StudentPerformance(
//     subject: 'English',
//     score: 100,
//     date: DateTime(2024, 4, 1),
//   ),
//   StudentPerformance(
//     subject: 'English',
//     score: 80,
//     date: DateTime(2024, 4, 5),
//   ),
//   StudentPerformance(
//     subject: 'English',
//     score: 80,
//     date: DateTime(2024, 4, 8),
//   ),
//   StudentPerformance(
//     subject: 'English',
//     score: 80,
//     date: DateTime(2024, 4, 10),
//   ),
//   StudentPerformance(
//     subject: 'English',
//     score: 80,
//     date: DateTime(2024, 4, 13),
//   ),
//   StudentPerformance(
//     subject: 'English',
//     score: 82,
//     date: DateTime(2024, 4, 20),
//   ),
//   StudentPerformance(
//     subject: 'Science',
//     score: 79,
//     date: DateTime(2024, 4, 3),
//   ),
//   StudentPerformance(
//     subject: 'Science',
//     score: 90,
//     date: DateTime(2024, 4, 5),
//   ),
//   StudentPerformance(
//     subject: 'Science',
//     score: 44,
//     date: DateTime(2024, 4, 7),
//   ),
//   StudentPerformance(
//     subject: 'Science',
//     score: 50,
//     date: DateTime(2024, 4, 9),
//   ),
//   StudentPerformance(
//     subject: 'Science',
//     score: 53,
//     date: DateTime(2024, 4, 11),
//   ),
//   StudentPerformance(
//     subject: 'Science',
//     score: 89,
//     date: DateTime(2024, 4, 14),
//   ),
//   StudentPerformance(
//     subject: 'Science',
//     score: 85,
//     date: DateTime(2024, 4, 18),
//   ),
// ];
// class StudentDashboard extends StatelessWidget {
//   List<Tuple2<DateTime, double>> predictFutureScores(List<StudentPerformance> data, String subject) {
//     // Filter data by subject
//     var subjectData = data.where((student) => student.subject == subject).toList();
//
//     if (subjectData.isEmpty) {
//       // Return an empty list if no data is available for the subject
//       return [];
//     }
//
//     // Sort data by date
//     subjectData.sort((a, b) => a.date.compareTo(b.date));
//
//     // Find the maximum date for the subject
//     var maxDate = subjectData.reduce((curr, next) =>
//     curr.date.millisecondsSinceEpoch > next.date.millisecondsSinceEpoch
//         ? curr
//         : next).date;
//
//     // Convert dates to milliseconds for easier calculations
//     var dates = subjectData.map((student) => student.date.millisecondsSinceEpoch.toDouble()).toList();
//
//     // Convert scores to doubles for regression
//     var scores = subjectData.map((student) => student.score.toDouble()).toList();
//
//     // Fit a simple linear regression model
//     var model = LinearRegression(dates, scores);
//
//     // Predict future scores for the next 30 days
//     var startDate =maxDate;
//     var endDate = startDate.add(Duration(days: 30));
//     var predictedScores = <Tuple2<DateTime, double>>[];
//     for (var date = startDate; date.isBefore(endDate); date = date.add(Duration(days: 3))) {
//       var prediction = model.predict(date.millisecondsSinceEpoch.toDouble());
//       predictedScores.add(Tuple2(date, prediction));
//     }
//
//     // Calculate the minX value based on the maximum date for the subject
//     var minX = maxDate.millisecondsSinceEpoch.toDouble();
//
//     return predictedScores;
//   }
//
//   LineChartBarData buildLineChartBarData(List<Tuple2<DateTime, double>> data, Color color) {
//     return LineChartBarData(
//       spots: data.map((tuple) => FlSpot(tuple.item1.millisecondsSinceEpoch.toDouble(), tuple.item2)).toList(),
//       color: color,
//       barWidth: 4,
//       isStrokeCapRound: true,
//       belowBarData: BarAreaData(show: false),
//     );
//   }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     //   final minDate = studentData.reduce((curr, next) =>
//     //   curr.date.millisecondsSinceEpoch < next.date.millisecondsSinceEpoch
//     //       ? curr
//     //       : next).date;
//     //   final maxDate = studentData.reduce((curr, next) =>
//     //   curr.date.millisecondsSinceEpoch > next.date.millisecondsSinceEpoch
//     //       ? curr
//     //       : next).date;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Student Performance'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: _buildLineChart('Math', Colors.blue),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: _buildLineChart('English', Colors.green),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: _buildLineChart('Science', Colors.yellowAccent),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLineChart(String subject, Color color) {
//     var data = predictFutureScores(studentData, subject);
//     return LineChart(
//       LineChartData(
//         lineBarsData: [
//           buildLineChartBarData(data, color),
//
//         ],
//         titlesData: FlTitlesData(
//           leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false,)),
//           bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,
//             getTitlesWidget: (value, meta) {
//               var date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
//               return Text('${date.day}/${date.month}'); // Wrap the return value with a Text widget
//             },
//           ),),
//     topTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
//     return Text(subject);
//     })),
//
//
//
//         ),
//         gridData: FlGridData(
//           show: true,
//           drawVerticalLine: true,
//           drawHorizontalLine: true,
//           checkToShowHorizontalLine: (value) => true,
//           getDrawingHorizontalLine: (value) => FlLine(
//             color: Colors.grey,
//             strokeWidth: 0.5,
//           ),
//           checkToShowVerticalLine: (value) => true,
//           getDrawingVerticalLine: (value) => FlLine(
//             color: Colors.grey,
//             strokeWidth: 0.5,
//           ),
//         ),
//         borderData: FlBorderData(
//           show: true,
//           border: Border.all(
//             color: Colors.black,
//             width: 1,
//           ),
//         ),
//
//         minX: data.isEmpty ? 0 : data.first.item1.millisecondsSinceEpoch.toDouble(),
//         maxX: data.isEmpty ? 0 : data.last.item1.millisecondsSinceEpoch.toDouble(),
//
//         // minX: DateTime.now().millisecondsSinceEpoch.toDouble(),
//         // maxX: DateTime.now().add(Duration(days: 30)).millisecondsSinceEpoch.toDouble(),
//         minY: 0,
//         maxY: 100,
//       ),
//     );
//   }}
//
//
//   class LinearRegression {
//   final List<double> x;
//   final List<double> y;
//
//   LinearRegression(this.x, this.y);
//
//   double predict(double input) {
//   double meanX = x.reduce((a, b) => a + b) / x.length;
//   double meanY = y.reduce((a, b) => a + b) / y.length;
//
//   double numerator = 0;
//   double denominator = 0;
//
//   for (var i = 0; i < x.length; i++) {
//   numerator += (x[i] - meanX) * (y[i] - meanY);
//   denominator += (x[i] - meanX) * (x[i] - meanX);
//   }
//
//   double slope = numerator / denominator;
//   double intercept = meanY - slope * meanX;
//
//   return slope * input + intercept;
//   }
//   }

// return FutureBuilder<DocumentSnapshot>(
// future: getDocument(),
// builder: (context, snapshot) {
// if (snapshot.connectionState == ConnectionState.waiting) {
// return CircularProgressIndicator(); // Show loading indicator
// }
//
// if (snapshot.hasError) {
// return Text('Error: ${snapshot.error}');
// }
//
// if (!snapshot.hasData || !snapshot.data.exists) {
// return Text('Document does not exist');
// }
//
// // Extract data from the document snapshot
// var data = snapshot.data.data();
//
// // Display the data
// returnScaffold(
// appBar: AppBar(
// title: Text('My Profile'),
// actions: [
// IconButton(
// icon: Icon(Icons.edit),
// onPressed: () {
// _navigateToEditProfileScreen(context);
// },
// ),
// ],
// ),
// body: SingleChildScrollView(
// padding: EdgeInsets.all(20.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// CircleAvatar(
// radius: 50,
// backgroundImage: AssetImage('./lib/assets/images/student.png'),
// ),
// SizedBox(height: 20),
// Text(
// 'Name:',
// style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// ),
// Text(
// userProfile.name,
// style: TextStyle(fontSize: 16),
// ),
// SizedBox(height: 20),
// Text(
// 'Email:',
// style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// ),
// Text(
// userProfile.email,
// style: TextStyle(fontSize: 16),
// ),
// SizedBox(height: 20),
// Text(
// 'Phone Number:',
// style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// ),
// Text(
// userProfile.phoneNumber,
// style: TextStyle(fontSize: 16),
// ),
// SizedBox(height: 20),
// Text(
// 'Address:',
// style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// ),
// Text(
// userProfile.address,
// style: TextStyle(fontSize: 16),
// ),
// SizedBox(height: 20),
// Text(
// 'Date of Birth:',
// style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// ),
// Text(
// "${userProfile.dateOfBirth.toLocal()}".split(' ')[0],
// style: TextStyle(fontSize: 16),
// ),
// SizedBox(height: 20),
// Text(
// 'Gender:',
// style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// ),
// Text(
// userProfile.gender,
// style: TextStyle(fontSize: 16),
// ),
// SizedBox(height: 20),
// Text(
// 'Occupation:',
// style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// ),
// Text(
// userProfile.occupation,
// style: TextStyle(fontSize: 16),
// ),
// ],
// ),
// ),
// );
// },
// );
