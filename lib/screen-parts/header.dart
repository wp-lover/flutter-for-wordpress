import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as IsWeb;
import '../elements/styles.dart';
import 'AppDawer.dart';

class Header extends StatelessWidget {
  Widget body;

  List<Widget>? rightSide;
  bool drawer;

  Header({super.key, required this.body, required this.drawer, this.rightSide});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/");
          },
          child: const Text(
            'eSmartEnglish',
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.white, fontSize: GSPstyle.titleL),
          ),
        ),
        actions: rightSide ?? <Widget>[],
      ),
      body: body,
    );
  }
}
