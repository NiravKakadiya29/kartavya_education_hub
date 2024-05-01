import 'package:flutter/material.dart';

import '../const/consts.dart';

class LogOutPage extends StatelessWidget {
  const LogOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LogOutPage'),
      ),
      drawer: MyDrawer(),
      body: Container(
        color: Color.fromRGBO(247, 101, 243, 1),
      ),
    );
  }
}
