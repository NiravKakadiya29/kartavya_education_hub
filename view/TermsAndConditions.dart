import 'package:flutter/material.dart';

import '../const/consts.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TermsAndConditionsPage'),
      ),
      drawer: MyDrawer(),
      body: Container(),
    );
  }
}
