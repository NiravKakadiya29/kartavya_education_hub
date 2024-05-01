import 'package:flutter/material.dart';

import '../const/consts.dart';

class TimeTablePage extends StatelessWidget {
  const TimeTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TimeTablePage'),
      ),
      drawer: MyDrawer(),
      body: Container(),
    );
  }
}
