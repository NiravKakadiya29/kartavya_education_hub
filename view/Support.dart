import 'package:flutter/material.dart';

import '../const/consts.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SupportPage'),
      ),
      drawer: MyDrawer(),
      body: Container(),
    );
  }
}
