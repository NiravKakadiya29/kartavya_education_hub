import 'package:flutter/material.dart';

import '../const/consts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AboutPage'),
      ),
      drawer: MyDrawer(),
      body: Container(

      ),
    );
  }
}
