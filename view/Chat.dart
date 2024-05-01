import 'package:flutter/material.dart';

import '../const/consts.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatPage'),
      ),
      drawer: MyDrawer(),
      body: Container(
        color: Color.fromRGBO(247, 101, 243, 1),
      ),
    );
  }
}
